/**
 * 요청받은 미드 챔피언 일반 위키. 원고는 seeds/champion-wiki/*.md.
 * 기존 이름을 차지한 문서는 건너뛴다. 재실행해도 내용·리비전을 덮어쓰지 않는다.
 * 실행: npx tsx scripts/seed-champion-wiki.ts
 * 적용: npx wrangler d1 execute kkaenam-gg --local --file seeds/champion-wiki.sql
 * 운영 적용은 같은 명령의 --local을 --remote로 바꾼다.
 */
import assert from "node:assert/strict";
import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import catalog from "../src/data/generated/champions.json";
import { MAX_BODY_LENGTH, SYSTEM_USER_ID } from "../src/data/wiki";
import {
  AI_DRAFT_HEADING,
  buildOutline,
  collectWikiLinkTitles,
  extractFootnotes,
} from "../src/lib/wikiMarkup";
import { unresolvedWikiTitles } from "../src/lib/wikiLink";
import { checkArticleTitle, titleKey } from "../src/lib/wikiTitle";

const drafts = [
  // 2026-09-11 운영 D1의 mid / assassin sort_order 1~5를 확인한 명단.
  ...["katarina", "zed", "akali", "fizz", "leblanc"].map((slug) => ({
    slug,
    createdAt: "2026-09-11T05:03:01.000Z",
    richMarkup: false,
  })),
  // 2026-09-12 taxonomy.ts의 mid / bruiser-adc 전체 명단.
  ...[
    "sylas",
    "yone",
    "yasuo",
    "galio",
    "ekko",
    "diana",
    "irelia",
    "sion",
    "corki",
    "jayce",
    "smolder",
    "tristana",
    "akshan",
    "locke",
  ].map((slug) => ({
    slug,
    createdAt: "2026-09-12T00:00:00.000Z",
    richMarkup: true,
  })),
];
const quote = (value: string) => `'${value.replace(/'/g, "''")}'`;
const lines = [
  "-- scripts/seed-champion-wiki.ts가 생성. 원고는 seeds/champion-wiki/*.md.",
  "-- 운영자의 작성 요청에 따른 시스템 이관. 새 문서와 최초 편집 이력만 추가한다.",
  "-- 기존 문서·제안·작성자 권한은 변경하지 않는다. 시스템 계정이 없으면 FK로 실패한다.",
];

for (const { slug, createdAt, richMarkup } of drafts) {
  const champion = catalog.champions.find((entry) => entry.slug === slug);
  assert(champion, `카탈로그에 없는 챔피언: ${slug}`);
  assert.equal(checkArticleTitle(champion.name), null);
  const body = readFileSync(join("seeds/champion-wiki", `${slug}.md`), "utf8")
    .replace(/\r\n?/g, "\n")
    .trim();
  assert(body.startsWith(`# ${AI_DRAFT_HEADING}\n\n`));
  assert(body.length <= MAX_BODY_LENGTH);
  const outline = buildOutline(body, "article-body", 2, new Set());
  assert.equal(outline.children.length, 1);
  assert.equal(outline.children[0].title, AI_DRAFT_HEADING);
  assert(outline.children[0].children.length >= (richMarkup ? 3 : 5));
  if (richMarkup) {
    assert(body.includes("**"), `${slug}: 강조 문법 누락`);
    assert(/^- /mu.test(body), `${slug}: 목록 문법 누락`);
    assert(collectWikiLinkTitles(body).length >= 2, `${slug}: 위키링크 문법 누락`);
    assert(extractFootnotes(body).notes.length >= 1, `${slug}: 각주 문법 누락`);
  } else {
    // 첫 배치 원고는 헤더와 평문만 쓰기로 한 당시의 승인 규칙을 유지한다.
    assert(!/[*_`~\[\]<>|]/u.test(body), `${slug}: 헤더 외 마크다운 문법`);
    assert(!/^(?:\s*[-+]\s|\s*\d+[.)]\s|\s{4}|-{3,}$)/mu.test(body));
  }

  const batch = createdAt.slice(0, 10).replaceAll("-", "");
  const id = `doc-ai-champion-${slug}-${batch}`;
  const editId = `edit-ai-champion-${slug}-${batch}`;
  const editSummary = richMarkup
    ? "AI 작성: 실전 라인전 초안"
    : "AI 작성: 챔피언 소개·스킬·실전 운용 초안";
  lines.push(
    `-- ${champion.name} (${body.length}자)`,
    "INSERT INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)",
    `SELECT ${quote(id)}, 'article', ${quote(champion.name)}, ${quote(titleKey(champion.name))}, 'published', NULL, ${quote(body)}, 1, ${quote(catalog.patch)}, 'guarded', ${quote(createdAt)}, ${quote(createdAt)}, ${quote(SYSTEM_USER_ID)}`,
    `WHERE NOT EXISTS (SELECT 1 FROM wiki_docs WHERE id = ${quote(id)} OR (kind = 'article' AND title_key = ${quote(titleKey(champion.name))}));`,
    "INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)",
    `SELECT ${quote(editId)}, id, NULL, 0, general, ${quote(editSummary)}, 'accepted', ${quote(SYSTEM_USER_ID)}, ${quote(createdAt)}, 'admin', 1 FROM wiki_docs`,
    `WHERE id = ${quote(id)} AND revision = 1 AND general = ${quote(body)}`,
    `AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = ${quote(editId)});`,
  );
  for (const title of unresolvedWikiTitles([body])) {
    lines.push(
      "INSERT OR IGNORE INTO wiki_links (source_doc, source_key, target_key, target_title)",
      `SELECT ${quote(id)}, NULL, ${quote(titleKey(title))}, ${quote(title)} FROM wiki_docs WHERE id = ${quote(id)};`,
    );
  }
  lines.push("");
  console.log(`${champion.name}: ${body.length}자, 원고·링크 검증 통과`);
}

writeFileSync("seeds/champion-wiki.sql", lines.join("\n") + "\n");
console.log(`생성: seeds/champion-wiki.sql (문서 ${drafts.length}개 + 최초 편집 이력 ${drafts.length}개)`);
