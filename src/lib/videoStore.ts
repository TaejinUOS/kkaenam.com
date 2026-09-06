/**
 * 운영자 선별 영상 (PRD 5.3.2, FR-10).
 *
 * 영상은 챔피언 하나에 매달린다 (마이그레이션 0011). 배치나 포지션과 무관하므로
 * 운영자가 분류를 아무리 고쳐도 등록해 둔 영상은 제자리에 있다 — 문서가 그런 것과
 * 같은 성질이다 (마이그레이션 0003).
 *
 * 제목과 채널 이름은 **등록할 때 한 번** 유튜브에서 받아 D1에 박아 둔다. 화면을 그릴
 * 때마다 물어보면 영상 탭의 응답 시간이 남의 서비스에 매이고, 그쪽이 느리거나 죽으면
 * 우리 화면도 함께 빈다.
 */

import "server-only";

import { getCloudflareContext } from "@opennextjs/cloudflare";

import { getChampionBySlug } from "@/data/champions";

import { parseYouTubeId } from "./youtube";

async function db() {
  const { env } = await getCloudflareContext({ async: true });
  return env.DB;
}

/** 화면에 그릴 영상 하나. 썸네일·임베드 주소는 `videoId`에서 유도한다. */
export type VideoView = {
  id: string;
  videoId: string;
  title: string;
  author: string | null;
};

/** 관리자 목록의 한 줄. 게시 상태와 등록 정보가 더 붙는다. */
export type VideoAdminRow = VideoView & {
  championSlug: string;
  published: boolean;
  addedAt: string;
  addedByName: string | null;
};

type Row = {
  id: string;
  champion_slug: string;
  video_id: string;
  title: string;
  author: string | null;
  published: number;
  added_at: string;
  added_by_name: string | null;
};

function toView(row: Row): VideoView {
  return { id: row.id, videoId: row.video_id, title: row.title, author: row.author };
}

// ------------------------------------------------------------------- 읽기

/**
 * 한 챔피언의 게시된 영상. 영상 탭이 쓴다.
 *
 * 표가 아직 없는 환경에서도 화면이 서야 한다. 마이그레이션을 적용하지 않은 로컬
 * D1에서 상대법 페이지 **전체가** 500으로 죽는 것은, 영상 탭이 비어 보이는 것보다
 * 훨씬 나쁘다. 그래서 조회 실패는 빈 목록으로 삼킨다.
 */
export async function listVideosFor(championSlug: string): Promise<VideoView[]> {
  try {
    const DB = await db();
    const rows = await DB.prepare(
      `SELECT id, champion_slug, video_id, title, author, published, added_at,
              NULL AS added_by_name
         FROM champion_videos
        WHERE champion_slug = ?1 AND published = 1
        ORDER BY sort_order, added_at`,
    )
      .bind(championSlug)
      .all<Row>();
    return (rows.results ?? []).map(toView);
  } catch {
    return [];
  }
}

/**
 * 등록된 영상 전부. 관리자 화면이 쓴다.
 *
 * 챔피언별로 쪼개 부르지 않는다. 운영자가 가장 먼저 알고 싶은 것은 "지금까지 무엇을
 * 넣었나"이고, 그건 챔피언을 하나씩 골라 봐서는 알 수 없다. 수백 행 규모라 한 번에
 * 읽어도 값이 싸다.
 */
export async function listAllVideos(): Promise<VideoAdminRow[]> {
  const DB = await db();
  const rows = await DB.prepare(
    `SELECT v.id, v.champion_slug, v.video_id, v.title, v.author, v.published, v.added_at,
            u.name AS added_by_name
       FROM champion_videos v
       LEFT JOIN users u ON u.id = v.added_by
      ORDER BY v.champion_slug, v.sort_order, v.added_at`,
  ).all<Row>();

  return (rows.results ?? []).map((row) => ({
    ...toView(row),
    championSlug: row.champion_slug,
    published: row.published === 1,
    addedAt: row.added_at,
    addedByName: row.added_by_name,
  }));
}

// ------------------------------------------------------------------- 쓰기

export type VideoError =
  | "champion" // 카탈로그에 없는 챔피언
  | "url" // 유튜브 주소로 읽을 수 없음
  | "duplicate" // 이 챔피언에 이미 있는 영상
  | "title"; // 제목을 자동으로도 못 받고 직접 적지도 않음

export type VideoResult = { ok: true } | { ok: false; error: VideoError };

/**
 * 유튜브 oEmbed로 제목과 채널 이름을 받아 온다. 실패하면 null.
 *
 * 공개 엔드포인트라 API 키가 필요 없다. 비공개·삭제·임베드 금지 영상이면 4xx가
 * 오는데, 그것 자체가 **등록하면 안 되는 영상이라는 신호**라 그대로 실패로 둔다.
 * 다만 운영자가 제목을 직접 적었다면 여기까지 오지 않는다 — 유튜브가 잠깐 느린 것과
 * 영상이 잘못된 것을 우리가 확실히 구분할 수는 없기 때문이다.
 */
