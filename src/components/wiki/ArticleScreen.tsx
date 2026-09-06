"use client";

import Link from "next/link";
import { useCallback, useMemo } from "react";

import type { DocNode } from "@/lib/wikiStore";
import type { WikiLinkMap } from "@/lib/wikiLink";
import { collectWikiLinkTitles, parseCategoryName } from "@/lib/wikiMarkup";
import { articleHref } from "@/lib/wikiTitle";

import { DeleteArticleButton } from "./DeleteArticleButton";
import { type DocSection, WikiDocument } from "./WikiDocument";
import styles from "./ArticleScreen.module.css";

type Viewer = { id: string; name: string; role: "member" | "admin" } | null;

type Props = {
  title: string;
  /** 운영자가 이 문서를 내릴 때 서버가 다시 찾는 열쇠. */
  titleKey: string;
  /** 본문. 이름 붙은 섹션은 3단계에서 붙는다. */
  body: string;
  revision: number;
  updatedAt: string | null;
  updatedBy: string | null;
  /** 승인 전 문서. 제안자와 운영자에게만 보이며 그 사실을 화면에 적는다. */
  proposed: boolean;
  /** 본문에 적힌 `[[...]]`를 서버가 미리 풀어 둔 결과. */
  wikiLinks: WikiLinkMap;
  /**
   * 이 문서를 부모로 적은(`[[분류:이 문서]]`) 문서들. 끝까지 중첩된다.
   *
   * 분류 문서만 받는 것이 아니다 — 어떤 문서든 자기 아래 문서를 가질 수 있다
   * (`docs/WIKI_EXPANSION.md` "위계는 문서가 만든다").
   */
  childDocs: DocNode[];
  viewer: Viewer;
};

/** 본문 섹션의 앵커. 매치업 문서의 `general`과 같은 자리다. */
const BODY_ID = "general";

/**
 * 일반 문서 한 장 (`docs/WIKI_EXPANSION.md` 1단계).
 *
 * 문서 골격은 매치업과 똑같은 `WikiDocument`를 쓴다. 목차 하나, 번호가 문서 전체를
 * 관통하는 것, 섹션이 곧 편집 단위인 것이 전부 그대로다 — 다른 것은 섹션 이름이
 * 어디서 오는가뿐인데, 지금 일반 문서에는 본문 하나뿐이라 그 차이도 아직 없다.
 *
 * 매치업 문서와 달리 Aside가 없다. 그릴 챔피언 아트가 없기 때문이고, 그 자리를 빈
 * 상자로 채우지 않는다 (블루프린트 5장 "의미 없는 장식").
 */
