"use server";

/**
 * 운영자 선별 영상 편집 서버 액션 (PRD 5.3.2).
 *
 * `taxonomyActions`와 같은 모양이다 — 평범한 form action이고, 결과는 값이 아니라
 * 리다이렉트로 알린다. 영상 하나를 넣고 빼는 조작에 클라이언트 상태를 둘 값이 없다.
 */

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

import { requireActionAdmin } from "@/lib/authGuard";
import { addVideo, moveVideo, removeVideo, setVideoPublished } from "@/lib/videoStore";

/**
 * 영상이 바뀌면 다시 그려야 하는 화면.
 *
 * 그 챔피언의 상대법 페이지만 무효화한다. 분류와 달리 영상은 **한 챔피언 안에서만**
 * 보이므로 다른 화면은 건드릴 이유가 없다.
 */
function revalidateVideos(championSlug: string) {
  revalidatePath(`/matchup/${championSlug}`);
  revalidatePath("/admin/videos");
  return `/admin/videos?champion=${championSlug}`;
}

export async function addVideoAction(formData: FormData): Promise<void> {
  const auth = await requireActionAdmin();
  if (!auth.ok) redirect(auth.error === "unauthenticated" ? "/login" : "/");

  const championSlug = String(formData.get("championSlug") ?? "");
  const url = String(formData.get("url") ?? "");
  const title = String(formData.get("title") ?? "");

  const result = await addVideo(championSlug, url, title, auth.viewer.id);
  const back = revalidateVideos(championSlug);
  redirect(result.ok ? `${back}&done=added` : `${back}&error=${result.error}`);
}

export async function removeVideoAction(formData: FormData): Promise<void> {
  const auth = await requireActionAdmin();
  if (!auth.ok) redirect(auth.error === "unauthenticated" ? "/login" : "/");

  const championSlug = String(formData.get("championSlug") ?? "");
  await removeVideo(String(formData.get("id") ?? ""));
  redirect(`${revalidateVideos(championSlug)}&done=removed`);
}

/**
 * 영상을 감추거나 다시 보인다.
 *
 * 지우기와 다른 조작이다. 감춘 영상은 목록에 남아 언제든 되돌릴 수 있고, 지운 영상은
 * 운영자가 주소를 다시 찾아와야 한다.
 */
export async function setVideoPublishedAction(formData: FormData): Promise<void> {
  const auth = await requireActionAdmin();
  if (!auth.ok) redirect(auth.error === "unauthenticated" ? "/login" : "/");

  const championSlug = String(formData.get("championSlug") ?? "");
  const published = String(formData.get("published") ?? "") === "1";

  await setVideoPublished(String(formData.get("id") ?? ""), published);
  redirect(`${revalidateVideos(championSlug)}&done=${published ? "shown" : "hidden"}`);
}

export async function moveVideoAction(formData: FormData): Promise<void> {
  const auth = await requireActionAdmin();
  if (!auth.ok) redirect(auth.error === "unauthenticated" ? "/login" : "/");

  const championSlug = String(formData.get("championSlug") ?? "");
  const direction = String(formData.get("direction") ?? "") === "up" ? "up" : "down";

  await moveVideo(String(formData.get("id") ?? ""), direction);
  /*
   * 순서를 바꾼 뒤에는 `done` 문구를 붙이지 않는다. 결과가 바로 눈앞의 목록에
   * 보이므로, 한 칸 옮길 때마다 안내 줄이 뜨면 그게 더 시끄럽다.
   */
  redirect(revalidateVideos(championSlug));
}