async function fetchOEmbed(
  videoId: string,
): Promise<{ title: string; author: string | null } | null> {
  const target = `https://www.youtube.com/oembed?format=json&url=${encodeURIComponent(
    `https://www.youtube.com/watch?v=${videoId}`,
  )}`;

  try {
    /* 등록 화면이 유튜브 응답을 기다리다 멈추지 않게 한다. */
    const response = await fetch(target, { signal: AbortSignal.timeout(5000) });
    if (!response.ok) return null;

    const data = (await response.json()) as { title?: unknown; author_name?: unknown };
    const title = typeof data.title === "string" ? data.title.trim() : "";
    if (!title) return null;

    const author = typeof data.author_name === "string" ? data.author_name.trim() : "";
    return { title, author: author || null };
  } catch {
    return null;
  }
}

/**
 * 영상을 챔피언에 붙인다. 순서는 맨 뒤로 간다.
 *
 * 채널은 가리지 않는다. 어차피 운영자가 하나씩 보고 넣는 것이라, 좋은 상대법 영상이
 * 다른 채널에 있을 때 넣을 수 없는 쪽이 손해다 (PRD 15 미결정 9번에 대한 결정).
 *
 * @param manualTitle 운영자가 직접 적은 제목. 비어 있으면 유튜브에서 받아 온다.
 */
export async function addVideo(
  championSlug: string,
  url: string,
  manualTitle: string,
  actorId: string,
): Promise<VideoResult> {
  if (!getChampionBySlug(championSlug)) return { ok: false, error: "champion" };

  const videoId = parseYouTubeId(url);
  if (!videoId) return { ok: false, error: "url" };

  const typed = manualTitle.trim();
  const fetched = typed ? null : await fetchOEmbed(videoId);
  const title = typed || fetched?.title;
  if (!title) return { ok: false, error: "title" };

  const DB = await db();
  const last = await DB.prepare(
    `SELECT COALESCE(MAX(sort_order), 0) AS n FROM champion_videos WHERE champion_slug = ?1`,
  )
    .bind(championSlug)
    .first<{ n: number }>();

  /*
   * 중복은 유일 인덱스가 막는다. 미리 SELECT로 확인하지 않는 것은, 확인과 삽입
   * 사이에 다른 운영자가 같은 영상을 넣을 수 있어 어차피 여기서 한 번 더 걸러야
   * 하기 때문이다. 한 곳에서만 막는다.
   */
  try {
    await DB.prepare(
      `INSERT INTO champion_videos
         (id, champion_slug, provider, video_id, title, author, published, sort_order,
          added_at, added_by)
       VALUES (?1, ?2, 'youtube', ?3, ?4, ?5, 1, ?6, ?7, ?8)`,
    )
      .bind(
        crypto.randomUUID(),
        championSlug,
        videoId,
        title.slice(0, 200),
        fetched?.author ?? null,
        (last?.n ?? 0) + 1,
        new Date().toISOString(),
        actorId,
      )
      .run();
  } catch (cause) {
    if (String(cause).includes("UNIQUE")) return { ok: false, error: "duplicate" };
    throw cause;
  }

  return { ok: true };
}

export async function removeVideo(id: string): Promise<void> {
  const DB = await db();
  await DB.prepare(`DELETE FROM champion_videos WHERE id = ?1`).bind(id).run();
}

/**
 * 게시·비게시를 바꾼다.
 *
 * 지우기와 따로 두는 이유는, 영상이 잠깐 문제가 되었을 때(패치로 낡음, 원본이 비공개로
 * 바뀜) 되돌릴 여지를 남기기 위해서다. 지운 영상은 주소를 다시 찾아와야 한다.
 */
export async function setVideoPublished(id: string, published: boolean): Promise<void> {
  const DB = await db();
  await DB.prepare(`UPDATE champion_videos SET published = ?1 WHERE id = ?2`)
    .bind(published ? 1 : 0, id)
    .run();
}

/**
 * 한 챔피언 안에서 영상을 한 칸 옮긴다.
 *
 * `champion_placements`의 순서 바꾸기와 같은 방식이다 — 맞바꾸기가 아니라 그 챔피언의
 * 순서를 통째로 `1..n`으로 다시 쓴다. 같은 `sort_order`가 여럿일 때 맞바꾸기는 조용히
 * 아무것도 하지 않는데, 한 챔피언의 영상은 많아야 열 몇 개라 전부 다시 쓰는 값이 싸다.
 */
export async function moveVideo(id: string, direction: "up" | "down"): Promise<void> {
  const DB = await db();
  const target = await DB.prepare(`SELECT champion_slug FROM champion_videos WHERE id = ?1`)
    .bind(id)
    .first<{ champion_slug: string }>();
  if (!target) return;

  const rows = await DB.prepare(
    `SELECT id FROM champion_videos WHERE champion_slug = ?1 ORDER BY sort_order, added_at`,
  )
    .bind(target.champion_slug)
    .all<{ id: string }>();

  const order = (rows.results ?? []).map((r) => r.id);
  const at = order.indexOf(id);
  if (at < 0) return;

  const to = direction === "up" ? at - 1 : at + 1;
  /* 끝에서 한 번 더 누른 것은 오류가 아니다. 아무 일도 일어나지 않으면 된다. */
  if (to < 0 || to >= order.length) return;
  [order[at], order[to]] = [order[to], order[at]];

  await DB.batch(
    order.map((videoRowId, index) =>
      DB.prepare(`UPDATE champion_videos SET sort_order = ?1 WHERE id = ?2`).bind(
        index + 1,
        videoRowId,
      ),
    ),
  );
}
