"use client";

import { useActionState, useState } from "react";
import { useFormStatus } from "react-dom";

import { deleteArticleAction, type ActionState } from "@/lib/actions/wikiEditActions";
import { eulReul, eunNeun } from "@/lib/josa";

import styles from "./DeleteArticleButton.module.css";

type Props = {
  /** 내릴 문서의 `title_key`. 서버가 이 값으로 다시 찾는다. */
  titleKey: string;
  title: string;
  /** 이 문서 아래에 달린 문서 수. 0이 아니면 경고를 함께 보여 준다. */
  childCount: number;
};

/**
 * 일반 문서를 내리는 버튼 (운영자 전용).
 *
 * `RevertButton`과 같이 인라인 2단계 확인을 쓴다 — `window.confirm`은 무엇을 잃는지
 * 설명할 자리가 없다. 여기서는 설명할 것이 둘이다: 역사는 남는다는 것과, 아래 달린
 * 문서가 나무에서 끊긴다는 것.
 */
export function DeleteArticleButton({ titleKey, title, childCount }: Props) {
  const [confirming, setConfirming] = useState(false);
  const boundAction = deleteArticleAction.bind(null, titleKey);
  const [state, formAction] = useActionState<ActionState, FormData>(boundAction, null);

  if (!confirming) {
    return (
      <div className={styles.wrap}>
        <button type="button" className={styles.trigger} onClick={() => setConfirming(true)}>
          문서 내리기
        </button>
        {state && !state.ok && <p className={styles.error}>{state.message}</p>}
      </div>
    );
  }

  return (
    <form action={formAction} className={styles.confirm}>
      {/* 문서 이름이 데이터에서 오므로 조사를 문구에 고정하지 않는다 (AGENTS.md "한국어 조사"). */}
      <p className={styles.lead}>
        <strong>{title}</strong>
        {eulReul(title)} 목록·검색·링크·나무에서 내립니다. 문서의
        역사와 기여 기록은 지워지지 않고, 나중에 되돌릴 수 있습니다.
      </p>

      {/*
        이름을 놓아주는 것이 이 조작에서 유일하게 되돌리기 어려운 부분이다. 그 사이
        누가 같은 이름으로 문서를 만들면 복구가 막히므로 미리 적어 둔다.
      */}
      <p className={styles.note}>
        이름 <code className={styles.code}>{title}</code>
        {eunNeun(title)} 다시 비어 다른 사람이 쓸 수 있게 됩니다.
      </p>

      {childCount > 0 && (
        <p className={styles.warn}>
          이 문서 아래에 문서 {childCount}개가 달려 있습니다. 내리면 그 문서들은 나무에서
          끊겨 검색으로만 닿게 됩니다.
        </p>
      )}

      <label className={styles.field}>
        <span className={styles.label}>내리는 사유</span>
        <input type="text" name="reason" className={styles.input} required autoFocus />
      </label>

      {state && !state.ok && <p className={styles.error}>{state.message}</p>}

      <div className={styles.actions}>
        <ConfirmButton />
        <button type="button" className="btn" onClick={() => setConfirming(false)}>
          취소
        </button>
      </div>
    </form>
  );
}

function ConfirmButton() {
  const { pending } = useFormStatus();
  return (
    <button type="submit" className={styles.danger} disabled={pending}>
      {pending ? "내리는 중..." : "내리기 확정"}
    </button>
  );
}
