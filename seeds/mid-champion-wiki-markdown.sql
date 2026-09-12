-- scripts/upgrade-mid-champion-wiki-markdown.ts가 생성.
-- 현재 리비전이 조사 당시와 같은 문서만 갱신해 이후 사용자 편집을 덮어쓰지 않는다.
-- 나피리: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-23010eca-0af1-4ee2-a3a2-ac98f90fa9f9' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-23010eca-0af1-4ee2-a3a2-ac98f90fa9f9-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-23010eca-0af1-4ee2-a3a2-ac98f90fa9f9-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-23010eca-0af1-4ee2-a3a2-ac98f90fa9f9' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-23010eca-0af1-4ee2-a3a2-ac98f90fa9f9-20260912');

-- 라이즈: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-67086497-75b0-4808-a001-3dddfeacc105' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-67086497-75b0-4808-a001-3dddfeacc105-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-67086497-75b0-4808-a001-3dddfeacc105-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-67086497-75b0-4808-a001-3dddfeacc105' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-67086497-75b0-4808-a001-3dddfeacc105-20260912');

-- 럭스: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-27bd0e78-66b0-4a9b-846a-32b18365e3ef' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-27bd0e78-66b0-4a9b-846a-32b18365e3ef-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-27bd0e78-66b0-4a9b-846a-32b18365e3ef-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-27bd0e78-66b0-4a9b-846a-32b18365e3ef' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-27bd0e78-66b0-4a9b-846a-32b18365e3ef-20260912');

-- 르블랑: r2 -> r3
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 3, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-ai-champion-leblanc-20260911' AND kind = 'article' AND revision = 2
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-leblanc-20260911-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-ai-champion-leblanc-20260911-20260912', id, NULL, 2, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 3
FROM wiki_docs WHERE id = 'doc-ai-champion-leblanc-20260911' AND revision = 3
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-leblanc-20260911-20260912');

-- 리산드라: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-132c9ef9-8e8b-4aff-8e16-2e4098465398' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-132c9ef9-8e8b-4aff-8e16-2e4098465398-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-132c9ef9-8e8b-4aff-8e16-2e4098465398-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-132c9ef9-8e8b-4aff-8e16-2e4098465398' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-132c9ef9-8e8b-4aff-8e16-2e4098465398-20260912');

-- 말자하: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-077fa2c7-41b2-4620-ae2c-185b81fe54d1' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-077fa2c7-41b2-4620-ae2c-185b81fe54d1-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-077fa2c7-41b2-4620-ae2c-185b81fe54d1-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-077fa2c7-41b2-4620-ae2c-185b81fe54d1' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-077fa2c7-41b2-4620-ae2c-185b81fe54d1-20260912');

-- 멜: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-5bd97d30-0917-495d-b049-bb438235d231' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-5bd97d30-0917-495d-b049-bb438235d231-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-5bd97d30-0917-495d-b049-bb438235d231-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-5bd97d30-0917-495d-b049-bb438235d231' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-5bd97d30-0917-495d-b049-bb438235d231-20260912');

-- 베이가: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-bed696ba-2310-4820-9cf4-ee5c34ae55a2' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-bed696ba-2310-4820-9cf4-ee5c34ae55a2-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-bed696ba-2310-4820-9cf4-ee5c34ae55a2-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-bed696ba-2310-4820-9cf4-ee5c34ae55a2' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-bed696ba-2310-4820-9cf4-ee5c34ae55a2-20260912');

-- 벡스: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-80df8739-7bdf-428b-9789-58571366b198' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-80df8739-7bdf-428b-9789-58571366b198-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-80df8739-7bdf-428b-9789-58571366b198-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-80df8739-7bdf-428b-9789-58571366b198' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-80df8739-7bdf-428b-9789-58571366b198-20260912');

-- 빅토르: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-f1404d69-50a3-4c61-9452-d31dd292564a' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-f1404d69-50a3-4c61-9452-d31dd292564a-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-f1404d69-50a3-4c61-9452-d31dd292564a-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-f1404d69-50a3-4c61-9452-d31dd292564a' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-f1404d69-50a3-4c61-9452-d31dd292564a-20260912');

-- 신드라: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-908b088a-d7ea-4d7a-bdc5-3c47ada13b5e' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-908b088a-d7ea-4d7a-bdc5-3c47ada13b5e-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-908b088a-d7ea-4d7a-bdc5-3c47ada13b5e-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-908b088a-d7ea-4d7a-bdc5-3c47ada13b5e' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-908b088a-d7ea-4d7a-bdc5-3c47ada13b5e-20260912');

