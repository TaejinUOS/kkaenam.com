/**
 * 알림 — D1 읽기 계층.
 *
 * **알림을 저장하지 않는다.** 알릴 일은 이미 `wiki_edits`에 다 적혀 있고
 * (마이그레이션 0009), 저장하는 것은 사람마다 "어디까지 봤는가" 하나
 * (`users.notifications_read_at`)뿐이다. 알림 한 줄은 그때그때 편집 표에서 만든다.
 *
 * 두 갈래가 있다.
 *
 *   `edit_accepted` / `edit_rejected`  내가 낸 제안을 운영자가 검토했다 → 모든 사용자
 *   `review_request`                   남이 낸 제안이 검토를 기다린다   → 운영자만
 *
 * 즉시 반영된 내 편집은 알리지 않는다. 방금 내가 한 일이라 새 소식이 아니다.
 */

import "server-only";

import { getCloudflareContext } from "@opennextjs/cloudflare";

import type { DocTarget, UserRole } from "@/data/wiki";
import { DOC_COLUMNS, targetOf, type DocColumns } from "@/lib/wikiEditStore";

async function db() {
  const { env } = await getCloudflareContext({ async: true });
  return env.DB;
}

/** 알림 화면이 한 번에 보여 주는 줄 수. 그보다 오래된 것은 「내 편집」과 대기열이 갖는다. */
const LIST_LIMIT = 30;

/** 배지에 적는 최대 숫자. 이 이상은 `99+`가 된다 — 정확한 수보다 자리 폭이 중요하다. */
export const BADGE_MAX = 99;

export type NotificationKind = "edit_accepted" | "edit_rejected" | "review_request";

export type NotificationItem = {
  /** 이 알림을 만든 편집의 id. 알림 자체에는 id가 없다. */
  editId: string;
  kind: NotificationKind;
  /** 사건이 일어난 시각. 검토 결과는 검토 시각, 검토 요청은 제출 시각이다. */
  at: string;
  target: DocTarget;
  meSlug: string | null;
  summary: string;
  /** 거절 사유. `edit_rejected`에서만 온다. */
  note: string | null;
  /** 제안자 이름. `review_request`에서만 온다. */
  actorName: string | null;
  unread: boolean;
};

/**
 * 읽지 않은 알림 수. 헤더가 페이지마다 부른다.
 *
 * 역할과 기준 시각을 `users`에서 함께 읽어 질의 하나로 끝낸다 — 헤더는 모든 화면에
 * 얹히므로 여기서 왕복을 하나 더 하면 사이트 전체가 그만큼 느려진다. 역할을 세션이
 * 아니라 DB에서 보는 것은, 권한이 바뀐 뒤에도 살아 있는 세션이 있기 때문이다.
 */
export async function countUnreadNotifications(userId: string): Promise<number> {
  const DB = await db();
  const row = await DB.prepare(
    `SELECT
       (SELECT COUNT(*) FROM wiki_edits e
         WHERE e.author = u.id
           AND e.reviewed_at IS NOT NULL
           AND e.status IN ('accepted', 'rejected')
           AND (u.notifications_read_at IS NULL OR e.reviewed_at > u.notifications_read_at))
       +
       (SELECT COUNT(*) FROM wiki_edits e
         WHERE u.role = 'admin'
           AND e.status = 'pending'
           AND (e.author IS NULL OR e.author <> u.id)
           AND (u.notifications_read_at IS NULL OR e.created_at > u.notifications_read_at))
       AS n
     FROM users u WHERE u.id = ?1`,
  )
    .bind(userId)
    .first<{ n: number }>();

  return row?.n ?? 0;
}

export type NotificationFeed = {
  items: NotificationItem[];
  unread: number;
};

/**
 * 알림 목록. 읽은 것도 함께 돌려준다 — 읽었다고 사라지면, 어제 받은 거절 사유를
 * 다시 보려는 사람이 갈 곳이 없다.
 */
