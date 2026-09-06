import type { Metadata } from "next";
import Link from "next/link";

import { allChampions, getChampionBySlug } from "@/data/champions";
import {
  addVideoAction,
  moveVideoAction,
  removeVideoAction,
  setVideoPublishedAction,
} from "@/lib/actions/videoActions";
import { requirePageAdmin } from "@/lib/authGuard";
import { type VideoAdminRow, listAllVideos } from "@/lib/videoStore";
import { youTubeThumbnailUrl, youTubeWatchUrl } from "@/lib/youtube";

import styles from "./page.module.css";

export const metadata: Metadata = { title: "영상 등록", robots: { index: false, follow: false } };

const DONE_LABEL: Record<string, string> = {
  added: "등록했습니다.",
  removed: "지웠습니다.",
  hidden: "감췄습니다. 목록에는 남아 있어 언제든 다시 보일 수 있습니다.",
  shown: "다시 보이게 했습니다.",
};

/**
 * 등록이 막힌 이유는 각각 다음 손이 다르다. 그래서 한 문구로 뭉치지 않는다 —
 * "실패했습니다"만 보면 운영자는 같은 주소를 한 번 더 붙여 넣게 된다.
 */
const ERROR_LABEL: Record<string, string> = {
  champion: "카탈로그에 없는 챔피언입니다.",
  url: "유튜브 주소로 읽을 수 없습니다. 영상 주소나 11자 영상 ID를 넣어 주세요.",
  duplicate: "이 챔피언에 이미 등록된 영상입니다.",
  title:
    "제목을 유튜브에서 가져오지 못했습니다. 비공개·삭제된 영상이 아닌지 확인하고, 맞다면 제목을 직접 적어 주세요.",
};

type SearchParams = { champion?: string; done?: string; error?: string };

/**
 * 운영자 선별 영상 등록 (PRD 5.3.2, 미결정 9번 "등록·검수 주체" = 운영자).
 *
 * 영상은 챔피언 하나에 붙는다 (마이그레이션 0011). 포지션을 고르지 않는 것은 문서가
 * 그렇기 때문이다 — 럭스 문서는 하나인데 영상만 미드·서폿으로 갈리면, 같은 화면에서
 * 문서와 영상이 서로 다른 단위로 말하게 된다.
 *
 * 제목은 붙여 넣은 주소로 유튜브 oEmbed를 한 번 불러 채운다. 운영자가 직접 적으면
 * 그 값이 이긴다 — 원본 제목이 낚시성이거나 무엇에 대한 영상인지 안 보이는 경우가 있다.
 */
