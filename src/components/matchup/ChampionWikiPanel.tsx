"use client";

import Link from "next/link";

import { ArticleDocument } from "@/components/wiki/ArticleScreen";
import type { Viewer } from "@/lib/authGuard";
import type { WikiLinkMap } from "@/lib/wikiLink";
import type { ArticleView, DocNode } from "@/lib/wikiStore";
import { articleHref } from "@/lib/wikiTitle";

import styles from "./ChampionWikiPanel.module.css";

type Props = {
  championName: string;
  article: ArticleView | null;
  wikiLinks: WikiLinkMap;
  childDocs: DocNode[];
  viewer: Viewer | null;
};

/** 챔피언 이름과 같은 일반 위키 문서를 챔피언 화면의 첫 지면으로 보여 준다. */
export function ChampionWikiPanel({
  championName,
  article,
  wikiLinks,
  childDocs,
  viewer,
}: Props) {
  if (!article) {
    const wikiHref = articleHref(championName);

    return (
      <div className={styles.missing}>
        <header className={styles.documentHeader}>
          <p className={`mono ${styles.documentKicker}`}>CHAMPION WIKI</p>
          <h2 className={`display ${styles.documentTitle}`}>{championName}</h2>
        </header>

        <p className={styles.lead}>
          {championName}의 배경, 스킬 활용, 운영법을 모으는 위키 문서가 아직 없습니다. 첫
          번째로 써 보세요 — 운영자가 승인하면 이 이름으로 게시됩니다.
        </p>

        <div className={styles.actions}>
          <Link
            href={`/wiki/new?title=${encodeURIComponent(championName)}`}
            className="btn btn--acid"
            prefetch={false}
          >
            {championName} 문서 쓰기
          </Link>
          <Link href={wikiHref} className="btn">
            위키에서 보기
          </Link>
        </div>

        {childDocs.length > 0 && (
          <section className={styles.childDocs} aria-label={`${championName} 아래의 문서`}>
            <p className={`mono ${styles.childDocsTitle}`}>이 이름 아래의 문서</p>
            <ul className={styles.childDocRows}>
              {childDocs.map((node) => (
                <li key={node.titleKey}>
                  <Link href={articleHref(node.title)} className={styles.childDocLink}>
                    {node.label}
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        )}
      </div>
    );
  }

  return (
    <ArticleDocument
      title={article.title}
      titleKey={article.titleKey}
      body={article.body}
      revision={article.revision}
      updatedAt={article.updatedAt}
      updatedBy={article.updatedBy}
      proposed={article.status === "proposed"}
      wikiLinks={wikiLinks}
      childDocs={childDocs}
      viewer={viewer}
      headingLevel="h2"
      kicker="CHAMPION WIKI"
    />
  );
}
