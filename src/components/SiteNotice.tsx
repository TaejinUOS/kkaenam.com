"use client";

import Link from "next/link";
import { useState } from "react";

import { ACTIVE_NOTICE, NOTICE_COOKIE } from "@/data/siteNotice";

import styles from "./SiteNotice.module.css";

/** 닫은 공지를 다시 띄우지 않는 기간. 1년이면 같은 공지를 다시 볼 일이 없다. */
const REMEMBER_SECONDS = 60 * 60 * 24 * 365;

/**
 * 헤더 아래 한 줄짜리 공지 배너.
 *
 * 닫았는지는 **서버가 쿠키로 미리 판단해** `dismissed`로 넘겨준다. 그래야 이미 닫은
 * 사람의 화면에서 배너가 한 번 그려졌다 사라지며 본문이 밀리는 일이 없다
 * (`data/siteNotice.ts`의 `NOTICE_COOKIE`).
 *
 * 닫기는 그 자리에서 끝난다 — 쿠키를 적고 상태로 감춘다. `router.refresh()`로
 * 서버에 다시 물어볼 수도 있지만, 줄 하나 지우자고 페이지를 통째로 다시 받는 것은
 * 값이 맞지 않는다.
 */
export function SiteNotice({ dismissed }: { dismissed: boolean }) {
  const [hidden, setHidden] = useState(dismissed);

  /*
   * 지역 상수로 한 번 받는다. `ACTIVE_NOTICE`를 그대로 쓰면 아래 `close` 안에서는
   * null이 아니라는 것이 유지되지 않는다 — 타입 좁히기가 콜백 경계를 넘지 못한다.
   */
  const notice = ACTIVE_NOTICE;
  if (!notice || hidden) return null;

  const close = () => {
    /*
     * 브라우저가 쿠키를 막아 두면 `document.cookie`가 조용히 아무것도 하지 않는다.
     * 그래도 이번 세션에서는 닫혀야 하므로 상태는 그것과 무관하게 바꾼다.
     */
    try {
      document.cookie = `${NOTICE_COOKIE}=${notice.id}; path=/; max-age=${REMEMBER_SECONDS}; samesite=lax`;
    } catch {
      /* 닫기는 편의일 뿐이라 실패해도 알릴 것이 없다. */
    }
    setHidden(true);
  };

  return (
    /*
     * `role="region"`과 이름을 준다. 화면 낭독기 사용자가 본문으로 건너뛴 뒤에도
     * 이 줄을 되찾을 수 있어야 한다.
     */
    <aside className={styles.notice} role="region" aria-label="사이트 공지">
      <div className={`shell ${styles.bar}`}>
        <span className={`mono ${styles.label}`}>{notice.label}</span>

        <p className={styles.body}>
          {notice.body}{" "}
          <Link className={styles.link} href={notice.href}>
            {notice.linkLabel}
          </Link>
        </p>

        <button type="button" className={styles.close} onClick={close} aria-label="공지 닫기">
          <span aria-hidden="true">×</span>
        </button>
      </div>
    </aside>
  );
}