export async function listNotifications(
  userId: string,
  role: UserRole,
): Promise<NotificationFeed> {
  const DB = await db();

  const marker = await DB.prepare(`SELECT notifications_read_at FROM users WHERE id = ?1`)
    .bind(userId)
    .first<{ notifications_read_at: string | null }>();
  const readAt = marker?.notifications_read_at ?? null;
  const unreadSince = (at: string) => readAt === null || at > readAt;

  const reviewed = await DB.prepare(
    `SELECT e.id, ${DOC_COLUMNS}, e.me_slug, e.summary, e.status, e.reviewed_at, e.review_note
       FROM wiki_edits e JOIN wiki_docs d ON d.id = e.doc_id
      WHERE e.author = ?1
        AND e.reviewed_at IS NOT NULL
        AND e.status IN ('accepted', 'rejected')
      ORDER BY e.reviewed_at DESC
      LIMIT ?2`,
  )
    .bind(userId, LIST_LIMIT)
    .all<
      DocColumns & {
        id: string;
        me_slug: string | null;
        summary: string;
        status: string;
        reviewed_at: string;
        review_note: string | null;
      }
    >();

  const items: NotificationItem[] = (reviewed.results ?? []).map((r) => ({
    editId: r.id,
    kind: r.status === "accepted" ? "edit_accepted" : "edit_rejected",
    at: r.reviewed_at,
    target: targetOf(r),
    meSlug: r.me_slug,
    summary: r.summary,
    note: r.status === "rejected" ? r.review_note : null,
    actorName: null,
    unread: unreadSince(r.reviewed_at),
  }));

  if (role === "admin") {
    /*
     * 대기열은 처리하기 전까지 계속 남는다. 그래서 읽음 표시를 지나도 목록에서는
     * 사라지지 않고, 배지 숫자에서만 빠진다 — 검토가 끝났다는 뜻이 아니라 봤다는
     * 뜻이기 때문이다. 실제 처리는 검토 화면에서 한다.
     */
    const pending = await DB.prepare(
      `SELECT e.id, ${DOC_COLUMNS}, e.me_slug, e.summary, e.created_at, u.name AS author_name
         FROM wiki_edits e
         JOIN wiki_docs d ON d.id = e.doc_id
         LEFT JOIN users u ON u.id = e.author
        WHERE e.status = 'pending' AND (e.author IS NULL OR e.author <> ?1)
        ORDER BY e.created_at DESC
        LIMIT ?2`,
    )
      .bind(userId, LIST_LIMIT)
      .all<
        DocColumns & {
          id: string;
          me_slug: string | null;
          summary: string;
          created_at: string;
          author_name: string | null;
        }
      >();

    for (const r of pending.results ?? []) {
      items.push({
        editId: r.id,
        kind: "review_request",
        at: r.created_at,
        target: targetOf(r),
        meSlug: r.me_slug,
        summary: r.summary,
        note: null,
        actorName: r.author_name,
        unread: unreadSince(r.created_at),
      });
    }
  }

  items.sort((a, b) => (a.at < b.at ? 1 : a.at > b.at ? -1 : 0));

  return {
    items: items.slice(0, LIST_LIMIT),
    unread: items.filter((item) => item.unread).length,
  };
}

/**
 * 여기까지 봤다고 적는다.
 *
 * 기준을 "지금"으로 잡는다. 목록을 그린 뒤 화면을 닫기 전에 새로 들어온 알림도 읽음이
 * 되지만, 목록에서 가장 새 알림의 시각을 쓰면 알림이 하나도 없는 사람은 영영 기준을
 * 세우지 못한다.
 */
export async function markNotificationsRead(userId: string): Promise<void> {
  const DB = await db();
  await DB.prepare(`UPDATE users SET notifications_read_at = ?2 WHERE id = ?1`)
    .bind(userId, new Date().toISOString())
    .run();
}
