/**
 * 운영 중인 미드 챔피언 일반 문서의 마크다운 표현을 보강한다.
 * 실행: npx tsx scripts/upgrade-mid-champion-wiki-markdown.ts
 */
import { writeFileSync } from "node:fs";

import { SYSTEM_USER_ID } from "../src/data/wiki";

const CREATED_AT = "2026-09-12T13:15:00.000Z";
const OUTPUT = "seeds/mid-champion-wiki-markdown.sql";

const targets = [
  { id: "doc-a-23010eca-0af1-4ee2-a3a2-ac98f90fa9f9", title: "나피리", revision: 1 },
  { id: "doc-a-67086497-75b0-4808-a001-3dddfeacc105", title: "라이즈", revision: 1 },
  { id: "doc-a-27bd0e78-66b0-4a9b-846a-32b18365e3ef", title: "럭스", revision: 1 },
  { id: "doc-ai-champion-leblanc-20260911", title: "르블랑", revision: 2 },
  { id: "doc-a-132c9ef9-8e8b-4aff-8e16-2e4098465398", title: "리산드라", revision: 1 },
  { id: "doc-a-077fa2c7-41b2-4620-ae2c-185b81fe54d1", title: "말자하", revision: 1 },
  { id: "doc-a-5bd97d30-0917-495d-b049-bb438235d231", title: "멜", revision: 1 },
  { id: "doc-a-bed696ba-2310-4820-9cf4-ee5c34ae55a2", title: "베이가", revision: 1 },
  { id: "doc-a-80df8739-7bdf-428b-9789-58571366b198", title: "벡스", revision: 1 },
  { id: "doc-a-f1404d69-50a3-4c61-9452-d31dd292564a", title: "빅토르", revision: 1 },
  { id: "doc-a-908b088a-d7ea-4d7a-bdc5-3c47ada13b5e", title: "신드라", revision: 1 },
  { id: "doc-a-2df64efd-93e1-4656-bddf-8f305f5df8cc", title: "아리", revision: 1 },
  { id: "doc-a-f1945b6e-3dee-45ee-b457-00c5384aa05c", title: "아우렐리온 솔", revision: 1 },
  { id: "doc-a-5fc0f788-ca1b-4024-86b9-1d459c56490c", title: "아지르", revision: 1 },
  { id: "doc-ai-champion-akali-20260911", title: "아칼리", revision: 2 },
  { id: "doc-a-65d0b98e-aca6-4035-a3bf-d7fd4faa29cf", title: "애니", revision: 1 },
  { id: "doc-a-7f7d1f23-aefd-455d-995a-3d8fbb3539e5", title: "애니비아", revision: 1 },
  { id: "doc-a-2899fe45-3c51-4058-9487-26242464d8de", title: "오로라", revision: 1 },
  { id: "doc-a-0d4c7c07-b905-472f-9b4a-b4a94f0f08cb", title: "오리아나", revision: 1 },
  { id: "doc-ai-champion-zed-20260911", title: "제드", revision: 2 },
  { id: "doc-a-d804656d-2129-4e55-b28c-658608efa1fd", title: "제라스", revision: 1 },
  { id: "doc-a-cc54cdde-cfcc-479d-9737-2b26f152b569", title: "조이", revision: 1 },
  { id: "doc-a-0e9226b2-5491-42cb-b678-0d9219f200c4", title: "카시오페아", revision: 1 },
  { id: "doc-ai-champion-katarina-20260911", title: "카타리나", revision: 2 },
  { id: "doc-a-3425cc0c-770c-44fb-9e75-434bc8f27357", title: "키아나", revision: 1 },
  { id: "doc-a-0b3be62a-0b48-461d-8bef-96e5057ae96d", title: "탈론", revision: 1 },
  { id: "doc-a-6ac51090-21cb-4daf-a0c6-66e8482021c5", title: "탈리야", revision: 1 },
  { id: "doc-a-cfa6e563-1fcd-4407-b0f7-bf98b68fa239", title: "트위스티드 페이트", revision: 1 },
  { id: "doc-ai-champion-fizz-20260911", title: "피즈", revision: 2 },
  { id: "doc-a-12ad2a64-3bb7-489e-8ccb-459432858e90", title: "흐웨이", revision: 1 },
] as const;

const quote = (value: string) => `'${value.replace(/'/g, "''")}'`;

function upgradedBodyExpression() {
  let expression = "REPLACE(general, CHAR(13) || CHAR(10), CHAR(10))";
  expression = `REPLACE(${expression}, ${quote("\n\n## 출처\n\n")}, ${quote(
    "\n\n---\n\n## 출처\n\n> **출처 링크** — 아래 제목을 누르면 참고한 인벤 원문을 새 탭에서 확인할 수 있다.\n\n",
  )})`;

  for (const key of ["Q", "W", "E", "R"]) {
    expression = `REPLACE(${expression}, ${quote(`(${key})`)}, ${quote(`(\`${key}\`)`)})`;
  }

  const labelFixes = [
    ["[[별길잡이] 아칼리의 모든 것!](", "[\\[별길잡이\\] 아칼리의 모든 것!]("],
    ["[[버프] 마나가 안 닳는 에코!](", "[\\[버프\\] 마나가 안 닳는 에코!]("],
    ["[[M1] 간단하게 보는 카타리나 공략](", "[\\[M1\\] 간단하게 보는 카타리나 공략]("],
  ] as const;
  for (const [before, after] of labelFixes) {
    expression = `REPLACE(${expression}, ${quote(before)}, ${quote(after)})`;
  }

  return expression;
}

const lines = [
  "-- scripts/upgrade-mid-champion-wiki-markdown.ts가 생성.",
  "-- 현재 리비전이 조사 당시와 같은 문서만 갱신해 이후 사용자 편집을 덮어쓰지 않는다.",
];

for (const target of targets) {
  const editId = `edit-mid-champion-markdown-${target.id}-${CREATED_AT.slice(0, 10).replaceAll("-", "")}`;
  const nextRevision = target.revision + 1;
  lines.push(
    `-- ${target.title}: r${target.revision} -> r${nextRevision}`,
    "UPDATE wiki_docs",
    `SET general = ${upgradedBodyExpression()},`,
    `    revision = ${nextRevision}, updated_at = ${quote(CREATED_AT)}, updated_by = ${quote(SYSTEM_USER_ID)}`,
    `WHERE id = ${quote(target.id)} AND kind = 'article' AND revision = ${target.revision}`,
    "  AND general LIKE '# 라인전 실전 팁%' AND general LIKE '%## 출처%'",
    "  AND general LIKE '%](http%' AND general NOT LIKE '%**출처 링크**%'",
    `  AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = ${quote(editId)});`,
    "INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)",
    `SELECT ${quote(editId)}, id, NULL, ${target.revision}, general, '미드 챔피언 문서 마크다운·출처 링크 정리', 'accepted', ${quote(SYSTEM_USER_ID)}, ${quote(CREATED_AT)}, 'admin', ${nextRevision}`,
    `FROM wiki_docs WHERE id = ${quote(target.id)} AND revision = ${nextRevision}`,
    `  AND general LIKE '%**출처 링크**%' AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = ${quote(editId)});`,
    "",
  );
}

writeFileSync(OUTPUT, `${lines.join("\n").trimEnd()}\n`);
console.log(`생성: ${OUTPUT} (문서 ${targets.length}개)`);
