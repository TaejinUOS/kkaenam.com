import Markdown from "markdown-to-jsx";
import Link from "next/link";
import type {
  AnchorHTMLAttributes,
  ImgHTMLAttributes,
  PropsWithChildren,
  TableHTMLAttributes,
} from "react";

import {
  FOOTNOTE_HREF,
  MISSING_DOC_HREF,
  type Footnote,
  type WikiLinkResolver,
  extractFootnotes,
  linkifyWikiLinks,
  missingDocTitle,
  wikiDocTarget,
} from "@/lib/wikiMarkup";
import { articleHref, checkArticleTitle } from "@/lib/wikiTitle";

import styles from "./MarkdownBody.module.css";

/**
 * 위키 본문의 공용 마크다운 렌더러.
 *
 * `disableParsingRawHTML: true`라 원문에 섞인 HTML 태그는 항상 글자 그대로
 * 이스케이프되어 보인다 — `dangerouslySetInnerHTML`을 전혀 쓰지 않으므로 이
 * 렌더러 자체에 스크립트 삽입 경로가 없다 (PRD 10 "스크립트 삽입 공격 방지").
 *
 * 위키 전용 문법(각주 `[^가]`, 위키링크 `[[미드/아리]]`)은 파싱 전에 표준 마크다운으로
 * 바뀐 뒤 들어온다. 자세한 것은 `lib/wikiMarkup.ts`.
 *
 * 이 컴포넌트는 클라이언트 훅을 쓰지 않는다. 서버 컴포넌트인 역사·검토 화면이
 * 그대로 부를 수 있어야 하기 때문이다.
 */
type Props = {
  text: string;
  /**
   * 문서 단위로 미리 뽑아 둔 각주. 본문이 제목마다 쪼개져 들어올 때 필요하다 —
   * 번호는 섹션 전체를 훑어야 순서대로 매겨진다. 이때 `text`는 이미 번호 링크로
   * 바뀐 뒤여야 한다. 주지 않으면 `text`에서 직접 뽑는다.
   */
  footnotes?: Footnote[];
  /** 위키링크 해석기. 주지 않으면 모든 `[[...]]`가 없는 문서로 표시된다. */
  resolveLink?: WikiLinkResolver;
};

const NO_LINK = () => null;

function Prose({ children }: PropsWithChildren) {
  return <div className={styles.prose}>{children}</div>;
}

export function MarkdownBody({ text, footnotes, resolveLink = NO_LINK }: Props) {
  if (!text.trim()) return null;

  const source = footnotes ? { body: text, notes: footnotes } : extractFootnotes(text);
  const markdown = linkifyWikiLinks(source.body, resolveLink);

  return (
    <Markdown
      options={{
        disableParsingRawHTML: true,
        forceWrapper: true,
        /*
         * 문단이 하나뿐인 본문도 `<p>`로 감싼다.
         *
         * 이것이 없으면 markdown-to-jsx가 그런 본문을 인라인으로 보고 글자와 링크를
         * wrapper의 직계 자식으로 뱉는다. `.prose`가 grid라 그 조각들이 **각각 한 줄을
         * 차지해**, 링크가 있는 짧은 문단이 세 줄로 쪼개진다. 대부분의 섹션이 여러
         * 문단이라 오래 눈에 띄지 않았다.
         */
        forceBlock: true,
        wrapper: Prose,
        overrides: {
          a: { component: makeLink(source.notes, resolveLink) },
          /*
           * 문서 안 제목은 화면의 제목 체계보다 낮은 단계로 눌러 h1이 여러 번
           * 나타나지 않게 한다. 통합 문서에서는 제목이 이미 개요로 뽑혀 나가므로
           * 여기에 남는 것은 setext 제목처럼 개요 파서가 다루지 않는 경우뿐이다.
           */
          h1: { component: "h5" },
          h2: { component: "h5" },
          h3: { component: "h6" },
          table: { component: ScrollableTable },
          img: { component: BlockedImage },
        },
      }}
    >
      {markdown}
    </Markdown>
  );
}

/**
 * 이미지는 그리지 않는다 (PRD 5.4.3).
 *
 * `![설명](주소)`는 편집자가 적은 **외부 주소를 읽는 사람의 브라우저가 직접 부르게**
 * 만든다. 그 요청에 읽는 사람의 IP와 브라우저 정보가 실려 나가는데, 우리는 그 주소가
 * 무엇인지 통제하지 못한다 — 운영자가 하나씩 보고 넣는 영상 임베드와 달리 편집은
 * 누구나 하기 때문이다. 마음먹으면 추적 픽셀도 된다.
 *
 * 조용히 지우지 않고 자리에 표시를 남긴다. 아무것도 안 보이면 편집자는 문법을 틀린
 * 줄 알고 같은 것을 몇 번이고 다시 시도한다. 설명(alt)을 함께 보여 주는 것은 그 글이
 * 편집자가 쓴 것이라 지워 버릴 이유가 없어서다.
 */
function BlockedImage({ alt }: ImgHTMLAttributes<HTMLImageElement>) {
  const label = typeof alt === "string" ? alt.trim() : "";
  return (
    <span className={styles.blockedImage} title="이 위키에는 이미지를 넣을 수 없습니다">
      {label ? `[이미지: ${label}]` : "[이미지]"}
    </span>
  );
}

/**
 * 표는 감싸서 내보낸다.
 *
 * 넘치는 폭이 **표 안에서만** 밀려야 하기 때문이다. 감싸지 않으면 챔피언 이름이 여럿
 * 들어간 표 하나가 페이지 전체에 가로 스크롤을 만들어, 아무 관계도 없는 본문 문단까지
 * 화면 밖으로 끌고 나간다.
 */
