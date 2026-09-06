import Link from "next/link";

import { auth, signOut } from "@/auth";
import { BADGE_MAX, countUnreadNotifications } from "@/lib/notificationStore";

import styles from "./AuthStatus.module.css";

/**
 * 헤더의 로그인 상태 표시 (PRD FR-22). 서버 컴포넌트라 `layout.tsx`가
 * `SiteHeader`(클라이언트 컴포넌트)의 `children`으로 내려준다.
 *
 * 헤더에 남기는 것은 **여기서만 알 수 있는 것**뿐이다. 닉네임·내 편집·관리자 메뉴는
 * 마이페이지에 다 있어 헤더에 두 벌로 둘 이유가 없었지만, 새 소식이 있다는 사실은
 * 들어가 보기 전에는 알 수 없다. 그래서 그 자리를 알림이 받는다.
 */
export async function AuthStatus() {
  const session = await auth();

  if (!session?.user) {
    return (
      <div className={styles.wrap}>
        <Link className={styles.login} href="/login">
          로그인
        </Link>
      </div>
    );
  }

  const unread = await countUnreadNotifications(session.user.id);

  return (
    <div className={styles.wrap}>
      <Link
        className={styles.bell}
        href="/my/notifications"
        aria-label={unread > 0 ? `알림 ${unread}건` : "알림"}
      >
        <BellIcon />
        {unread > 0 && (
          /*
           * 숫자는 이름표(`aria-label`)가 이미 읽어 주므로 여기서는 감춘다.
           * 두 번 읽히면 "알림 3건 3"이 된다.
           */
          <span className={styles.badge} aria-hidden="true">
            {unread > BADGE_MAX ? `${BADGE_MAX}+` : unread}
          </span>
        )}
      </Link>

      <form
        action={async () => {
          "use server";
          await signOut({ redirectTo: "/" });
        }}
      >
        <button className={styles.signOut} type="submit">
          로그아웃
        </button>
      </form>
    </div>
  );
}

/** 종. 획 하나로 그린다 — 헤더의 다른 아이콘(아바타)과 같은 두께를 쓴다. */
function BellIcon() {
  return (
    <svg
      className={styles.bellIcon}
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
    >
      <path d="M18 9a6 6 0 1 0-12 0c0 5-2 6.5-2 6.5h16S18 14 18 9Z" />
      <path d="M13.7 19a2 2 0 0 1-3.4 0" />
    </svg>
  );
}