export default async function AdminVideosPage({
  searchParams,
}: {
  searchParams: Promise<SearchParams>;
}) {
  await requirePageAdmin();

  const { champion: championParam, done, error } = await searchParams;
  const selected = getChampionBySlug(championParam ?? "")?.slug ?? "";

  const videos = await listAllVideos();

  /** 챔피언별로 묶는다. `listAllVideos`가 이미 챔피언·순서로 정렬해 준다. */
  const byChampion = new Map<string, VideoAdminRow[]>();
  for (const row of videos) {
    byChampion.set(row.championSlug, [...(byChampion.get(row.championSlug) ?? []), row]);
  }

  /*
   * 방금 손댄 챔피언을 맨 위로 올린다. 등록하고 나서 그 영상이 어디 들어갔는지
   * 찾으러 목록을 훑어야 한다면 화면이 일을 하지 않는 것이다.
   */
  const groups = [...byChampion.entries()].sort(([a], [b]) => {
    if (a === selected) return -1;
    if (b === selected) return 1;
    return (getChampionBySlug(a)?.name ?? a).localeCompare(getChampionBySlug(b)?.name ?? b, "ko");
  });

  return (
    <div className={`shell ${styles.screen}`}>
      <p className="section-index">관리자</p>
      <h1 className={`display ${styles.title}`}>영상 등록</h1>
      <p className={styles.lead}>
        상대법 페이지의 <strong>영상</strong> 탭에 보일 유튜브 영상을 등록합니다. 제목과 채널
        이름은 등록할 때 한 번 받아 저장하므로, 유튜브에서 제목이 바뀌어도 여기 적힌 값이
        그대로 남습니다.
      </p>

      {done && <p className={styles.done}>{DONE_LABEL[done] ?? "처리했습니다."}</p>}
      {error && <p className={styles.error}>{ERROR_LABEL[error] ?? "처리하지 못했습니다."}</p>}

      {/* ------------------------------------------------------------ 등록 폼 */}
      <form action={addVideoAction} className={styles.addForm}>
        <label className={styles.field}>
          <span className={styles.fieldLabel}>챔피언</span>
          <select
            name="championSlug"
            className={styles.input}
            required
            defaultValue={selected}
          >
            <option value="" disabled>
              고르세요
            </option>
            {allChampions.map((champion) => {
              const count = byChampion.get(champion.slug)?.length ?? 0;
              return (
                <option key={champion.slug} value={champion.slug}>
                  {champion.name}
                  {count > 0 ? ` — ${count}개` : ""}
                </option>
              );
            })}
          </select>
        </label>

        <label className={`${styles.field} ${styles.fieldWide}`}>
          <span className={styles.fieldLabel}>유튜브 주소</span>
          <input
            type="text"
            name="url"
            className={styles.input}
            required
            placeholder="https://youtu.be/... 또는 영상 ID"
          />
        </label>

        {/*
          제목은 비워 두는 것이 기본이다. 유튜브에서 받아 오는 편이 정확하고 빠르며,
          운영자가 매번 옮겨 적을 이유가 없다. 여기에 값을 적으면 그 값이 이긴다 —
          원본 제목이 낚시성이거나 무엇에 대한 영상인지 안 보일 때를 위한 칸이다.
        */}
        <label className={`${styles.field} ${styles.fieldWide}`}>
          <span className={styles.fieldLabel}>제목 (비우면 유튜브에서 가져옵니다)</span>
          <input
            type="text"
            name="title"
            className={styles.input}
            maxLength={200}
            placeholder="예: 아리 상대 라인전 3렙 타이밍"
          />
        </label>

        <button type="submit" className="btn btn--acid">
          등록
        </button>
      </form>

      {/* ------------------------------------------------------------ 목록 */}
      {groups.length === 0 ? (
        <p className={styles.empty}>아직 등록된 영상이 없습니다.</p>
      ) : (
        <div className={styles.groups}>
          {groups.map(([championSlug, rows]) => (
            <section key={championSlug} className={styles.group}>
              <h2 className={styles.groupTitle}>
                <Link href={`/matchup/${championSlug}?tab=video`} className={styles.groupLink}>
                  {getChampionBySlug(championSlug)?.name ?? championSlug}
                </Link>
                <span className={`mono ${styles.count}`}>{rows.length}</span>
              </h2>

              <ul className={styles.rows}>
                {rows.map((row, index) => (
                  <li
                    key={row.id}
                    className={`${styles.row} ${row.published ? "" : styles.rowHidden}`}
                  >
                    <img
                      className={styles.thumb}
                      src={youTubeThumbnailUrl(row.videoId)}
                      alt=""
                      width={120}
                      height={68}
                      loading="lazy"
                    />

                    <div className={styles.info}>
                      <a
                        className={styles.rowTitle}
                        href={youTubeWatchUrl(row.videoId)}
                        target="_blank"
                        rel="noopener noreferrer"
                      >
                        {row.title}
                      </a>
                      <p className={`mono ${styles.meta}`}>
                        {row.author ?? "채널 미상"} · {row.addedByName ?? "알 수 없음"} ·{" "}
                        {formatDate(row.addedAt)}
                        {!row.published && <span className={styles.flag}> 감춤</span>}
                      </p>
                    </div>

                    {/*
                      순서 바꾸기. 양 끝에서는 아예 그리지 않아, 눌러도 아무 일 없는
                      버튼을 두지 않는다 (`/admin/taxonomy`와 같은 규칙).
                    */}
                    <div className={styles.controls}>
                      {index > 0 && (
                        <MoveButton row={row} direction="up" championSlug={championSlug} />
                      )}
                      {index < rows.length - 1 && (
                        <MoveButton row={row} direction="down" championSlug={championSlug} />
                      )}

                      <form action={setVideoPublishedAction}>
                        <input type="hidden" name="championSlug" value={championSlug} />
                        <input type="hidden" name="id" value={row.id} />
                        <input type="hidden" name="published" value={row.published ? "0" : "1"} />
                        <button type="submit" className={styles.control}>
                          {row.published ? "감추기" : "보이기"}
                        </button>
                      </form>

                      <form action={removeVideoAction}>
                        <input type="hidden" name="championSlug" value={championSlug} />
                        <input type="hidden" name="id" value={row.id} />
                        <button
                          type="submit"
                          className={`${styles.control} ${styles.remove}`}
                          aria-label={`${row.title} 지우기`}
                        >
                          지우기
                        </button>
                      </form>
                    </div>
                  </li>
                ))}
              </ul>
            </section>
          ))}
        </div>
      )}
    </div>
  );
}

function MoveButton({
  row,
  direction,
  championSlug,
}: {
  row: VideoAdminRow;
  direction: "up" | "down";
  championSlug: string;
}) {
  return (
    <form action={moveVideoAction}>
      <input type="hidden" name="championSlug" value={championSlug} />
      <input type="hidden" name="id" value={row.id} />
      <input type="hidden" name="direction" value={direction} />
      <button
        type="submit"
        className={styles.move}
        aria-label={`${row.title}${direction === "up" ? " 앞으로" : " 뒤로"}`}
      >
        <span aria-hidden="true">{direction === "up" ? "‹" : "›"}</span>
      </button>
    </form>
  );
}

function formatDate(iso: string): string {
  return new Intl.DateTimeFormat("ko-KR", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    timeZone: "Asia/Seoul",
  }).format(new Date(iso));
}
