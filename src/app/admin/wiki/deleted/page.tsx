import type { Metadata } from "next";

import { RestoreArticleButton } from "@/components/admin/RestoreArticleButton";
import { requirePageAdmin } from "@/lib/authGuard";
import { relativeTime } from "@/lib/relativeTime";
import { listDeletedArticles } from "@/lib/wikiEditStore";

import styles from "./page.module.css";

export const metadata: Metadata = { title: "내린 문서" };

/**
 * 내린 문서 목록 (운영자 전용).
 *
 * 문서를 내리면 이름을 놓아주므로 주소로는 더 이상 찾아갈 수 없다. 되돌릴 수 있는
 * 조작인데 되돌릴 자리가 없으면 되돌릴 수 없는 조작과 같다 — 이 화면이 그 자리다.
 */
export default async function DeletedArticlesPage() {
  await requirePageAdmin();
  const rows = await listDeletedArticles();
  const now = Date.now();

  return (
    <div className={`shell ${styles.screen}`}>
      <p className="section-index">관리자</p>
      <h1 className={`display ${styles.title}`}>내린 문서</h1>
      <p className={styles.lead}>
        내려도 문서의 역사와 기여 기록은 지워지지 않습니다. 이름은 다시 비어 있으므로,
        그 이름으로 새 문서가 만들어졌다면 되돌릴 수 없습니다.
      </p>

      {rows.length === 0 ? (
        <p className={styles.empty}>내린 문서가 없습니다.</p>
      ) : (
        <ul className={styles.list}>
          {rows.map((row) => (
            <li key={row.docId} className={styles.row}>
              <div className={styles.rowHead}>
                <span className={`sticker ${row.nameFree ? "" : "sticker--gum"}`}>
                  {row.nameFree ? "되돌릴 수 있음" : "이름 다시 쓰임"}
                </span>
                <span className={styles.rowTitle}>{row.title}</span>
                {row.deletedAt && (
                  <time className={`mono ${styles.when}`} dateTime={row.deletedAt}>
                    {relativeTime(row.deletedAt, now)}
                  </time>
                )}
              </div>

              <p className={styles.reason}>
                사유: {row.reason ?? "적히지 않음"}
                {row.deletedBy && <span className={styles.by}> · {row.deletedBy}</span>}
              </p>

              {row.nameFree ? (
                <RestoreArticleButton docId={row.docId} title={row.title} />
              ) : (
                <p className={styles.blocked}>
                  같은 이름의 문서가 다시 생겼습니다. 되돌리려면 그 문서를 먼저 내려야
                  합니다.
                </p>
              )}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
