/**
 * 인벤에서 실전 상대법 근거를 확인한 미드 챔피언의 공통 상대법 시드.
 * 기존 본문이나 편집 이력이 있는 문서는 건드리지 않는다.
 * 실행: npx tsx scripts/seed-mid-matchup-wiki.ts
 * 적용: npx wrangler d1 execute kkaenam-gg --local --file seeds/mid-matchup-wiki.sql
 */
import assert from "node:assert/strict";
import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import catalog from "../src/data/generated/champions.json";
import { classifications } from "../src/data/taxonomy";
import { MAX_BODY_LENGTH, SYSTEM_USER_ID } from "../src/data/wiki";
import { buildOutline, extractFootnotes } from "../src/lib/wikiMarkup";

const AI_DRAFT_HEADING = "AI 작성 초안";
const CREATED_AT = "2026-09-12T12:30:00.000Z";
const slugs = [
  "qiyana",
  "galio",
  "ekko",
  "diana",
  "irelia",
  "sion",
  "corki",
  "jayce",
  "tristana",
  "malzahar",
  "viktor",
  "syndra",
  "xerath",
  "twistedfate",
  "lux",
  "orianna",
  "anivia",
  "zoe",
  "veigar",
  "vex",
  "cassiopeia",
  "taliyah",
  "annie",
  "aurelionsol",
  "lissandra",
  "azir",
] as const;

const quote = (value: string) => `'${value.replace(/'/g, "''")}'`;
const lines = [
  "-- scripts/seed-mid-matchup-wiki.ts가 생성. 원고는 seeds/mid-matchup-wiki/*.md.",
  "-- 기존 상대법과 편집 이력을 보존하고 revision 0의 빈 문서만 채운다.",
  "INSERT OR IGNORE INTO users (id, provider, provider_id, name, email, role, created_at)",
  `VALUES (${quote(SYSTEM_USER_ID)}, 'system', 'seed', '깨남.COM', NULL, 'admin', ${quote(CREATED_AT)});`,
  "",
];

for (const slug of slugs) {
  const champion = catalog.champions.find((entry) => entry.slug === slug);
  assert(champion, `카탈로그에 없는 챔피언: ${slug}`);
  assert(
    classifications.some(
      (entry) => entry.positionSlug === "mid" && entry.championName === champion.name,
    ),
    `미드 초기 분류에 없는 챔피언: ${champion.name}`,
  );

  const body = readFileSync(join("seeds/mid-matchup-wiki", `${slug}.md`), "utf8")
    .replace(/\r\n?/g, "\n")
    .trim();
  assert(body.startsWith(`# ${AI_DRAFT_HEADING}\n\n`));
  assert(body.length <= MAX_BODY_LENGTH);
  assert(!/(?:^|\s)(?:룬|아이템|소환사 주문)(?:\s|$)/mu.test(body), `${slug}: 제외 주제 포함`);
  assert(body.includes("**"), `${slug}: 강조 문법 누락`);
  assert(/^- /mu.test(body), `${slug}: 목록 문법 누락`);
  assert(extractFootnotes(body).notes.length >= 1, `${slug}: 출처 각주 누락`);
  const outline = buildOutline(body, "matchup-body", 2, new Set());
  assert.equal(outline.children.length, 1);
  assert.equal(outline.children[0].title, AI_DRAFT_HEADING);
  assert(outline.children[0].children.length >= 2);

  const docId = `doc-c-${slug}`;
  const editId = `edit-ai-mid-matchup-${slug}-20260912`;
  lines.push(
    `-- ${champion.name} (${body.length}자)`,
    "INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)",
    `VALUES (${quote(docId)}, 'matchup', NULL, NULL, 'published', ${quote(slug)}, '', 0, ${quote(catalog.patch)}, 'guarded', ${quote(CREATED_AT)}, ${quote(CREATED_AT)}, ${quote(SYSTEM_USER_ID)});`,
    "UPDATE wiki_docs",
    `SET general = ${quote(body)}, revision = 1, patch = ${quote(catalog.patch)}, updated_at = ${quote(CREATED_AT)}, updated_by = ${quote(SYSTEM_USER_ID)}`,
    `WHERE kind = 'matchup' AND champion_slug = ${quote(slug)} AND revision = 0 AND TRIM(general) = ''`,
    `AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = ${quote(editId)});`,
    "INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)",
    `SELECT ${quote(editId)}, id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', ${quote(SYSTEM_USER_ID)}, ${quote(CREATED_AT)}, 'admin', 1 FROM wiki_docs`,
    `WHERE kind = 'matchup' AND champion_slug = ${quote(slug)} AND revision = 1 AND general = ${quote(body)}`,
    `AND updated_at = ${quote(CREATED_AT)} AND updated_by = ${quote(SYSTEM_USER_ID)}`,
    `AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = ${quote(editId)});`,
    "",
  );
  console.log(`${champion.name}: ${body.length}자, 마크다운·출처 검증 통과`);
}

writeFileSync("seeds/mid-matchup-wiki.sql", `${lines.join("\n").trimEnd()}\n`);
console.log(`생성: seeds/mid-matchup-wiki.sql (빈 상대법 최대 ${slugs.length}개)`);
