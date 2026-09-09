import type { SVGProps } from "react";

type Props = SVGProps<SVGSVGElement>;

/** 선택 화면에만 쓰는 펜 드로잉. 클릭 영역과 접근성 이름은 HTML이 맡는다. */
function Drawing({ children, ...props }: Props) {
  return (
    <svg fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true" focusable="false" {...props}>
      {children}
    </svg>
  );
}

export function CrownDrawing(props: Props) {
  return (
    <Drawing viewBox="0 0 76 62" {...props}>
      <path d="M9 35L24 43L22 9L44 38L63 22L57 51L27 55Z" strokeWidth="2.5" />
      <path d="M14 37L27 49L25 17L42 43L60 28L54 48L29 52M25 24L35 45M29 26L39 42M48 39L56 33M32 55L52 52" strokeWidth="1.1" />
      <path d="M19 3L20 6M9 22L12 26M65 13L65 17" />
    </Drawing>
  );
}

export function ArrowDrawing(props: Props) {
  return (
    <Drawing viewBox="0 0 72 68" {...props}>
      <path d="M15 5C20 17 28 34 33 49L24 43M33 49L37 34" strokeWidth="2.6" />
      <path d="M20 15C27 28 31 39 33 46M46 53L54 48L51 57Z" strokeWidth="1.6" />
    </Drawing>
  );
}

export function UnderlineDrawing(props: Props) {
  return (
    <Drawing viewBox="0 0 100 22" {...props}>
      <path d="M6 16C33 10 64 4 94 5C74 9 55 14 43 19M29 19L85 10" />
    </Drawing>
  );
}

/** 마스트헤드의 길고 각진 문양은 포스터의 회전형 표창과 구별한다. */
export function NinjaSigil(props: Props) {
  return (
    <Drawing viewBox="0 0 80 100" {...props}>
      <path d="M10 9L33 29L41 12L46 33L70 11L57 43L62 91L43 69L30 91L28 60L8 87L23 48Z" strokeWidth="2.8" />
      <path d="M17 20L29 44L15 72L32 54L33 77L39 57L52 80L49 48L61 26L44 43L40 26L35 44Z" />
      <path d="M30 35L35 49L29 60L38 54L42 70L45 51L53 40L43 45L40 35L37 48Z" fill="currentColor" stroke="none" />
      <path d="M11 15L17 34M60 60L63 80M26 77L25 86" strokeWidth="0.9" />
    </Drawing>
  );
}

export function StampRings(props: Props) {
  return (
    <Drawing viewBox="0 0 100 100" {...props}>
      <path d="M51 3C77 2 98 23 97 50C99 75 78 98 50 97C22 99 3 76 3 51C1 24 22 2 51 3Z" fill="var(--cobalt)" stroke="none" />
      <path d="M51 9C73 8 91 27 91 50C92 74 73 91 50 92C27 92 9 74 9 51C8 27 26 9 51 9Z" strokeWidth="1.4" strokeDasharray="5 4" />
      <path d="M20 17C29 8 39 5 49 5M94 47C96 66 87 80 77 87M7 61C9 73 15 81 25 87" strokeWidth="0.7" />
    </Drawing>
  );
}

export function TapeDrawing(props: Props) {
  return (
    <Drawing viewBox="0 0 90 32" {...props}>
      <path d="M5 3L13 5L18 3L23 5L29 3L35 4L42 3L49 5L57 3L65 4L72 3L83 5L80 10L85 15L80 19L83 28L75 26L68 29L61 27L53 28L45 26L38 28L31 27L24 29L17 27L7 28L10 23L5 18L9 13Z" fill="var(--paper)" fillOpacity="0.48" stroke="none" />
      <path d="M16 9L74 10M14 15L78 16M17 23L73 22" stroke="var(--paper)" strokeOpacity="0.3" strokeWidth="0.8" />
    </Drawing>
  );
}

export function SearchDrawing(props: Props) {
  return (
    <Drawing viewBox="0 0 40 44" {...props}>
      <path d="M29 16C30 24 24 30 16 29C8 30 3 24 4 16C3 8 9 3 17 4C24 3 30 9 29 16Z" />
      <path d="M25 17C25 23 21 26 16 25C10 26 7 21 8 16C7 11 11 7 17 8C22 7 26 12 25 17ZM25 27L36 39L32 41L23 29" strokeWidth="1.5" />
    </Drawing>
  );
}

export function NotebookPaper(props: Props) {
  return (
    <Drawing viewBox="0 0 320 66" preserveAspectRatio="none" {...props}>
      <path d="M2 2L318 1L319 64L1 65ZM6 9A3 3 0 1 0 6 15A3 3 0 1 0 6 9ZM6 24A3 3 0 1 0 6 30A3 3 0 1 0 6 24ZM6 39A3 3 0 1 0 6 45A3 3 0 1 0 6 39ZM6 54A3 3 0 1 0 6 60A3 3 0 1 0 6 54Z" fill="var(--paper)" fillRule="evenodd" stroke="none" />
      <path d="M24 54L303 55M313 9L313 59L296 59" stroke="var(--ink-soft)" strokeWidth="0.8" />
      <path d="M17 10h2M305 7h2M20 60h3M309 41h1M46 6h1" stroke="var(--paper-line)" strokeWidth="1" />
    </Drawing>
  );
}