-- 아리: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-2df64efd-93e1-4656-bddf-8f305f5df8cc' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-2df64efd-93e1-4656-bddf-8f305f5df8cc-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-2df64efd-93e1-4656-bddf-8f305f5df8cc-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-2df64efd-93e1-4656-bddf-8f305f5df8cc' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-2df64efd-93e1-4656-bddf-8f305f5df8cc-20260912');

-- 아우렐리온 솔: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-f1945b6e-3dee-45ee-b457-00c5384aa05c' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-f1945b6e-3dee-45ee-b457-00c5384aa05c-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-f1945b6e-3dee-45ee-b457-00c5384aa05c-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-f1945b6e-3dee-45ee-b457-00c5384aa05c' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-f1945b6e-3dee-45ee-b457-00c5384aa05c-20260912');

-- 아지르: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-5fc0f788-ca1b-4024-86b9-1d459c56490c' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-5fc0f788-ca1b-4024-86b9-1d459c56490c-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-5fc0f788-ca1b-4024-86b9-1d459c56490c-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-5fc0f788-ca1b-4024-86b9-1d459c56490c' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-5fc0f788-ca1b-4024-86b9-1d459c56490c-20260912');

-- 아칼리: r2 -> r3
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 3, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-ai-champion-akali-20260911' AND kind = 'article' AND revision = 2
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-akali-20260911-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-ai-champion-akali-20260911-20260912', id, NULL, 2, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 3
FROM wiki_docs WHERE id = 'doc-ai-champion-akali-20260911' AND revision = 3
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-akali-20260911-20260912');

-- 애니: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-65d0b98e-aca6-4035-a3bf-d7fd4faa29cf' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-65d0b98e-aca6-4035-a3bf-d7fd4faa29cf-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-65d0b98e-aca6-4035-a3bf-d7fd4faa29cf-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-65d0b98e-aca6-4035-a3bf-d7fd4faa29cf' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-65d0b98e-aca6-4035-a3bf-d7fd4faa29cf-20260912');

-- 애니비아: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-7f7d1f23-aefd-455d-995a-3d8fbb3539e5' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-7f7d1f23-aefd-455d-995a-3d8fbb3539e5-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-7f7d1f23-aefd-455d-995a-3d8fbb3539e5-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-7f7d1f23-aefd-455d-995a-3d8fbb3539e5' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-7f7d1f23-aefd-455d-995a-3d8fbb3539e5-20260912');

-- 오로라: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-2899fe45-3c51-4058-9487-26242464d8de' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-2899fe45-3c51-4058-9487-26242464d8de-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-2899fe45-3c51-4058-9487-26242464d8de-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-2899fe45-3c51-4058-9487-26242464d8de' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-2899fe45-3c51-4058-9487-26242464d8de-20260912');

-- 오리아나: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-0d4c7c07-b905-472f-9b4a-b4a94f0f08cb' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-0d4c7c07-b905-472f-9b4a-b4a94f0f08cb-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-0d4c7c07-b905-472f-9b4a-b4a94f0f08cb-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-0d4c7c07-b905-472f-9b4a-b4a94f0f08cb' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-0d4c7c07-b905-472f-9b4a-b4a94f0f08cb-20260912');

-- 제드: r2 -> r3
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 3, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-ai-champion-zed-20260911' AND kind = 'article' AND revision = 2
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-zed-20260911-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-ai-champion-zed-20260911-20260912', id, NULL, 2, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 3
FROM wiki_docs WHERE id = 'doc-ai-champion-zed-20260911' AND revision = 3
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-zed-20260911-20260912');

-- 제라스: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-d804656d-2129-4e55-b28c-658608efa1fd' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-d804656d-2129-4e55-b28c-658608efa1fd-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-d804656d-2129-4e55-b28c-658608efa1fd-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-d804656d-2129-4e55-b28c-658608efa1fd' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-d804656d-2129-4e55-b28c-658608efa1fd-20260912');

-- 조이: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-cc54cdde-cfcc-479d-9737-2b26f152b569' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-cc54cdde-cfcc-479d-9737-2b26f152b569-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-cc54cdde-cfcc-479d-9737-2b26f152b569-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-cc54cdde-cfcc-479d-9737-2b26f152b569' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-cc54cdde-cfcc-479d-9737-2b26f152b569-20260912');

