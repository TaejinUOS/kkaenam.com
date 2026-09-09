import { CategoryIcon } from "./categoryIcons";

type Props = {
  positionSlug: string;
  categorySlug: string;
  className?: string;
};

/** 목업의 재단된 형광 티켓. 문양·마모·장식 바코드를 하나의 SVG로 그린다. */
export function PosterIconSticker({ positionSlug, categorySlug, className }: Props) {
  return (
    <svg
      className={className}
      viewBox="0 0 144 104"
      fill="none"
      aria-hidden="true"
      focusable="false"
    >
      <path
        d="M12 3L44 2L46 3L87 2L89 3L137 2L140 7L139 20L141 22L140 57L142 60L140 94L133 100L99 99L96 101L56 100L53 102L8 101L3 94L4 72L2 69L4 44L3 41L5 13Z"
        fill="var(--label-bg, var(--acid))"
      />
      {/* 끊어진 윤곽과 가는 긁힘으로 닳은 인쇄 테두리를 만든다. */}
      <g stroke="currentColor" strokeLinecap="square">
        <path d="M8 35L9 15L16 8L48 7M55 7L88 7L96 8M101 7L132 7L135 12L134 38M135 45L136 90L130 95L101 94M94 95L57 95M48 96L12 96L8 89L9 76M8 68L9 43" strokeWidth="1.8" />
        <path d="M6 19L7 31M18 5L31 5M62 99L81 99M138 70L138 85M6 80L6 86" strokeWidth="0.7" />
      </g>
      <CategoryIcon positionSlug={positionSlug} categorySlug={categorySlug} x={12} y={13} width={86} height={80} />
      {/* 읽는 데이터가 없는 장식 바코드. 굵기와 간격을 불규칙하게 찍는다. */}
      <path
        d="M108 12h24v2h-24zM108 16h24v1h-24zM108 19h24v3h-24zM108 24h24v1h-24zM108 27h24v2h-24zM108 31h24v1h-24zM108 34h24v1h-24zM108 37h24v3h-24zM108 42h24v2h-24zM108 46h24v1h-24zM108 49h24v2h-24zM108 53h24v3h-24zM108 58h24v1h-24zM108 61h24v1h-24zM108 64h24v3h-24zM108 69h24v1h-24zM108 72h24v2h-24zM108 76h24v1h-24zM108 79h24v3h-24zM108 84h24v1h-24zM108 87h24v2h-24z"
        fill="currentColor"
      />
      <path
        d="M17 18h2v1h-2zM25 10h1v2h-1zM83 16h2v1h-2zM95 30h1v3h-1zM16 64h1v2h-1zM23 87h2v1h-2zM81 90h1v2h-1zM98 73h2v1h-2zM100 19h1v1h-1zM15 40h1v1h-1zM93 84h1v1h-1z"
        fill="currentColor"
        opacity="0.45"
      />
      <path d="M35 35l5 1M71 64l4 1M48 85l3-1" stroke="var(--label-bg, var(--acid))" strokeWidth="0.8" />
    </svg>
  );
}
