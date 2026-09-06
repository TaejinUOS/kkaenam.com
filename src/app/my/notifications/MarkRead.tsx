"use client";

import { useEffect, useRef } from "react";

import { markNotificationsReadAction } from "@/lib/actions/notificationActions";

/**
 * 화면을 열었다는 사실을 서버에 알린다.
 *
 * 목록이 그려진 뒤에 도는 것이 요점이다 — 그리는 도중에 읽음 처리를 하면 같은 요청에서
 * 헤더 배지가 언제 그려졌느냐에 따라 숫자가 남기도 하고 사라지기도 한다.
 * 액션이 레이아웃을 무르면서 배지가 확실히 0이 된다.
 */
export function MarkRead() {
  const done = useRef(false);

  useEffect(() => {
    /* 개발 모드의 Strict Mode는 effect를 두 번 돌린다. 쓰기가 두 번 가지 않게 막는다. */
    if (done.current) return;
    done.current = true;
    void markNotificationsReadAction();
  }, []);

  return null;
}
