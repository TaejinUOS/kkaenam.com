-- 일반 문서 내리기 (운영자 전용).
--
-- **행을 지우지 않는다.** `wiki_edits`와 `wiki_sections`가 `wiki_docs`를
-- `ON DELETE CASCADE`로 참조하므로(마이그레이션 0001), 문서 행을 지우면 그 문서의
-- 모든 리비전·검토 사유·기여 기록이 함께 사라진다. 그건 "문서 하나를 없애는 일"이
-- 아니라 "여러 사람이 남긴 기록을 없애는 일"이다 — 회원 탈퇴에서도 글은 남기기로 한
-- 것과 같은 이유다 (`docs/WIKI_MODEL.md`, 개인정보처리방침 5항).
--
-- 대신 `doc_status`에 값을 하나 더한다: 'deleted'. 목록·검색·링크·나무를 읽는 질의는
-- 전부 이미 `doc_status = 'published'`로 거르고 있어, 내려간 문서는 그 순간 어디에도
-- 나오지 않는다.
--
-- 이름(`title_key`)은 삭제할 때 비운다. 거절된 문서 제안과 같은 처리다 — 이름을 계속
-- 쥐고 있으면 누구도 그 이름으로 다시 쓸 수 없는데, 정작 그 문서는 아무 데서도 보이지
-- 않는다. 이름은 놓아주고 행은 남긴다.
--
-- 아래 세 열은 **누가·언제·왜** 내렸는지를 남기기 위한 것이다. 되돌릴 수 있는 조작은
-- 근거가 함께 남아야 한다 (검토 거절이 사유를 요구하는 것과 같다).

ALTER TABLE wiki_docs ADD COLUMN deleted_at TEXT;
ALTER TABLE wiki_docs ADD COLUMN deleted_by TEXT REFERENCES users(id);
ALTER TABLE wiki_docs ADD COLUMN delete_reason TEXT;