function ScrollableTable({ children, ...rest }: TableHTMLAttributes<HTMLTableElement>) {
  return (
    <div className={styles.tableWrap}>
      <table {...rest}>{children}</table>
    </div>
  );
}

/**
 * 링크 렌더러. 링크를 다섯 갈래로 나눈다.
 *
 * 갈래마다 색이 다른 것은 장식이 아니다. 같은 밑줄이라도 문서 안으로 들어가는지,
 * 사이트를 떠나는지, 아직 없는 문서인지에 따라 누르기 전에 알아야 할 것이 다르다.
 */
function makeLink(notes: Footnote[], resolveLink: WikiLinkResolver) {
  const byIndex = new Map(notes.map((note) => [note.index, note]));

  return function WikiLink({ href, children, ...rest }: AnchorHTMLAttributes<HTMLAnchorElement>) {
    // 1. 각주 — 이동하지 않고 그 자리에 내용을 띄운다.
    if (typeof href === "string" && href.startsWith(FOOTNOTE_HREF)) {
      const note = byIndex.get(Number(href.slice(FOOTNOTE_HREF.length)));
      if (note) return <Annotation note={note} resolveLink={resolveLink} />;
    }

    /*
     * 2. 아직 없는 문서 — 빈 자리로 데려간다.
     *
     * 위키에서 빨간 링크는 막다른 길이 아니라 **초대**다. 누르면 그 이름의 빈 문서
     * 화면이 열리고 거기서 바로 쓰기 시작할 수 있다 (`docs/WIKI_EXPANSION.md`).
     *
     * 다만 문서 이름이 될 수 없는 꼴(`미드/아리` 같은 옛 링크나 오타)은 데려갈 곳이
     * 없다. 그때는 예전처럼 빨간 글자로만 남긴다 — 만들 수 없는 이름의 생성 화면으로
     * 보내면 그 사람은 거기서 막힌다.
     */
    if (typeof href === "string" && href.startsWith(MISSING_DOC_HREF)) {
      const title = missingDocTitle(href);
      if (!title || checkArticleTitle(title)) {
        return (
          <span className={styles.missing} title="아직 없는 문서입니다">
            {children}
          </span>
        );
      }
      return (
        <Link
          {...rest}
          href={articleHref(title)}
          className={styles.missing}
          title="아직 없는 문서입니다. 첫 번째로 써 보세요"
        >
          {children}
        </Link>
      );
    }

    /*
     * 3. 위키링크로 걸린 문서 — 밑줄 없이 색으로만 구별한다.
     *
     * `[[...]]`는 문서를 잇는 뼈대라 한 문장에 여러 개가 박힌다. 거기까지 밑줄을
     * 그으면 본문이 줄무늬가 되어 오히려 어디가 링크인지 읽기 어려워진다. 아래 4번의
     * 손으로 적은 링크는 드물게 나오므로 밑줄을 그대로 둔다.
     */
    if (typeof href === "string") {
      const target = wikiDocTarget(href);
      if (target) {
        return (
          <Link {...rest} href={target} className={styles.wiki}>
            {children}
          </Link>
        );
      }
    }

    // 4. 사이트 안 — 새 탭을 열지 않고 클라이언트 이동한다.
    if (typeof href === "string" && href.startsWith("/")) {
      /*
       * `rest`를 먼저 펼친다. markdown-to-jsx가 빈 `className`을 함께 넘겨서, 뒤에
       * 펼치면 여기서 준 클래스를 지워 버린다 — 문서 링크가 파랗지 않던 원인이었다.
       */
      return (
        <Link {...rest} href={href} className={styles.internal}>
          {children}
        </Link>
      );
    }

    // 5. 바깥 — http(s)만 허용한다. 그 밖의 스킴(javascript:, data:)은 href를 지운다.
    const external = typeof href === "string" && /^https?:\/\//i.test(href) ? href : undefined;
    if (!external) {
      // 같은 문서 안 앵커(#...)는 그대로 둔다. 편집자가 직접 거는 상호 참조다.
      const anchor = typeof href === "string" && href.startsWith("#") ? href : undefined;
      return (
        <a {...rest} href={anchor} className={styles.internal}>
          {children}
        </a>
      );
    }

    return (
      <a
        {...rest}
        href={external}
        className={styles.external}
        target="_blank"
        rel="noopener noreferrer nofollow ugc"
      >
        {children}
      </a>
    );
  };
}

/**
 * 각주 — 마우스를 올리거나 초점이 닿으면 그 자리에 내용이 뜬다.
 *
 * 자바스크립트를 쓰지 않는다. 표시는 CSS의 `:hover`·`:focus-within`이 맡으므로 이
 * 컴포넌트가 서버에서 그려져도 동작한다. 손가락으로 쓰는 화면에는 hover가 없어
 * 표식을 버튼으로 두었다 — 한 번 누르면 초점이 닿아 같은 내용이 뜬다.
 *
 * 숨어 있을 때도 `opacity`로만 가린다. `display: none`으로 지우면 화면 낭독기가
 * 각주 내용을 아예 읽지 못한다.
 */
function Annotation({
  note,
  resolveLink,
}: {
  note: Footnote;
  resolveLink: WikiLinkResolver;
}) {
  return (
    <span className={styles.footnote}>
      <button type="button" className={styles.footnoteMark} aria-label={`각주 ${note.index}`}>
        [{note.index}]
      </button>
      <span role="note" className={styles.footnotePopup}>
        <Markdown
          options={{
            disableParsingRawHTML: true,
            forceInline: true,
            overrides: { a: { component: makeLink([], resolveLink) } },
          }}
        >
          {linkifyWikiLinks(note.body, resolveLink)}
        </Markdown>
      </span>
    </span>
  );
}
