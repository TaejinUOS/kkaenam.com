/**
 * 유튜브 주소 해석과 임베드 주소 생성.
 *
 * 순수 함수만 둔다. 등록은 서버에서(`videoStore`), 재생은 클라이언트에서
 * (`VideoPanel`) 같은 규칙을 써야 하기 때문이다 — 한쪽에만 있으면 관리자 화면이
 * 받아들인 주소를 영상 탭이 못 그리는 어긋남이 생긴다.
 */

/** 유튜브 영상 ID. 11자의 base64url 문자다. */
const VIDEO_ID = /^[A-Za-z0-9_-]{11}$/;

/** 주소가 아니라 ID만 담긴 경로 꼴. `/embed/<id>`, `/shorts/<id>`, `/live/<id>`. */
const ID_IN_PATH = /^\/(?:embed|shorts|live|v)\/([A-Za-z0-9_-]{11})/;

/**
 * 사람이 붙여 넣은 것에서 영상 ID를 뽑는다. 못 뽑으면 null.
 *
 * 받는 꼴을 넓게 잡았다. 운영자는 주소창에서 복사하기도 하고, 공유 버튼이 주는
 * 짧은 주소를 쓰기도 하며, 유튜브 앱은 거기에 `?si=...` 추적 파라미터를 붙인다.
 * 어느 쪽을 붙여 넣든 같은 영상으로 들어와야 한다 — 그렇지 않으면 같은 영상이
 * 다른 행으로 두 번 등록된다.
 *
 * - `dQw4w9WgXcQ` (ID 그대로)
 * - `https://youtu.be/dQw4w9WgXcQ?si=...`
 * - `https://www.youtube.com/watch?v=dQw4w9WgXcQ&t=42s`
 * - `https://www.youtube.com/embed/dQw4w9WgXcQ`
 * - `https://www.youtube.com/shorts/dQw4w9WgXcQ`
 * - `https://m.youtube.com/...`, `https://www.youtube-nocookie.com/...`
 */
export function parseYouTubeId(input: string): string | null {
  const text = input.trim();
  if (!text) return null;
  if (VIDEO_ID.test(text)) return text;

  /*
   * 스킴이 없으면 붙여서 파싱한다. `youtu.be/xxx`만 복사해 오는 경우가 잦은데,
   * URL 생성자는 스킴 없는 문자열을 상대 경로로 보고 던진다.
   */
  const withScheme = /^https?:\/\//i.test(text) ? text : `https://${text}`;

  let url: URL;
  try {
    url = new URL(withScheme);
  } catch {
    return null;
  }

  const host = url.hostname.replace(/^www\.|^m\./, "");
  const isYouTube =
    host === "youtu.be" ||
    host === "youtube.com" ||
    host === "youtube-nocookie.com" ||
    host.endsWith(".youtube.com");
  if (!isYouTube) return null;

  // youtu.be는 경로 자체가 ID다.
  if (host === "youtu.be") {
    const id = url.pathname.slice(1);
    return VIDEO_ID.test(id) ? id : null;
  }

  const inPath = ID_IN_PATH.exec(url.pathname);
  if (inPath) return inPath[1];

  const v = url.searchParams.get("v");
  return v && VIDEO_ID.test(v) ? v : null;
}

/**
 * 썸네일 주소.
 *
 * `hqdefault`는 모든 영상에 반드시 있다. `maxresdefault`가 더 선명하지만 만들어지지
 * 않은 영상이 있어, 그 경우 유튜브가 회색 자리 이미지를 준다 — 어떤 영상에서는 되고
 * 어떤 영상에서는 안 되는 것보다 늘 같은 편이 낫다.
 */
export function youTubeThumbnailUrl(videoId: string): string {
  return `https://i.ytimg.com/vi/${videoId}/hqdefault.jpg`;
}

/**
 * 임베드 주소.
 *
 * `youtube-nocookie.com`을 쓴다. 시청 기록과 광고에 쓰이는 쿠키를 재생 전까지 심지
 * 않는 도메인이다 (개인정보처리방침 6조).
 * `rel=0`은 영상이 끝난 뒤 남의 채널 영상을 추천으로 채우지 않게 한다.
 */
export function youTubeEmbedUrl(videoId: string): string {
  return `https://www.youtube-nocookie.com/embed/${videoId}?autoplay=1&rel=0`;
}

/** 유튜브에서 바로 보기. 임베드가 막힌 영상을 위한 탈출구다. */
export function youTubeWatchUrl(videoId: string): string {
  return `https://www.youtube.com/watch?v=${videoId}`;
}
