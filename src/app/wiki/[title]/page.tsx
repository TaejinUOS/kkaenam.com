import type { Metadata } from "next";
import Link from "next/link";

import { ArticleScreen } from "@/components/wiki/ArticleScreen";
import { getViewer } from "@/lib/authGuard";
import { getBacklinks, type Backlink } from "@/lib/wikiIndexStore";
import { articleHref, titleKey } from "@/lib/wikiTitle";
import { getArticleView, getDocTree, resolveDocLinks, type DocNode } from "@/lib/wikiStore";

import styles from "./page.module.css";

type RouteParams = { title: string };

/** 위키는 편집으로 계속 바뀐다. 한 순간도 굳혀 두지 않는다. */
export const dynamic = "force-dynamic";

/**
 * 주소에서 문서 이름을 읽는다.
 *
 * Next가 이미 한 번 풀어 주지만, 이름에 `%`가 들어간 채로 들어오는 주소도 있어
 * 다시 풀 때 던질 수 있다. 그때는 받은 그대로 쓴다 — 어차피 정규화가 다음 단계다.
 */
function decodeTitle(raw: string): string {
  try {
    return decodeURIComponent(raw);
  } catch {
    return raw;
  }
}

export async function generateMetadata({
  params,
}: {
  params: Promise<RouteParams>;
}): Promise<Metadata> {
  const title = decodeTitle((await params).title);
  const article = await getArticleView(titleKey(title));
  if (!article || article.status !== "published") {
    return { title: `${title} (아직 없는 문서)`, robots: { index: false, follow: false } };
  }
  return { title: article.title };
}

/**
 * 일반 문서 (`docs/WIKI_EXPANSION.md` 1단계).
 *
 * 없는 문서도 404로 끝내지 않는다. 위키에서 빈 문서는 막다른 길이 아니라 **초대**이고,
 * 빨간 링크를 눌러 온 사람에게 필요한 것은 오류가 아니라 "첫 번째로 써 보세요"다.
 *
 * 승인 전 문서는 제안자와 운영자에게만 보인다. 그 밖의 사람에게는 아직 없는 문서와
 * 같아야 한다 — 목록·검색·링크 어디에도 없는 이름이 주소로만 새어 나가면, 승인 전
 * 문서를 감추기로 한 결정이 뜻을 잃는다.
 */
export default async function WikiArticlePage({ params }: { params: Promise<RouteParams> }) {
  const title = decodeTitle((await params).title);
  /*
   * 아래 문서는 **없는 문서에서도** 읽는다. `[[분류:동수 법칙]]`을 단 문서가 있는데
   * `동수 법칙`이 아직 없을 수 있고, 그때 빈 화면을 주면 그 아래 문서들이 어디에서도
   * 보이지 않게 된다 — 실제로 `전선`이 그렇게 사라져 있었다.
   */
  const [article, viewer, childDocs] = await Promise.all([
    getArticleView(titleKey(title)),
    getViewer(),
    getDocTree(title),
  ]);

  const visible =
    article &&
    (article.status === "published" ||
      (!!viewer && (viewer.role === "admin" || viewer.id === article.proposedBy)));

  if (!article || !visible) {
    const backlinks = await getBacklinks(titleKey(title));
    return <MissingArticle title={title} childDocs={childDocs} backlinks={backlinks} />;
  }

  const wikiLinks = await resolveDocLinks([article.body]);

  return (
    <ArticleScreen
      title={article.title}
      titleKey={titleKey(article.title)}
      body={article.body}
      revision={article.revision}
      updatedAt={article.updatedAt}
      updatedBy={article.updatedBy}
      proposed={article.status === "proposed"}
      wikiLinks={wikiLinks}
      childDocs={childDocs}
      viewer={viewer}
    />
  );
}

/**
 * 아직 없는 문서. 이 화면의 일은 쓰러 가게 하는 것이다.
 *
 * 다만 이 이름 아래에 이미 문서가 달려 있다면 그것도 함께 보여 준다. 이름이 비어 있다고
 * 그 아래 문서까지 감추면, 부모가 안 쓰였다는 이유로 자식이 통째로 사라진다.
 */
function MissingArticle({
  title,
  childDocs,
  backlinks,
}: {
  title: string;
  childDocs: DocNode[];
  backlinks: Backlink[];
}) {
  return (
    <div className={styles.screen}>
      <div className="shell">
        <nav className={styles.crumbs} aria-label="현재 위치">
          <Link href="/wiki" className={styles.crumbLink}>
            위키
          </Link>
          <span aria-hidden="true"> / </span>
          <span>{title}</span>
        </nav>

        <p className="section-index">아직 없는 문서</p>
        <h1 className={`display ${styles.title}`}>{title}</h1>
        <p className={styles.lead}>
          아직 없는 문서입니다. 첫 번째로 써 보세요 — 운영자가 승인하면 이 이름으로
          문서가 만들어집니다.
        </p>

        <div className={styles.actions}>
          <Link
            href={`/wiki/new?title=${encodeURIComponent(title)}`}
            className="btn btn--acid"
            prefetch={false}
          >
            이 이름으로 쓰기
          </Link>
          <Link href="/wiki" className="btn">
            위키 목차로
          </Link>
        </div>

        {backlinks.length > 0 && (
          <section className={styles.orphans} aria-label="이 문서를 부른 문서">
            <p className={styles.orphansTitle}>이 이름을 부른 문서</p>
            <ul className={styles.orphanRows}>
              {backlinks.map((link) => (
                <li key={link.href}>
                  <Link href={link.href} className={styles.orphanRow}>
                    {link.title}
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        )}

        {childDocs.length > 0 && (
          <section className={styles.orphans} aria-label="이 이름 아래의 문서">
            <p className={styles.orphansTitle}>이 이름 아래에 이미 있는 문서</p>
            <ul className={styles.orphanRows}>
              {childDocs.map((node) => (
                <li key={node.titleKey}>
                  <Link href={articleHref(node.title)} className={styles.orphanRow}>
                    {node.label}
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        )}
      </div>
    </div>
  );
}