-- 카시오페아: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-0e9226b2-5491-42cb-b678-0d9219f200c4' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-0e9226b2-5491-42cb-b678-0d9219f200c4-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-0e9226b2-5491-42cb-b678-0d9219f200c4-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-0e9226b2-5491-42cb-b678-0d9219f200c4' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-0e9226b2-5491-42cb-b678-0d9219f200c4-20260912');

-- 카타리나: r2 -> r3
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 3, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-ai-champion-katarina-20260911' AND kind = 'article' AND revision = 2
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-katarina-20260911-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-ai-champion-katarina-20260911-20260912', id, NULL, 2, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 3
FROM wiki_docs WHERE id = 'doc-ai-champion-katarina-20260911' AND revision = 3
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-katarina-20260911-20260912');

-- 키아나: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-3425cc0c-770c-44fb-9e75-434bc8f27357' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-3425cc0c-770c-44fb-9e75-434bc8f27357-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-3425cc0c-770c-44fb-9e75-434bc8f27357-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-3425cc0c-770c-44fb-9e75-434bc8f27357' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-3425cc0c-770c-44fb-9e75-434bc8f27357-20260912');

-- 탈론: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-0b3be62a-0b48-461d-8bef-96e5057ae96d' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-0b3be62a-0b48-461d-8bef-96e5057ae96d-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-0b3be62a-0b48-461d-8bef-96e5057ae96d-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-0b3be62a-0b48-461d-8bef-96e5057ae96d' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-0b3be62a-0b48-461d-8bef-96e5057ae96d-20260912');

-- 탈리야: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-6ac51090-21cb-4daf-a0c6-66e8482021c5' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-6ac51090-21cb-4daf-a0c6-66e8482021c5-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-6ac51090-21cb-4daf-a0c6-66e8482021c5-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-6ac51090-21cb-4daf-a0c6-66e8482021c5' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-6ac51090-21cb-4daf-a0c6-66e8482021c5-20260912');

-- 트위스티드 페이트: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-cfa6e563-1fcd-4407-b0f7-bf98b68fa239' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-cfa6e563-1fcd-4407-b0f7-bf98b68fa239-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-cfa6e563-1fcd-4407-b0f7-bf98b68fa239-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-cfa6e563-1fcd-4407-b0f7-bf98b68fa239' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-cfa6e563-1fcd-4407-b0f7-bf98b68fa239-20260912');

-- 피즈: r2 -> r3
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 3, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-ai-champion-fizz-20260911' AND kind = 'article' AND revision = 2
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-fizz-20260911-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-ai-champion-fizz-20260911-20260912', id, NULL, 2, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 3
FROM wiki_docs WHERE id = 'doc-ai-champion-fizz-20260911' AND revision = 3
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-ai-champion-fizz-20260911-20260912');

-- 흐웨이: r1 -> r2
UPDATE wiki_docs
SET general = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(general, CHAR(13) || CHAR(10), CHAR(10)), '

## 출처

', '

---

## 출처

> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.

'), '(Q)', '(`Q`)'), '(W)', '(`W`)'), '(E)', '(`E`)'), '(R)', '(`R`)'), '[[별길잡이] 아칼리의 모든 것!](', '[\[별길잡이\] 아칼리의 모든 것!]('), '[[버프] 마나가 안 닳는 에코!](', '[\[버프\] 마나가 안 닳는 에코!]('), '[[M1] 간단하게 보는 카타리나 공략](', '[\[M1\] 간단하게 보는 카타리나 공략]('),
    revision = 2, updated_at = '2026-09-12T13:15:00.000Z', updated_by = 'user-system'
WHERE id = 'doc-a-12ad2a64-3bb7-489e-8ccb-459432858e90' AND kind = 'article' AND revision = 1
  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'
  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'
  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-12ad2a64-3bb7-489e-8ccb-459432858e90-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-mid-champion-markdown-doc-a-12ad2a64-3bb7-489e-8ccb-459432858e90-20260912', id, NULL, 1, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', 'user-system', '2026-09-12T13:15:00.000Z', 'admin', 2
FROM wiki_docs WHERE id = 'doc-a-12ad2a64-3bb7-489e-8ccb-459432858e90' AND revision = 2
  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-mid-champion-markdown-doc-a-12ad2a64-3bb7-489e-8ccb-459432858e90-20260912');
