import type { JSX, SVGProps } from "react";

/**
 * 포지션별 카테고리 포스터 우하단에 붙는 스티커 아이콘.
 * 블루프린트의 표창(암살자)/불꽃(메이지)/검(브루저) 스티커를 기준으로
 * 목업처럼 면으로 찍은 실루엣을 기준으로 모든 포지션의 인쇄 굵기를 맞춘다.
 */

type IconProps = SVGProps<SVGSVGElement>;

function Base({ children, ...props }: IconProps & { children: React.ReactNode }) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth={1.8}
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
      focusable="false"
      {...props}
    >
      {children}
    </svg>
  );
}

function ShieldIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <path d="M50 5L88 20L84 57C81 75 66 88 50 96C34 88 19 75 16 57L12 20ZM50 17L24 27L27 56C29 67 38 77 50 84C62 77 71 67 73 56L76 27Z" fill="currentColor" fillRule="evenodd" stroke="none" />
      <path d="M47 28H56V47H69V56H56V73L47 78V56H33V47H47Z" fill="currentColor" stroke="none" />
    </Base>
  );
}

function CrossedSwordsIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <g fill="currentColor" stroke="none">
        <path d="M9 5L31 14L69 61L77 55L84 64L74 72L88 87L80 94L66 79L57 87L50 78L58 70L18 25Z" />
        <path d="M91 5L69 14L52 35L63 49L82 25ZM38 51L31 61L23 55L16 64L26 72L12 87L20 94L34 79L43 87L50 78L42 70L47 64Z" />
      </g>
    </Base>
  );
}

function DaggerIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <path d="M91 5L77 43L49 68L32 51L57 23ZM77 20L41 54L48 58Z" fill="currentColor" fillRule="evenodd" stroke="none" />
      <path d="M25 45L55 75L46 82L38 74L22 93L9 81L28 64L18 54Z" fill="currentColor" stroke="none" />
    </Base>
  );
}

function ClawIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <g fill="currentColor" stroke="none">
        <path d="M25 10L40 18L31 29L33 34C20 53 20 68 28 88C7 72 5 55 13 35L18 32L17 24Z" />
        <path d="M50 4L66 12L56 26L58 31C44 53 43 75 49 97C29 78 29 56 39 30L44 27L42 20Z" />
        <path d="M78 10L91 20L82 32L84 37C70 57 64 75 66 93C51 76 57 52 67 32L72 28L71 22Z" />
      </g>
    </Base>
  );
}

function SparkIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <path d="M61 3L23 53L45 58L34 96L80 40L57 36Z" fill="currentColor" stroke="none" />
      <path d="M34 14C15 25 9 42 14 58M12 70L20 78M69 84C87 73 94 56 89 40M87 28L80 20" strokeWidth="5" strokeLinecap="butt" />
    </Base>
  );
}

/** 휘어진 네 날과 원형 축. 가운데 구멍은 배경색 대신 실제 투명한 패스로 뚫는다. */
export function ShurikenIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <g fill="currentColor" stroke="none">
        {[0, 90, 180, 270].map((angle) => (
          <path
            key={angle}
            transform={`rotate(${angle} 50 50)`}
            d="M48 38C58 24 73 16 91 12C89 28 82 42 69 51L73 33L58 48Z"
          />
        ))}
      </g>
      <path
        d="M50 34A16 16 0 1 0 50 66A16 16 0 1 0 50 34ZM50 44A6 6 0 1 0 50 56A6 6 0 1 0 50 44Z"
        fillRule="evenodd"
        fill="currentColor"
        stroke="none"
      />
    </Base>
  );
}

function FlameIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <g fill="currentColor" stroke="none">
        <path d="M47 4C61 17 67 29 67 41C73 37 73 32 72 28C91 45 97 65 86 80C81 88 74 92 66 94C77 83 77 71 69 61C68 68 64 73 60 75C61 61 52 51 50 41C46 56 31 65 33 79C34 86 38 91 44 95C26 93 13 82 12 68C12 60 16 52 22 47C18 61 23 68 27 70C19 43 49 33 47 4Z" />
        <path d="M50 67C51 74 54 78 58 81L64 76C69 87 61 96 52 96C42 96 36 86 41 78L45 82C45 76 47 71 50 67Z" />
      </g>
    </Base>
  );
}

function SwordIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <g fill="currentColor" stroke="none">
        {/* 서로 반대 방향으로 뻗는 두 칼날과 각진 가드. */}
        <path d="M79 5L71 35L65 26L39 52L44 57L31 59L21 69L15 63L25 53L27 40L32 45L58 19L49 15Z" />
        <path d="M79 5L71 35L65 26L39 52L44 57L31 59L21 69L15 63L25 53L27 40L32 45L58 19L49 15Z" transform="rotate(180 50 50)" />
      </g>
    </Base>
  );
}

function BowIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <path d="M19 14C43 5 77 31 85 61L80 78L69 73C71 55 48 30 29 27L23 34Z" fill="currentColor" stroke="none" />
      <path d="M21 19L22 77L78 76" strokeWidth="3" strokeLinejoin="miter" />
      <path d="M86 11L77 37L71 29L31 70L31 79L16 94L17 82L6 83L21 68L28 68L67 25L59 21Z" fill="currentColor" stroke="none" />
    </Base>
  );
}

function HeartIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <path d="M50 89L19 60C-9 34 17 1 41 19L50 28L59 19C83 1 109 34 81 60ZM21 28C14 34 15 44 21 49L25 43C21 39 23 34 26 32Z" fill="currentColor" fillRule="evenodd" stroke="none" />
      <path d="M6 66L16 76M26 86L34 93M83 74L93 65" strokeWidth="3" />
    </Base>
  );
}

function HookIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <path d="M43 4A12 12 0 1 0 43 28A12 12 0 1 0 43 4ZM43 11A5 5 0 1 0 43 21A5 5 0 1 0 43 11Z" fill="currentColor" fillRule="evenodd" stroke="none" />
      <path d="M38 26H49V67C49 90 77 86 78 67L64 70L89 42L91 69C91 107 37 109 37 70Z" fill="currentColor" stroke="none" />
      <path d="M31 34L54 29M32 42L54 37M32 50L54 45" strokeWidth="3" />
    </Base>
  );
}

function ChaosIcon(props: IconProps) {
  return (
    <Base viewBox="0 0 100 100" {...props}>
      <path d="M13 31C9 7 57 1 63 24C69 46 43 45 43 62L30 65C26 41 53 40 50 27C47 15 26 20 27 31Z" fill="currentColor" stroke="none" />
      <path d="M74 13L92 17L78 66L69 64ZM29 74L43 72L45 88L31 91ZM67 75L81 78L76 93L63 89Z" fill="currentColor" stroke="none" />
    </Base>
  );
}

const CATEGORY_ICONS: Record<string, (props: IconProps) => JSX.Element> = {
  "top/tank": ShieldIcon,
  "top/bruiser": CrossedSwordsIcon,
  "top/damage": DaggerIcon,
  "jungle/ad": ClawIcon,
  "jungle/ap": SparkIcon,
  "mid/assassin": ShurikenIcon,
  "mid/mage": FlameIcon,
  "mid/bruiser-adc": SwordIcon,
  "adc/adc": BowIcon,
  "adc/non-adc": FlameIcon,
  "support/mom": HeartIcon,
  "support/dad": HookIcon,
  "support/wtf": ChaosIcon,
};

type CategoryIconProps = IconProps & { positionSlug: string; categorySlug: string };

export function CategoryIcon({ positionSlug, categorySlug, ...props }: CategoryIconProps) {
  const Icon = CATEGORY_ICONS[`${positionSlug}/${categorySlug}`] ?? ShurikenIcon;
  return <Icon {...props} />;
}
