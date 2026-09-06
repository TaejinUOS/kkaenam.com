"use client";

import { useActionState } from "react";
import { useFormStatus } from "react-dom";

import { restoreArticleAction, type ActionState } from "@/lib/actions/wikiEditActions";

import styles from "./RestoreArticleButton.module.css";

/**
 * 내린 문서를 되돌리는 버튼.
 *
 * 내리기와 달리 2단계 확인이 없다. 되돌리기는 문서를 되살리는 쪽이라 잘못 눌러도
 * 잃는 것이 없고, 다시 내리면 그만이다.
 */
export function RestoreArticleButton({ docId, title }: { docId: string; title: string }) {
  const [state, formAction] = useActionState<ActionState, FormData>(restoreArticleAction, null);

  if (state?.ok) return <p className={styles.success}>{state.message}</p>;

  return (
    <form action={formAction} className={styles.form}>
      <input type="hidden" name="docId" value={docId} />
      <RestoreButton title={title} />
      {state && !state.ok && <p className={styles.error}>{state.message}</p>}
    </form>
  );
}

function RestoreButton({ title }: { title: string }) {
  const { pending } = useFormStatus();
  return (
    <button type="submit" className="btn btn--acid" disabled={pending}>
      {pending ? "되돌리는 중..." : `${title} 되돌리기`}
    </button>
  );
}
