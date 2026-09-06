"use server";

/**
 * 알림 서버 액션.
 *
 * 읽음 처리는 화면을 여는 것 자체가 신호다. 그런데 Server Component가 그리는 도중에
 * 쓰기를 하면 그 요청 안에서 헤더 배지가 이미 그려졌을 수도, 아직일 수도 있어 숫자가
 * 남았다 말았다 한다. 그래서 목록을 다 그린 **뒤에** 화면이 이 액션을 부르고
 * (`MarkRead.tsx`), 그때 레이아웃을 무르게 해 배지가 확실히 0이 되게 한다.
 */

import { revalidatePath } from "next/cache";

import { requireActionUser } from "@/lib/authGuard";
import { markNotificationsRead } from "@/lib/notificationStore";

export async function markNotificationsReadAction(): Promise<void> {
  const auth = await requireActionUser();
  if (!auth.ok) return;

  await markNotificationsRead(auth.viewer.id);

  /* 배지는 레이아웃(헤더)에 있다. 페이지만 무르면 숫자가 그대로 남는다. */
  revalidatePath("/", "layout");
}
