import type { Metadata } from "next";
import Link from "next/link";

import { requirePageUser } from "@/lib/authGuard";
import { listNotifications, type NotificationItem } from "@/lib/notificationStore";
import { relativeTime } from "@/lib/relativeTime";
import { docHref, docSectionLabel, docTitle } from "@/lib/wikiDocTarget";

import { MarkRead } from "./MarkRead";
import styles from "./page.module.css";

export const metadata: Metadata = {
  title: "알림",
  robots: { index: false, follow: false },
};

const KIND_LABEL: Record<NotificationItem["kind"], string> = {
  edit_accepted: "반영됨",
  edit_rejected: "거절됨",
  review_request: "검토 요청",
};

/** 스티커 색. 좋은 소식은 Acid, 운영자가 할 일은 Gum, 거절은 색 없이 둔다. */
const KIND_STICKER: Record<NotificationItem["kind"], string> = {
  edit_accepted: "sticker--acid",
  edit_rejected: "",
  review_request: "sticker--gum",
};

/**
 * 알림.
 *
 * 헤더의 종이 데려오는 곳이다. 사건을 저장하지 않고 편집 표에서 그때그때 만들어
 * 보여 준다 (`src/lib/notificationStore.ts`). 여기서 하는 일은 목록을 그리고,
 * 다 그린 뒤에 「여기까지 봤다」를 적는 것 둘뿐이다.
 */
export default async function NotificationsPage() {
  const viewer = await requirePageUser();
  const { items, unread } = await listNotifications(viewer.id, viewer.role);
  const now = Date.now();

  return (
    <div className={`shell ${styles.screen}`}>
      <p className="section-index">마이페이지</p>
      <div className={styles.head}>
        <h1 className={`display ${styles.title}`}>알림</h1>
        {unread > 0 && <span className={styles.count}>읽지 않음 {unread}</span>}
      </div>

      {items.length === 0 ? (
        <p className={styles.empty}>
          아직 알림이 없습니다. 제출한 편집을 운영자가 검토하면 여기에 알려 드립니다.
        </p>
      ) : (
        <ul className={styles.list}>
          {items.map((item) => (
            <li
              key={`${item.kind}-${item.editId}`}
              className={`${styles.row} ${item.unread ? styles.rowUnread : ""}`}
            >
              <div className={styles.rowHead}>
                <span className={`sticker ${KIND_STICKER[item.kind]}`}>
                  {KIND_LABEL[item.kind]}
                </span>
                {/*
                  읽지 않음은 배경만으로 두지 않는다. 색을 못 보는 사람에게는 왼쪽 면과
                  이 점 중 하나는 남아야 한다 (PRD 5.3.3과 같은 규칙).
                */}
                {item.unread && (
                  <span className={styles.dot}>
                    <span className="sr-only">읽지 않음</span>
                  </span>
                )}
                <time className={`mono ${styles.when}`} dateTime={item.at}>
                  {relativeTime(item.at, now)}
                </time>
              </div>

              <p className={styles.lead}>{lead(item)}</p>

              {item.summary && <p className={styles.summary}>{item.summary}</p>}
              {item.note && <p className={styles.note}>운영자 사유: {item.note}</p>}

              <NotificationLink item={item} />
            </li>
          ))}
        </ul>
      )}

      <p className={styles.footnote}>
        지난 편집의 처리 상태는{" "}
        <Link href="/my/edits" className={styles.inlineLink}>
          내 편집
        </Link>
        에 모두 남아 있습니다.
      </p>

      {/* 목록을 다 그린 뒤에 읽음으로 적는다. 읽지 않은 것이 없으면 쓸 일도 없다. */}
      {unread > 0 && <MarkRead />}
    </div>
  );
}

/** 한 줄로 무슨 일이 있었는지 적는다. 문서 이름과 섹션이 여기 들어간다. */
function lead(item: NotificationItem): string {
  const where = `${docTitle(item.target)} · ${docSectionLabel(item.target, item.meSlug)}`;

  switch (item.kind) {
    case "edit_accepted":
      return `${where} 편집이 문서에 반영되었습니다.`;
    case "edit_rejected":
      return `${where} 편집이 거절되었습니다.`;
    case "review_request":
      return `${item.actorName ?? "탈퇴 계정"} 님이 ${where} 편집을 제안했습니다.`;
  }
}

/**
 * 알림이 데려갈 곳.
 *
 * 검토 요청은 검토 화면으로, 내 편집의 결과는 그 문서로 간다. 거절된 새 문서 제안만
 * 갈 곳이 없다 — 이름을 놓아준 껍데기라 링크를 걸면 「아직 없는 문서」 화면으로
 * 데려가 제안이 살아 있는 것처럼 보인다 (`/my/edits`와 같은 판단).
 */
function NotificationLink({ item }: { item: NotificationItem }) {
  if (item.kind === "review_request") {
    return (
      <Link href={`/admin/wiki/review/${item.editId}`} className={styles.go}>
        검토하기 <span aria-hidden="true">→</span>
      </Link>
    );
  }

  if (item.target.kind === "article" && item.target.status === "rejected") return null;

  return (
    <Link href={docHref(item.target, item.meSlug)} className={styles.go}>
      문서 보기 <span aria-hidden="true">→</span>
    </Link>
  );
}