export function ArticleScreen({
  title,
  titleKey,
  body,
  revision,
  updatedAt,
  updatedBy,
  proposed,
  wikiLinks,
  childDocs,
  viewer,
}: Props) {
  const resolveLink = useCallback((target: string) => wikiLinks[target] ?? null, [wikiLinks]);

  const base = articleHref(title);
  const editHref = `${base}/edit`;

  /*
   * 분류 태그는 본문에 그리지 않는다(`linkifyWikiLinks`가 지운다). 여기서 따로
   * 뽑아 문서 하단에 태그 줄로 보여준다 — namuwiki가 분류를 다루는 방식과 같다.
   */
  const categories = useMemo(() => {
    const names = new Set<string>();
    for (const linkTitle of collectWikiLinkTitles(body)) {
      const name = parseCategoryName(linkTitle);
      if (name) names.add(name);
    }
    return [...names];
  }, [body]);

  const sections = useMemo<DocSection[]>(
    () => [
      {
        id: BODY_ID,
        title: "본문",
        badge: <span className="sticker sticker--cobalt">article</span>,
        badgePosition: "after",
        body,
        action: proposed ? undefined : (
          <Link
            href={viewer ? editHref : `/login?callbackUrl=${encodeURIComponent(editHref)}`}
            prefetch={false}
            className={`sticker ${styles.editButton}`}
          >
            편집
          </Link>
        ),
        empty: <p className={styles.empty}>아직 본문이 없습니다.</p>,
      },
    ],
    [body, editHref, proposed, viewer],
  );

  return (
    <div className={styles.screen}>
      <div className="shell">
        <nav className={styles.crumbs} aria-label="현재 위치">
          <Link href="/wiki" className={styles.crumbLink}>
            위키
          </Link>
          <span aria-hidden="true"> / </span>
          <span className={styles.crumbCurrent}>{title}</span>
        </nav>

        <header className={styles.documentHeader}>
          <p className={`mono ${styles.documentKicker}`}>WIKI ARTICLE</p>
          <h1 className={`display ${styles.documentTitle}`}>{title}</h1>
        </header>

        {/*
          승인 전 문서는 목록·검색·링크 어디에도 없다. 주소를 아는 사람만 여기 닿으므로,
          지금 보고 있는 것이 아직 문서가 아니라는 사실을 화면이 직접 말해야 한다.
        */}
        {proposed && (
          <p className={styles.proposed}>
            <span className="sticker sticker--gum">검토 대기</span> 아직 만들어지지 않은 문서입니다.
            운영자가 승인하면 이 이름으로 게시됩니다.
          </p>
        )}

        <div className={`${styles.paper} on-paper`}>
          <WikiDocument sections={sections} resolveLink={resolveLink} />
        </div>

        {categories.length > 0 && (
          <p className={styles.categories}>
            <span className={styles.categoriesLabel}>분류</span>
            {categories.map((name) => (
              <Link key={name} href={articleHref(`분류:${name}`)} className={styles.categoryTag}>
                {name}
              </Link>
            ))}
          </p>
        )}

        {/*
          손으로 쓴 본문 아래에 이 문서 아래의 문서를 자동으로 이어 붙인다. 분류 문서든
          일반 문서든 똑같이 붙는다 — `동수 법칙`을 열면 그 아래 `전선`이 보여야 한다.
        */}
        {childDocs.length > 0 && (
          <section className={styles.memberList} aria-label="이 문서 아래의 문서">
            <p className={styles.memberListTitle}>이 문서 아래</p>
            <ChildDocs nodes={childDocs} />
          </section>
        )}

        {/*
          운영자만 보는 자리. 문서를 내리는 일은 읽는 흐름의 일부가 아니므로 본문과
          목록 아래, 메타 줄 옆에 둔다.
        */}
        {!proposed && viewer?.role === "admin" && (
          <div className={styles.adminBar}>
            <DeleteArticleButton
              titleKey={titleKey}
              title={title}
              childCount={childDocs.length}
            />
          </div>
        )}

        {!proposed && (
          <p className={`mono ${styles.meta}`}>
            <Link href={`${base}/history`} className={styles.historyLink}>
              r{revision} 역사
            </Link>
            <span aria-hidden="true">|</span>
            <span>{formatDate(updatedAt)} 갱신</span>
            {updatedBy && (
              <>
                <span aria-hidden="true">|</span>
                <span>{updatedBy}</span>
              </>
            )}
          </p>
        )}
      </div>
    </div>
  );
}

/** 이 문서 아래의 문서. 한 줄이 곧 읽을 수 있는 문서이고, 아래가 있으면 들여 이어 그린다. */
function ChildDocs({ nodes }: { nodes: DocNode[] }) {
  return (
    <ul className={styles.memberRows}>
      {nodes.map((node) => (
        <li key={node.titleKey}>
          <Link href={articleHref(node.title)} className={styles.memberRow}>
            {node.label}
          </Link>
          {node.children.length > 0 && (
            <div className={styles.memberSub}>
              <ChildDocs nodes={node.children} />
            </div>
          )}
        </li>
      ))}
    </ul>
  );
}

function formatDate(iso: string | null): string {
  if (!iso) return "-";
  return new Intl.DateTimeFormat("ko-KR", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    timeZone: "Asia/Seoul",
  }).format(new Date(iso));
}
