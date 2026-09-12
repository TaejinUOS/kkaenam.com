-- scripts/seed-mid-matchup-wiki.ts가 생성. 원고는 seeds/mid-matchup-wiki/*.md.
-- 기존 상대법과 편집 이력을 보존하고 revision 0의 빈 문서만 채운다.
INSERT OR IGNORE INTO users (id, provider, provider_id, name, email, role, created_at)
VALUES ('user-system', 'system', 'seed', '깨남.COM', NULL, 'admin', '2026-09-12T12:30:00.000Z');

-- 키아나 (698자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-qiyana', 'matchup', NULL, NULL, 'published', 'qiyana', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 1레벨에 밀어 두고, 벽에서 싸우지 않는다

키아나는 원소가 갖춰지기 전 첫 레벨이 약하다. 이때 미니언을 먼저 치되, 2레벨이 되는 순간에는 강가·수풀·벽 쪽으로 물러나지 않는다. **벽 가까이 선 채 체력을 절반 이하로 내주는 것이 가장 위험한 구도**다.[* 인벤 키아나 공략은 1레벨이 매우 약하며, 미니언을 탄 `E-Q-W-Q` 진입과 강·수풀·벽에서 강해지는 궁극기 각을 핵심으로 설명한다. [M1 키아나 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=144987), [키아나 A to Z](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=147203)]

- 키아나가 원소를 줍는 방향을 보고 다음 Q 효과를 예상한다.
- 아군 미니언이 낮은 체력일 때 그 미니언 뒤에 서지 않는다. `대담무쌍(E)`의 발판이 된다.
- 6레벨 이후에는 벽과 평행하게 도망치지 말고 중앙 쪽으로 빠진다.

## 짧은 교환 뒤 바로 간격을 다시 벌린다

수풀 원소 Q 뒤에는 은신 영역이 남는다. 그 안에서 다음 위치를 맞히려 하지 말고 영역 밖으로 빠져 재등장을 기다린다. 키아나가 `W`로 원소를 바꾸면 다시 Q를 쓸 수 있으므로, 첫 Q만 빠졌다고 긴 교환을 열지 않는다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'qiyana' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-qiyana-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-qiyana-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'qiyana' AND revision = 1 AND general = '# AI 작성 초안

## 1레벨에 밀어 두고, 벽에서 싸우지 않는다

키아나는 원소가 갖춰지기 전 첫 레벨이 약하다. 이때 미니언을 먼저 치되, 2레벨이 되는 순간에는 강가·수풀·벽 쪽으로 물러나지 않는다. **벽 가까이 선 채 체력을 절반 이하로 내주는 것이 가장 위험한 구도**다.[* 인벤 키아나 공략은 1레벨이 매우 약하며, 미니언을 탄 `E-Q-W-Q` 진입과 강·수풀·벽에서 강해지는 궁극기 각을 핵심으로 설명한다. [M1 키아나 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=144987), [키아나 A to Z](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=147203)]

- 키아나가 원소를 줍는 방향을 보고 다음 Q 효과를 예상한다.
- 아군 미니언이 낮은 체력일 때 그 미니언 뒤에 서지 않는다. `대담무쌍(E)`의 발판이 된다.
- 6레벨 이후에는 벽과 평행하게 도망치지 말고 중앙 쪽으로 빠진다.

## 짧은 교환 뒤 바로 간격을 다시 벌린다

수풀 원소 Q 뒤에는 은신 영역이 남는다. 그 안에서 다음 위치를 맞히려 하지 말고 영역 밖으로 빠져 재등장을 기다린다. 키아나가 `W`로 원소를 바꾸면 다시 Q를 쓸 수 있으므로, 첫 Q만 빠졌다고 긴 교환을 열지 않는다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-qiyana-20260912');

-- 갈리오 (712자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-galio', 'matchup', NULL, NULL, 'published', 'galio', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 미니언과 한 줄로 서지 않는다

갈리오는 `전장의 돌풍(Q)`으로 미니언과 챔피언을 함께 맞힐 때 가장 편하다. 원거리 미니언 옆이 아니라 **웨이브와 사선으로 떨어져 서면** 갈리오가 라인 정리와 견제 중 하나를 포기해야 한다.[* 인벤의 갈리오 상대 설명은 Q와 돌진을 피하면서 보호막이 빠진 구간을 노리고, 미드 갈리오가 로밍을 위해 무리하게 움직일 때 정글 동선을 확인하라고 조언한다. [애니의 갈리오 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=135420), [신드라 공략의 갈리오 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=132083)]

- `정의의 주먹(E)`은 시작할 때 갈리오가 잠깐 뒤로 물러난다. 이 동작이 보이면 옆으로 비킨다.
- `듀란드의 방패(W)`를 모으는 동안에는 범위 밖으로 걷고, 끝난 뒤에 짧게 때린다.
- 갈리오가 시야에서 사라지면 웨이브만 보지 말고 양쪽 강가 움직임을 먼저 알린다.

## 보호막과 도발을 한 번에 빼려 하지 않는다

마법 보호막이 있는 갈리오에게 큰 기술부터 쓰지 않는다. 작은 피해로 보호막을 지운 뒤 다음 기술을 준비한다. 도발을 빼려고 근접했다가 E까지 연달아 맞지 않도록, W가 끝날 때까지 거리를 유지한다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'galio' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-galio-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-galio-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'galio' AND revision = 1 AND general = '# AI 작성 초안

## 미니언과 한 줄로 서지 않는다

갈리오는 `전장의 돌풍(Q)`으로 미니언과 챔피언을 함께 맞힐 때 가장 편하다. 원거리 미니언 옆이 아니라 **웨이브와 사선으로 떨어져 서면** 갈리오가 라인 정리와 견제 중 하나를 포기해야 한다.[* 인벤의 갈리오 상대 설명은 Q와 돌진을 피하면서 보호막이 빠진 구간을 노리고, 미드 갈리오가 로밍을 위해 무리하게 움직일 때 정글 동선을 확인하라고 조언한다. [애니의 갈리오 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=135420), [신드라 공략의 갈리오 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=132083)]

- `정의의 주먹(E)`은 시작할 때 갈리오가 잠깐 뒤로 물러난다. 이 동작이 보이면 옆으로 비킨다.
- `듀란드의 방패(W)`를 모으는 동안에는 범위 밖으로 걷고, 끝난 뒤에 짧게 때린다.
- 갈리오가 시야에서 사라지면 웨이브만 보지 말고 양쪽 강가 움직임을 먼저 알린다.

## 보호막과 도발을 한 번에 빼려 하지 않는다

마법 보호막이 있는 갈리오에게 큰 기술부터 쓰지 않는다. 작은 피해로 보호막을 지운 뒤 다음 기술을 준비한다. 도발을 빼려고 근접했다가 E까지 연달아 맞지 않도록, W가 끝날 때까지 거리를 유지한다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-galio-20260912');

-- 에코 (677자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-ekko', 'matchup', NULL, NULL, 'published', 'ekko', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 돌아오는 Q와 세 번째 타격을 끊는다

`시간의 톱니바퀴(Q)`는 나갈 때보다 돌아올 때까지 맞으면 교환이 커진다. 첫 타를 맞았더라도 에코와 일직선으로 뒤로 빠지지 말고 옆으로 움직인다. **두 번 맞고 세 번째 타격까지 허용하는 구도를 끊는 것**이 핵심이다.[* 인벤 에코 공략과 상대법은 Q 왕복, 3타 뒤 이동 속도, W 범위와 궁극기 잔상을 계속 확인해야 한다고 설명한다. [미드 에코 상대법 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=141126), [구체적 에코 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=134573)]

- 에코가 `시간 도약(E)` 첫 동작을 쓰면 순간이동할 대상과 거리를 벌린다.
- 보이지 않는 곳에서 나타난 큰 원은 `평행 시간 교차(W)`다. 안에서 싸우지 않는다.
- 6레벨 이후에는 에코 뒤의 잔상 위에 서지 않는다.

## 진입이 끝난 자리를 때린다

에코가 E와 3타를 모두 쓰고 이동 속도로 빠질 때 무리하게 따라가지 않는다. 다음 웨이브를 먼저 잡거나, 돌아오는 Q가 빗나간 직후에만 짧게 되받아친다. 궁극기가 준비된 에코의 잔상 근처에서는 마무리 욕심을 줄인다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'ekko' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-ekko-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-ekko-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'ekko' AND revision = 1 AND general = '# AI 작성 초안

## 돌아오는 Q와 세 번째 타격을 끊는다

`시간의 톱니바퀴(Q)`는 나갈 때보다 돌아올 때까지 맞으면 교환이 커진다. 첫 타를 맞았더라도 에코와 일직선으로 뒤로 빠지지 말고 옆으로 움직인다. **두 번 맞고 세 번째 타격까지 허용하는 구도를 끊는 것**이 핵심이다.[* 인벤 에코 공략과 상대법은 Q 왕복, 3타 뒤 이동 속도, W 범위와 궁극기 잔상을 계속 확인해야 한다고 설명한다. [미드 에코 상대법 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=141126), [구체적 에코 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=134573)]

- 에코가 `시간 도약(E)` 첫 동작을 쓰면 순간이동할 대상과 거리를 벌린다.
- 보이지 않는 곳에서 나타난 큰 원은 `평행 시간 교차(W)`다. 안에서 싸우지 않는다.
- 6레벨 이후에는 에코 뒤의 잔상 위에 서지 않는다.

## 진입이 끝난 자리를 때린다

에코가 E와 3타를 모두 쓰고 이동 속도로 빠질 때 무리하게 따라가지 않는다. 다음 웨이브를 먼저 잡거나, 돌아오는 Q가 빗나간 직후에만 짧게 되받아친다. 궁극기가 준비된 에코의 잔상 근처에서는 마무리 욕심을 줄인다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-ekko-20260912');

-- 다이애나 (693자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-diana', 'matchup', NULL, NULL, 'published', 'diana', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## Q가 빗나간 순간이 가장 분명한 창이다

다이애나는 `초승달 검기(Q)`가 묻은 대상에게 `월광 쇄도(E)`를 쓰면 E를 다시 쓸 수 있다. Q를 옆으로 피하면 진입 거리와 추격 횟수가 동시에 줄어든다. **Q가 없는 다이애나에게는 먼저 한 번 때리고 빠져도 된다.**[* 인벤 다이애나 공략은 Q 적중 뒤 E를 다시 사용할 수 있다는 점과, 6레벨 전 원거리 상대로 버티는 구도를 반복해서 강조한다. [미드 다이애나 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=146055), [다이애나 장문 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=138638)]

- Q는 휘어 들어오므로 다이애나 반대쪽보다 안쪽으로 짧게 비키는 선택도 섞는다.
- `은빛 가호(W)` 구체 세 개가 모두 터진 동안에는 긴 교환을 피한다.
- 표식이 묻었다면 아군 미니언에서 떨어져 두 번째 E의 발판을 줄인다.

## 6레벨 이후에는 미니언 한가운데 서지 않는다

`달빛 낙하(R)`는 여러 대상을 끌수록 강해진다. 아군과 미니언이 몰린 자리에서 맞서기보다 옆으로 빠져 한 명만 끌게 만든다. 다이애나가 첫 E로 들어온 뒤 퇴로용 대상이 없도록 뒤쪽 미니언과 간격을 둔다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'diana' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-diana-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-diana-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'diana' AND revision = 1 AND general = '# AI 작성 초안

## Q가 빗나간 순간이 가장 분명한 창이다

다이애나는 `초승달 검기(Q)`가 묻은 대상에게 `월광 쇄도(E)`를 쓰면 E를 다시 쓸 수 있다. Q를 옆으로 피하면 진입 거리와 추격 횟수가 동시에 줄어든다. **Q가 없는 다이애나에게는 먼저 한 번 때리고 빠져도 된다.**[* 인벤 다이애나 공략은 Q 적중 뒤 E를 다시 사용할 수 있다는 점과, 6레벨 전 원거리 상대로 버티는 구도를 반복해서 강조한다. [미드 다이애나 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=146055), [다이애나 장문 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=138638)]

- Q는 휘어 들어오므로 다이애나 반대쪽보다 안쪽으로 짧게 비키는 선택도 섞는다.
- `은빛 가호(W)` 구체 세 개가 모두 터진 동안에는 긴 교환을 피한다.
- 표식이 묻었다면 아군 미니언에서 떨어져 두 번째 E의 발판을 줄인다.

## 6레벨 이후에는 미니언 한가운데 서지 않는다

`달빛 낙하(R)`는 여러 대상을 끌수록 강해진다. 아군과 미니언이 몰린 자리에서 맞서기보다 옆으로 빠져 한 명만 끌게 만든다. 다이애나가 첫 E로 들어온 뒤 퇴로용 대상이 없도록 뒤쪽 미니언과 간격을 둔다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-diana-20260912');

-- 이렐리아 (646자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-irelia', 'matchup', NULL, NULL, 'published', 'irelia', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 낮은 체력 미니언은 이렐리아의 이동 경로다

막타 직전 미니언 옆에 서면 `칼날 쇄도(Q)` 초기화로 거리를 단숨에 좁힌다. 웨이브를 볼 때는 내 막타뿐 아니라 **이렐리아가 Q로 처치할 수 있는 미니언의 연속 경로**를 먼저 본다.[* 인벤 이렐리아 공략들은 Q 처치·표식 초기화와 중첩을 만든 뒤 교환하는 구조를 핵심으로 다룬다. [이렐리아 라인 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=145057), [이렐리아 기본 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=37546)]

- 낮은 체력 미니언과 일직선으로 서지 않는다.
- `쌍검협무(E)` 첫 칼날이 보이면 두 칼날을 잇는 선의 옆으로 움직인다.
- 이렐리아가 중첩을 모두 쌓은 상태에서는 막타 하나를 포기하고 거리를 둔다.

## 표식이 사라진 뒤 짧게 친다

E나 `선봉진격검(R)` 표식이 남아 있으면 Q가 다시 준비된다. 첫 돌진만 보고 제자리에 맞서지 말고 표식 지속시간을 흘린다. `저항의 춤(W)`을 모으는 동안에는 큰 물리 피해를 억지로 넣지 말고, 끝나는 방향을 피한 뒤 되받아친다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'irelia' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-irelia-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-irelia-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'irelia' AND revision = 1 AND general = '# AI 작성 초안

## 낮은 체력 미니언은 이렐리아의 이동 경로다

막타 직전 미니언 옆에 서면 `칼날 쇄도(Q)` 초기화로 거리를 단숨에 좁힌다. 웨이브를 볼 때는 내 막타뿐 아니라 **이렐리아가 Q로 처치할 수 있는 미니언의 연속 경로**를 먼저 본다.[* 인벤 이렐리아 공략들은 Q 처치·표식 초기화와 중첩을 만든 뒤 교환하는 구조를 핵심으로 다룬다. [이렐리아 라인 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=145057), [이렐리아 기본 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=37546)]

- 낮은 체력 미니언과 일직선으로 서지 않는다.
- `쌍검협무(E)` 첫 칼날이 보이면 두 칼날을 잇는 선의 옆으로 움직인다.
- 이렐리아가 중첩을 모두 쌓은 상태에서는 막타 하나를 포기하고 거리를 둔다.

## 표식이 사라진 뒤 짧게 친다

E나 `선봉진격검(R)` 표식이 남아 있으면 Q가 다시 준비된다. 첫 돌진만 보고 제자리에 맞서지 말고 표식 지속시간을 흘린다. `저항의 춤(W)`을 모으는 동안에는 큰 물리 피해를 억지로 넣지 말고, 끝나는 방향을 피한 뒤 되받아친다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-irelia-20260912');

-- 사이온 (689자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-sion', 'matchup', NULL, NULL, 'published', 'sion', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## Q는 뒤가 아니라 옆으로 피한다

`대량 학살 강타(Q)` 충전이 보이면 최대 사거리 밖으로 뒤늦게 달리기보다 옆으로 벗어난다. 수풀과 시야 밖에서는 충전 시작이 보이지 않으므로 가까운 쪽 벽을 따라 걷지 않는다. **보이지 않는 사이온 앞의 좁은 길은 비워 둔다.**[* 인벤 상대법은 수풀의 Q와 처치 뒤 패시브를 특히 조심하라고 설명하며, 사이온 공략은 E로 미니언을 밀어 원거리에서 교환을 여는 구조를 보여 준다. [사이온 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=138313), [사이온 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=143260)]

- 낮은 체력 미니언 뒤에 서지 않는다. `학살자의 포효(E)`에 밀려난 미니언이 닿는다.
- `영혼의 용광로(W)` 보호막이 켜지면 폭발 범위 밖으로 나간다.
- 궁극기 소리가 들리면 직선으로 달아나기보다 충돌 경로에서 먼저 벗어난다.

## 쓰러뜨린 뒤에도 바로 붙지 않는다

사이온이 죽으면 잠시 다시 움직이며 빠르게 공격한다. 처치 직후 체력이 낮다면 시체 옆에서 다음 행동을 고민하지 말고 즉시 간격을 벌린다. 웨이브를 먹으려고 돌아가는 것도 패시브가 끝난 뒤로 미룬다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'sion' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-sion-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-sion-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'sion' AND revision = 1 AND general = '# AI 작성 초안

## Q는 뒤가 아니라 옆으로 피한다

`대량 학살 강타(Q)` 충전이 보이면 최대 사거리 밖으로 뒤늦게 달리기보다 옆으로 벗어난다. 수풀과 시야 밖에서는 충전 시작이 보이지 않으므로 가까운 쪽 벽을 따라 걷지 않는다. **보이지 않는 사이온 앞의 좁은 길은 비워 둔다.**[* 인벤 상대법은 수풀의 Q와 처치 뒤 패시브를 특히 조심하라고 설명하며, 사이온 공략은 E로 미니언을 밀어 원거리에서 교환을 여는 구조를 보여 준다. [사이온 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=138313), [사이온 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=143260)]

- 낮은 체력 미니언 뒤에 서지 않는다. `학살자의 포효(E)`에 밀려난 미니언이 닿는다.
- `영혼의 용광로(W)` 보호막이 켜지면 폭발 범위 밖으로 나간다.
- 궁극기 소리가 들리면 직선으로 달아나기보다 충돌 경로에서 먼저 벗어난다.

## 쓰러뜨린 뒤에도 바로 붙지 않는다

사이온이 죽으면 잠시 다시 움직이며 빠르게 공격한다. 처치 직후 체력이 낮다면 시체 옆에서 다음 행동을 고민하지 말고 즉시 간격을 벌린다. 웨이브를 먹으려고 돌아가는 것도 패시브가 끝난 뒤로 미룬다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-sion-20260912');

-- 코르키 (634자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-corki', 'matchup', NULL, NULL, 'published', 'corki', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 미니언 뒤는 미사일 방패지만 Q의 안전지대는 아니다

`미사일 폭격(R)`은 첫 대상에서 폭발하므로 미니언을 사이에 두면 직접 적중을 줄일 수 있다. 반면 `인광탄(Q)`은 범위 기술이라 미니언과 함께 맞으면 손해다. **미사일에는 미니언을 끼고, Q에는 웨이브와 사선으로 선다.**[* 인벤 코르키 공략은 Q·E로 웨이브와 챔피언을 함께 치는 구도, 큰 미사일을 포함한 원거리 견제, W를 물리기 전 위치 조정에 쓰는 방식을 설명한다. [코르키 상세 대응 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=113454)]

- 세 번째 큰 미사일이 장전됐을 때는 낮은 미니언 뒤에 오래 서지 않는다.
- `개틀링 건(E)`이 켜진 코르키 정면에서 뒤로만 빼지 말고 원뿔 옆으로 나간다.
- `발키리(W)`를 앞으로 쓴 뒤에는 퇴로가 줄어드니 그때 짧게 되받아친다.

## 한 발을 피한 뒤 웨이브를 건드린다

코르키가 Q와 큰 미사일을 모두 들고 있으면 막타를 칠 때 견제를 겹치기 쉽다. 먼저 한 발을 움직임으로 빼고 미니언에 접근한다. 모든 미사일을 피하려 멀어지기보다 큰 탄만 확실히 피하고 작은 탄 사이에 라인을 정리한다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'corki' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-corki-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-corki-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'corki' AND revision = 1 AND general = '# AI 작성 초안

## 미니언 뒤는 미사일 방패지만 Q의 안전지대는 아니다

`미사일 폭격(R)`은 첫 대상에서 폭발하므로 미니언을 사이에 두면 직접 적중을 줄일 수 있다. 반면 `인광탄(Q)`은 범위 기술이라 미니언과 함께 맞으면 손해다. **미사일에는 미니언을 끼고, Q에는 웨이브와 사선으로 선다.**[* 인벤 코르키 공략은 Q·E로 웨이브와 챔피언을 함께 치는 구도, 큰 미사일을 포함한 원거리 견제, W를 물리기 전 위치 조정에 쓰는 방식을 설명한다. [코르키 상세 대응 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=113454)]

- 세 번째 큰 미사일이 장전됐을 때는 낮은 미니언 뒤에 오래 서지 않는다.
- `개틀링 건(E)`이 켜진 코르키 정면에서 뒤로만 빼지 말고 원뿔 옆으로 나간다.
- `발키리(W)`를 앞으로 쓴 뒤에는 퇴로가 줄어드니 그때 짧게 되받아친다.

## 한 발을 피한 뒤 웨이브를 건드린다

코르키가 Q와 큰 미사일을 모두 들고 있으면 막타를 칠 때 견제를 겹치기 쉽다. 먼저 한 발을 움직임으로 빼고 미니언에 접근한다. 모든 미사일을 피하려 멀어지기보다 큰 탄만 확실히 피하고 작은 탄 사이에 라인을 정리한다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-corki-20260912');

-- 제이스 (681자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-jayce', 'matchup', NULL, NULL, 'published', 'jayce', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 관문보다 투사체를 먼저 본다

제이스는 `전격 폭발(Q)`을 먼저 쏜 뒤 투사체 앞에 `가속 관문(E)`을 열어 반응 시간을 줄일 수 있다. 관문이 없다고 방심하지 말고 Q의 시작 동작부터 본다. **원거리 미니언을 사이에 두면 강화 Q 폭발을 대신 받아낼 수 있다.**[* 인벤 제이스 공략은 상대가 막타를 칠 때 평타와 포킹을 넣고, Q-E를 빠르게 연결하며, 해머 진입 뒤 밀어내기로 교환을 끝내는 방식을 설명한다. [제이스 입문서](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=125682), [미드 제이스 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=148113)]

- 미니언에서 너무 붙어 서서 폭발 피해를 함께 받지는 않는다.
- 캐논 Q와 관문이 빠졌다면 원거리 견제 압력이 크게 줄어든다.
- 해머로 바꾼 제이스를 추격할 때는 `천둥 강타(E)`로 밀릴 방향을 먼저 본다.

## 폼 전환 한 번에 긴 싸움을 허용하지 않는다

제이스는 두 형태의 기술을 연달아 쓸 수 있다. 캐논 기술 하나가 빠졌다고 바로 근접하면 해머 Q-E가 남아 있다. 두 형태를 모두 확인한 뒤 짧게 압박하고, 미니언 깊숙이 따라가지는 않는다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'jayce' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-jayce-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-jayce-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'jayce' AND revision = 1 AND general = '# AI 작성 초안

## 관문보다 투사체를 먼저 본다

제이스는 `전격 폭발(Q)`을 먼저 쏜 뒤 투사체 앞에 `가속 관문(E)`을 열어 반응 시간을 줄일 수 있다. 관문이 없다고 방심하지 말고 Q의 시작 동작부터 본다. **원거리 미니언을 사이에 두면 강화 Q 폭발을 대신 받아낼 수 있다.**[* 인벤 제이스 공략은 상대가 막타를 칠 때 평타와 포킹을 넣고, Q-E를 빠르게 연결하며, 해머 진입 뒤 밀어내기로 교환을 끝내는 방식을 설명한다. [제이스 입문서](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=125682), [미드 제이스 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=148113)]

- 미니언에서 너무 붙어 서서 폭발 피해를 함께 받지는 않는다.
- 캐논 Q와 관문이 빠졌다면 원거리 견제 압력이 크게 줄어든다.
- 해머로 바꾼 제이스를 추격할 때는 `천둥 강타(E)`로 밀릴 방향을 먼저 본다.

## 폼 전환 한 번에 긴 싸움을 허용하지 않는다

제이스는 두 형태의 기술을 연달아 쓸 수 있다. 캐논 기술 하나가 빠졌다고 바로 근접하면 해머 Q-E가 남아 있다. 두 형태를 모두 확인한 뒤 짧게 압박하고, 미니언 깊숙이 따라가지는 않는다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-jayce-20260912');

-- 트리스타나 (660자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-tristana', 'matchup', NULL, NULL, 'published', 'tristana', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 폭발 화약 네 번째 타격을 주지 않는다

`폭발 화약(E)`가 붙으면 트리스타나는 기본 공격과 기술로 중첩을 올린다. 두세 번 맞은 뒤 뒤늦게 맞서지 말고 즉시 사거리 밖으로 빠진다. **최대 중첩 폭발은 `로켓 점프(W)`까지 다시 준비시킬 수 있다.**[* 인벤 트리스타나 상대법과 공략은 E 중첩, W 착지 위치, 최대 중첩 폭발 뒤 W 초기화를 핵심으로 설명한다. [트리스타나 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=109535), [트리스타나 스킬 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=146264)]

- E가 붙지 않은 평타 한두 대와 E가 붙은 교환을 같은 피해로 생각하지 않는다.
- 트리스타나가 W로 앞으로 들어오면 착지 지점에서 먼저 벗어난다.
- 낮은 체력 미니언 옆에서는 미니언 폭발 피해까지 함께 받는다.

## 점프를 뺀 뒤에만 추격한다

W는 시전 도중 방해를 받아도 이동이 이어지는 경우가 있다. 착지 지점에 제어 기술을 두는 편이 안정적이다. 공격적으로 W를 쓴 뒤 E를 충분히 터뜨리지 못했다면 퇴로가 줄어든 시점이므로, 그때만 짧게 추격한다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'tristana' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-tristana-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-tristana-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'tristana' AND revision = 1 AND general = '# AI 작성 초안

## 폭발 화약 네 번째 타격을 주지 않는다

`폭발 화약(E)`가 붙으면 트리스타나는 기본 공격과 기술로 중첩을 올린다. 두세 번 맞은 뒤 뒤늦게 맞서지 말고 즉시 사거리 밖으로 빠진다. **최대 중첩 폭발은 `로켓 점프(W)`까지 다시 준비시킬 수 있다.**[* 인벤 트리스타나 상대법과 공략은 E 중첩, W 착지 위치, 최대 중첩 폭발 뒤 W 초기화를 핵심으로 설명한다. [트리스타나 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=109535), [트리스타나 스킬 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=146264)]

- E가 붙지 않은 평타 한두 대와 E가 붙은 교환을 같은 피해로 생각하지 않는다.
- 트리스타나가 W로 앞으로 들어오면 착지 지점에서 먼저 벗어난다.
- 낮은 체력 미니언 옆에서는 미니언 폭발 피해까지 함께 받는다.

## 점프를 뺀 뒤에만 추격한다

W는 시전 도중 방해를 받아도 이동이 이어지는 경우가 있다. 착지 지점에 제어 기술을 두는 편이 안정적이다. 공격적으로 W를 쓴 뒤 E를 충분히 터뜨리지 못했다면 퇴로가 줄어든 시점이므로, 그때만 짧게 추격한다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-tristana-20260912');

-- 말자하 (633자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-malzahar', 'matchup', NULL, NULL, 'published', 'malzahar', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 보호막을 작은 피해로 먼저 벗긴다

말자하의 기본 보호막이 남아 있으면 첫 제어 기술이 허무하게 사라질 수 있다. 큰 기술부터 쓰지 말고 기본 공격이나 작은 범위 피해로 지운 뒤 다음 행동을 준비한다. **보호막을 벗긴 직후가 정글 개입과 교환을 걸기 가장 분명한 순간**이다.[* 인벤 트위스티드 페이트 공략의 말자하 상대법은 보호막을 먼저 제거하고, 초반 푸시가 완성되기 전에 웨이브를 다루며, 라인을 길게 만들어 개입 각을 잡으라고 설명한다. [말자하 라인전 대처](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848)]

- `재앙의 환상(E)`이 묻은 미니언이 죽기 직전이면 그 미니언에서 떨어진다.
- 공허충은 환상이 묻은 대상을 향하므로 먼저 정리해 압박을 줄인다.
- `공허의 부름(Q)` 두 문 사이에 오래 서지 않는다.

## 6레벨 뒤에는 먼저 시야 밖으로 걷지 않는다

`황천의 손아귀(R)`는 확정 제압이라 말자하 쪽 정글러가 보이지 않을 때 위험하다. 보호막과 궁극기가 모두 준비된 말자하 앞에서 체력 우위만 믿고 길게 전진하지 않는다. 궁극기가 빠진 뒤에는 이동기가 없는 점을 이용해 간격을 좁힌다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'malzahar' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-malzahar-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-malzahar-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'malzahar' AND revision = 1 AND general = '# AI 작성 초안

## 보호막을 작은 피해로 먼저 벗긴다

말자하의 기본 보호막이 남아 있으면 첫 제어 기술이 허무하게 사라질 수 있다. 큰 기술부터 쓰지 말고 기본 공격이나 작은 범위 피해로 지운 뒤 다음 행동을 준비한다. **보호막을 벗긴 직후가 정글 개입과 교환을 걸기 가장 분명한 순간**이다.[* 인벤 트위스티드 페이트 공략의 말자하 상대법은 보호막을 먼저 제거하고, 초반 푸시가 완성되기 전에 웨이브를 다루며, 라인을 길게 만들어 개입 각을 잡으라고 설명한다. [말자하 라인전 대처](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848)]

- `재앙의 환상(E)`이 묻은 미니언이 죽기 직전이면 그 미니언에서 떨어진다.
- 공허충은 환상이 묻은 대상을 향하므로 먼저 정리해 압박을 줄인다.
- `공허의 부름(Q)` 두 문 사이에 오래 서지 않는다.

## 6레벨 뒤에는 먼저 시야 밖으로 걷지 않는다

`황천의 손아귀(R)`는 확정 제압이라 말자하 쪽 정글러가 보이지 않을 때 위험하다. 보호막과 궁극기가 모두 준비된 말자하 앞에서 체력 우위만 믿고 길게 전진하지 않는다. 궁극기가 빠진 뒤에는 이동기가 없는 점을 이용해 간격을 좁힌다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-malzahar-20260912');

-- 빅토르 (683자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-viktor', 'matchup', NULL, NULL, 'published', 'viktor', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 광선에 맞지 않으려 계속 작은 방향 전환을 한다

`마법공학 광선(E)`은 별도 준비 동작이 짧아 막타 순간을 노리기 쉽다. 같은 방향으로 오래 걷지 말고 미니언을 칠 때마다 짧게 옆으로 움직인다. **광선을 피한 직후에만 전진하면 빅토르의 일방적인 교환을 줄일 수 있다.**[* 인벤의 빅토르 상대법은 1레벨 Q와 강화 기본 공격을 피하고, 계속 움직여 죽음의 광선을 흘린 뒤 기술이 빠진 구간에 교환하라고 정리한다. [빅토르 라인전 대처](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848), [빅토르 상대 팁](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=121926)]

- `힘의 흡수(Q)` 직후에는 보호막과 강화 공격이 함께 남아 있으니 바로 맞서지 않는다.
- `중력장(W)` 안에서 직선으로 끝까지 달리지 말고 가장 가까운 가장자리로 나간다.
- 강화 E의 뒤따르는 폭발 위치에 다시 들어가지 않는다.

## 웨이브를 끼고 맞딜하지 않는다

빅토르가 아군 미니언 가까이 전진하면 미니언 피해를 받게 만들 수 있지만, Q 보호막이 켜진 상태라면 교환이 상쇄된다. 보호막이 끝난 뒤 짧게 때리고, 중력장 안으로 추격하지 않는다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'viktor' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-viktor-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-viktor-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'viktor' AND revision = 1 AND general = '# AI 작성 초안

## 광선에 맞지 않으려 계속 작은 방향 전환을 한다

`마법공학 광선(E)`은 별도 준비 동작이 짧아 막타 순간을 노리기 쉽다. 같은 방향으로 오래 걷지 말고 미니언을 칠 때마다 짧게 옆으로 움직인다. **광선을 피한 직후에만 전진하면 빅토르의 일방적인 교환을 줄일 수 있다.**[* 인벤의 빅토르 상대법은 1레벨 Q와 강화 기본 공격을 피하고, 계속 움직여 죽음의 광선을 흘린 뒤 기술이 빠진 구간에 교환하라고 정리한다. [빅토르 라인전 대처](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848), [빅토르 상대 팁](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=121926)]

- `힘의 흡수(Q)` 직후에는 보호막과 강화 공격이 함께 남아 있으니 바로 맞서지 않는다.
- `중력장(W)` 안에서 직선으로 끝까지 달리지 말고 가장 가까운 가장자리로 나간다.
- 강화 E의 뒤따르는 폭발 위치에 다시 들어가지 않는다.

## 웨이브를 끼고 맞딜하지 않는다

빅토르가 아군 미니언 가까이 전진하면 미니언 피해를 받게 만들 수 있지만, Q 보호막이 켜진 상태라면 교환이 상쇄된다. 보호막이 끝난 뒤 짧게 때리고, 중력장 안으로 추격하지 않는다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-viktor-20260912');

-- 신드라 (651자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-syndra', 'matchup', NULL, NULL, 'published', 'syndra', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 신드라보다 바닥의 구체를 본다

`적군 와해(E)`는 바닥의 `어둠 구체(Q)`를 밀어 긴 기절 선을 만든다. 신드라와 거리를 두는 것만으로는 부족하고, **신드라-구체-내 위치가 한 줄이 되지 않게** 움직여야 한다.[* 인벤 신드라 장문 공략은 Q-E 기절 각과 미니언·구체 위치를 중심으로 라인전을 설명하며, E가 빠졌을 때 진입을 허용하는 구조를 보여 준다. [신드라 장문 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=109849), [신드라 대응법 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=110336)]

- 새 구체가 생길 때마다 그 뒤 직선을 비운다.
- E가 빠지면 신드라의 밀어내기와 기절이 함께 사라지므로 짧게 전진한다.
- `의지의 힘(W)`으로 든 물체를 보고 착지 지점의 옆으로 피한다.

## 구체가 많이 남은 상태에서 마무리를 서두르지 않는다

궁극기는 주변에 준비된 구체가 많을수록 강해진다. 바닥에 구체가 여러 개 남아 있고 체력이 낮다면 한 번 더 맞교환하지 않는다. 궁극기 뒤에는 구체가 한곳에 쌓이므로 이어지는 E 직선을 즉시 피한다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'syndra' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-syndra-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-syndra-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'syndra' AND revision = 1 AND general = '# AI 작성 초안

## 신드라보다 바닥의 구체를 본다

`적군 와해(E)`는 바닥의 `어둠 구체(Q)`를 밀어 긴 기절 선을 만든다. 신드라와 거리를 두는 것만으로는 부족하고, **신드라-구체-내 위치가 한 줄이 되지 않게** 움직여야 한다.[* 인벤 신드라 장문 공략은 Q-E 기절 각과 미니언·구체 위치를 중심으로 라인전을 설명하며, E가 빠졌을 때 진입을 허용하는 구조를 보여 준다. [신드라 장문 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=109849), [신드라 대응법 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=110336)]

- 새 구체가 생길 때마다 그 뒤 직선을 비운다.
- E가 빠지면 신드라의 밀어내기와 기절이 함께 사라지므로 짧게 전진한다.
- `의지의 힘(W)`으로 든 물체를 보고 착지 지점의 옆으로 피한다.

## 구체가 많이 남은 상태에서 마무리를 서두르지 않는다

궁극기는 주변에 준비된 구체가 많을수록 강해진다. 바닥에 구체가 여러 개 남아 있고 체력이 낮다면 한 번 더 맞교환하지 않는다. 궁극기 뒤에는 구체가 한곳에 쌓이므로 이어지는 E 직선을 즉시 피한다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-syndra-20260912');

-- 제라스 (691자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-xerath', 'matchup', NULL, NULL, 'published', 'xerath', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## Q 충전에는 옆걸음, E에는 미니언을 쓴다

제라스가 `비전 파동(Q)`을 모으면 뒤로만 달리지 말고 좌우로 짧게 방향을 바꾼다. `충격 구체(E)`는 첫 유닛에 막히므로 접근할 때는 미니언을 사이에 둔다. **한 기술을 피하려다 다른 기술의 정답 자리를 버리지 않는다.**[* 인벤 제라스 상대법은 긴 사거리 대신 이동기가 없다는 점, Q 충전 중 움직임, 가까이 붙었을 때 E 하나로 거리를 벌려야 하는 구조를 반복해서 짚는다. [제라스 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137300), [제라스 장인 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=108801)]

- `파멸의 눈(W)` 중앙은 둔화와 피해가 더 크므로 원 가장자리로 즉시 나간다.
- Q와 E가 모두 빠진 뒤에만 간격을 좁힌다.
- 제라스가 기본 공격을 위해 미니언 가까이 올 때 짧게 압박한다.

## 궁극기를 쓰면 첫 발보다 내 이동 규칙을 바꾼다

`비전 의식(R)` 중 제라스는 움직이지 못한다. 매 발마다 같은 박자로 좌우를 반복하지 말고, 짧게 멈추거나 방향 전환 간격을 섞는다. 포탄만 보며 적 정글 쪽으로 도망치지 않도록 안전한 방향을 먼저 정한다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'xerath' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-xerath-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-xerath-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'xerath' AND revision = 1 AND general = '# AI 작성 초안

## Q 충전에는 옆걸음, E에는 미니언을 쓴다

제라스가 `비전 파동(Q)`을 모으면 뒤로만 달리지 말고 좌우로 짧게 방향을 바꾼다. `충격 구체(E)`는 첫 유닛에 막히므로 접근할 때는 미니언을 사이에 둔다. **한 기술을 피하려다 다른 기술의 정답 자리를 버리지 않는다.**[* 인벤 제라스 상대법은 긴 사거리 대신 이동기가 없다는 점, Q 충전 중 움직임, 가까이 붙었을 때 E 하나로 거리를 벌려야 하는 구조를 반복해서 짚는다. [제라스 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137300), [제라스 장인 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=108801)]

- `파멸의 눈(W)` 중앙은 둔화와 피해가 더 크므로 원 가장자리로 즉시 나간다.
- Q와 E가 모두 빠진 뒤에만 간격을 좁힌다.
- 제라스가 기본 공격을 위해 미니언 가까이 올 때 짧게 압박한다.

## 궁극기를 쓰면 첫 발보다 내 이동 규칙을 바꾼다

`비전 의식(R)` 중 제라스는 움직이지 못한다. 매 발마다 같은 박자로 좌우를 반복하지 말고, 짧게 멈추거나 방향 전환 간격을 섞는다. 포탄만 보며 적 정글 쪽으로 도망치지 않도록 안전한 방향을 먼저 정한다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-xerath-20260912');

-- 트위스티드 페이트 (711자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-twistedfate', 'matchup', NULL, NULL, 'published', 'twistedfate', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 카드 색을 보고 교환 여부를 정한다

트위스티드 페이트가 `카드 뽑기(W)`를 켜면 머리 위 카드가 순환한다. 금색 카드를 확정한 동안은 막타 하나를 포기하고 사거리 밖으로 빠진다. **카드를 미니언에 쓴 직후가 가장 안전한 교환 창**이다.[* 인벤 미드 상대법들은 카드 선택이 끝난 직후 진입하고, 트위스티드 페이트가 6레벨 이후 시야에서 사라질 때는 라인보다 궁극기 합류를 먼저 경고하라고 설명한다. [야스오의 트위스티드 페이트 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=108941), [트위스티드 페이트 장문 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848)]

- 금색 카드가 보이면 거리를 벌리고, 빨간 카드를 미니언에 던질 때는 폭발 범위에서 떨어진다.
- `속임수 덱(E)`의 강화 공격이 준비됐는지 카드 모양을 확인한다.
- `와일드 카드(Q)`는 세 갈래 사이 공간으로 피한다.

## 6레벨 뒤에는 사라진 방향을 바로 알린다

트위스티드 페이트가 웨이브를 밀고 시야에서 사라지면 뒤늦게 따라가지 않는다. 먼저 양쪽 라인에 신호를 보내고 다음 웨이브를 빠르게 밀어 손실을 만든다. 궁극기 시야가 켜졌다면 숨기보다 착지할 만한 아군 주변 공간을 비운다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'twistedfate' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-twistedfate-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-twistedfate-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'twistedfate' AND revision = 1 AND general = '# AI 작성 초안

## 카드 색을 보고 교환 여부를 정한다

트위스티드 페이트가 `카드 뽑기(W)`를 켜면 머리 위 카드가 순환한다. 금색 카드를 확정한 동안은 막타 하나를 포기하고 사거리 밖으로 빠진다. **카드를 미니언에 쓴 직후가 가장 안전한 교환 창**이다.[* 인벤 미드 상대법들은 카드 선택이 끝난 직후 진입하고, 트위스티드 페이트가 6레벨 이후 시야에서 사라질 때는 라인보다 궁극기 합류를 먼저 경고하라고 설명한다. [야스오의 트위스티드 페이트 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=108941), [트위스티드 페이트 장문 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848)]

- 금색 카드가 보이면 거리를 벌리고, 빨간 카드를 미니언에 던질 때는 폭발 범위에서 떨어진다.
- `속임수 덱(E)`의 강화 공격이 준비됐는지 카드 모양을 확인한다.
- `와일드 카드(Q)`는 세 갈래 사이 공간으로 피한다.

## 6레벨 뒤에는 사라진 방향을 바로 알린다

트위스티드 페이트가 웨이브를 밀고 시야에서 사라지면 뒤늦게 따라가지 않는다. 먼저 양쪽 라인에 신호를 보내고 다음 웨이브를 빠르게 밀어 손실을 만든다. 궁극기 시야가 켜졌다면 숨기보다 착지할 만한 아군 주변 공간을 비운다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-twistedfate-20260912');

-- 럭스 (698자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-lux', 'matchup', NULL, NULL, 'published', 'lux', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 미니언 하나만 믿고 Q를 맞지 않는다

`빛의 속박(Q)`은 첫 유닛을 맞힌 뒤 하나를 더 관통한다. 미니언 한 마리 뒤에만 서면 그대로 속박될 수 있으므로 두 마리 이상을 사이에 두거나 옆으로 선다. **Q가 빗나간 뒤가 럭스에게 가장 안전하게 접근할 수 있는 순간**이다.[* 인벤 럭스 상대법은 긴 사거리 포킹을 피하면서 웨이브를 함께 밀어 럭스가 기술을 미니언에 쓰게 만들고, 속박이 빠진 때를 교환 창으로 잡는다. [럭스 라인전 대처](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848), [피즈 공략의 럭스 상대](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=135376)]

- `광휘의 특이점(E)` 원 안에서는 가장 가까운 가장자리로 바로 나온다.
- E가 깔린 채로 막타를 치려 하지 말고 폭발을 먼저 유도한다.
- Q에 묶이면 직선상에서 `최후의 섬광(R)`까지 이어지므로 체력이 낮을 때는 간격을 더 둔다.

## 보호막 왕복을 모두 계산한다

`프리즘 보호막(W)`은 나갈 때와 돌아올 때 두 번 보호한다. 첫 보호막만 보고 피해 계산을 끝내지 않는다. W와 Q를 함께 쓴 뒤에는 방어와 제어 수단이 동시에 비므로, 그 짧은 구간에만 압박한다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'lux' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-lux-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-lux-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'lux' AND revision = 1 AND general = '# AI 작성 초안

## 미니언 하나만 믿고 Q를 맞지 않는다

`빛의 속박(Q)`은 첫 유닛을 맞힌 뒤 하나를 더 관통한다. 미니언 한 마리 뒤에만 서면 그대로 속박될 수 있으므로 두 마리 이상을 사이에 두거나 옆으로 선다. **Q가 빗나간 뒤가 럭스에게 가장 안전하게 접근할 수 있는 순간**이다.[* 인벤 럭스 상대법은 긴 사거리 포킹을 피하면서 웨이브를 함께 밀어 럭스가 기술을 미니언에 쓰게 만들고, 속박이 빠진 때를 교환 창으로 잡는다. [럭스 라인전 대처](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848), [피즈 공략의 럭스 상대](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=135376)]

- `광휘의 특이점(E)` 원 안에서는 가장 가까운 가장자리로 바로 나온다.
- E가 깔린 채로 막타를 치려 하지 말고 폭발을 먼저 유도한다.
- Q에 묶이면 직선상에서 `최후의 섬광(R)`까지 이어지므로 체력이 낮을 때는 간격을 더 둔다.

## 보호막 왕복을 모두 계산한다

`프리즘 보호막(W)`은 나갈 때와 돌아올 때 두 번 보호한다. 첫 보호막만 보고 피해 계산을 끝내지 않는다. W와 Q를 함께 쓴 뒤에는 방어와 제어 수단이 동시에 비므로, 그 짧은 구간에만 압박한다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-lux-20260912');

-- 오리아나 (698자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-orianna', 'matchup', NULL, NULL, 'published', 'orianna', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 챔피언보다 구체 위치를 본다

오리아나의 모든 위협은 구체에서 시작한다. 오리아나와 멀리 떨어져 있어도 구체 옆에 서면 `명령: 불협화음(W)`과 `명령: 충격파(R)` 범위다. **구체 반대편으로 이동하면 다음 Q 이동 거리와 반응 시간이 늘어난다.**[* 인벤 오리아나 상대법은 구체 위치를 계속 확인하고, Q-W가 빠졌을 때 전진하며, 구체 주변에서 궁극기를 보고 피하려 하지 말라고 조언한다. [아리의 오리아나 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=122420), [신드라의 오리아나 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=132083)]

- 구체가 바닥에 있을 때 그 근처 막타를 억지로 치지 않는다.
- 구체가 오리아나에게 돌아오는 `명령: 보호(E)` 경로에서도 피해를 받지 않게 옆으로 선다.
- 오리아나의 연속 기본 공격은 점점 아프므로 길게 맞교환하지 않는다.

## Q-W 뒤의 빈 시간을 쓴다

구체가 앞으로 나와 W까지 터졌다면 다음 견제가 바로 이어지지 않는다. 이때 짧게 전진해 기술 하나를 쓰고, 구체가 다시 움직이기 전에 빠진다. 구체가 보이지 않는 수풀이나 아군 몸에 붙어 있다면 궁극기 범위를 먼저 의심한다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'orianna' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-orianna-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-orianna-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'orianna' AND revision = 1 AND general = '# AI 작성 초안

## 챔피언보다 구체 위치를 본다

오리아나의 모든 위협은 구체에서 시작한다. 오리아나와 멀리 떨어져 있어도 구체 옆에 서면 `명령: 불협화음(W)`과 `명령: 충격파(R)` 범위다. **구체 반대편으로 이동하면 다음 Q 이동 거리와 반응 시간이 늘어난다.**[* 인벤 오리아나 상대법은 구체 위치를 계속 확인하고, Q-W가 빠졌을 때 전진하며, 구체 주변에서 궁극기를 보고 피하려 하지 말라고 조언한다. [아리의 오리아나 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=122420), [신드라의 오리아나 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=132083)]

- 구체가 바닥에 있을 때 그 근처 막타를 억지로 치지 않는다.
- 구체가 오리아나에게 돌아오는 `명령: 보호(E)` 경로에서도 피해를 받지 않게 옆으로 선다.
- 오리아나의 연속 기본 공격은 점점 아프므로 길게 맞교환하지 않는다.

## Q-W 뒤의 빈 시간을 쓴다

구체가 앞으로 나와 W까지 터졌다면 다음 견제가 바로 이어지지 않는다. 이때 짧게 전진해 기술 하나를 쓰고, 구체가 다시 움직이기 전에 빠진다. 구체가 보이지 않는 수풀이나 아군 몸에 붙어 있다면 궁극기 범위를 먼저 의심한다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-orianna-20260912');

-- 애니비아 (690자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-anivia', 'matchup', NULL, NULL, 'published', 'anivia', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 느린 Q를 옆으로 피하고 냉각된 상태에서 물러난다

`냉기 폭발(Q)`은 투사체와 폭발에 맞으면 기절한다. 직선으로 뒤로 빼면 오래 따라오므로 옆으로 비킨다. Q나 완성된 `얼음 폭풍(R)`에 맞아 냉각됐다면 **`동상(E)`의 두 배 피해가 오기 전에 사거리 밖으로 나간다.**[* 인벤 애니비아 상대법은 느린 Q를 피하고, 6레벨 전 푸시와 이동을 통해 성장 시간을 압박하며, 패시브 알까지 계산하지 않은 마무리를 경계한다. [야스오의 애니비아 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=136999), [애니비아 맞춤 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=120543)]

- 벽과 애니비아 사이의 좁은 통로로 들어가지 않는다.
- R 장판이 커지기 전에 즉시 벗어나고, 장판 안에서 막타를 버티지 않는다.
- 패시브가 준비된 애니비아를 쓰러뜨릴 때 알을 끝낼 시간과 적 위치를 먼저 본다.

## 6레벨 전 웨이브를 움직인다

애니비아는 초반 기본 공격과 기술 속도가 느리다. 무리한 처치보다 먼저 밀어 포탑 아래 막타를 강요하고 강가 주도권을 만든다. Q가 빠졌다면 벽 외에는 즉시 진입을 막을 수단이 줄어드니 짧게 압박한다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'anivia' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-anivia-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-anivia-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'anivia' AND revision = 1 AND general = '# AI 작성 초안

## 느린 Q를 옆으로 피하고 냉각된 상태에서 물러난다

`냉기 폭발(Q)`은 투사체와 폭발에 맞으면 기절한다. 직선으로 뒤로 빼면 오래 따라오므로 옆으로 비킨다. Q나 완성된 `얼음 폭풍(R)`에 맞아 냉각됐다면 **`동상(E)`의 두 배 피해가 오기 전에 사거리 밖으로 나간다.**[* 인벤 애니비아 상대법은 느린 Q를 피하고, 6레벨 전 푸시와 이동을 통해 성장 시간을 압박하며, 패시브 알까지 계산하지 않은 마무리를 경계한다. [야스오의 애니비아 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=136999), [애니비아 맞춤 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=120543)]

- 벽과 애니비아 사이의 좁은 통로로 들어가지 않는다.
- R 장판이 커지기 전에 즉시 벗어나고, 장판 안에서 막타를 버티지 않는다.
- 패시브가 준비된 애니비아를 쓰러뜨릴 때 알을 끝낼 시간과 적 위치를 먼저 본다.

## 6레벨 전 웨이브를 움직인다

애니비아는 초반 기본 공격과 기술 속도가 느리다. 무리한 처치보다 먼저 밀어 포탑 아래 막타를 강요하고 강가 주도권을 만든다. Q가 빠졌다면 벽 외에는 즉시 진입을 막을 수단이 줄어드니 짧게 압박한다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-anivia-20260912');

-- 조이 (606자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-zoe', 'matchup', NULL, NULL, 'published', 'zoe', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 미니언과 벽 사이에서 수면 각을 지운다

`헤롱헤롱쿨쿨방울(E)`은 첫 대상에 맞지만 벽을 통과하면 사거리가 길어진다. 미니언 뒤를 쓰되, 옆 벽에서 날아오는 각까지 함께 본다. **수면에 맞았다면 조이와 반대 방향보다 통통별 이동 거리를 줄이는 쪽으로 움직인다.**[* 인벤 조이 공략은 수면 뒤 긴 거리 Q가 핵심이며, `차원 넘기(R)`가 반드시 원래 자리로 돌아온다는 점과 로밍형 상대에게 밀리기 쉬운 라인 구조를 설명한다. [조이 참고서](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=141439)]

- 조이가 Q를 뒤로 보냈다면 정면 직선에서 벗어난다.
- `차원 넘기(R)`로 앞으로 나오면 현재 위치보다 돌아갈 표식을 겨냥한다.
- 주문 파편이 떨어진 미니언 근처에서는 조이가 추가 행동을 얻는 순간을 예상한다.

## 수면이 빠진 뒤 웨이브를 민다

E가 빗나가면 조이는 접근을 막는 수단이 크게 줄어든다. 그때 짧게 전진하거나 웨이브를 밀어 다음 수면을 미니언 정리에 쓰게 한다. 시야가 없는 옆 벽에는 E가 길게 넘어올 수 있으므로 중앙에만 시선을 두지 않는다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'zoe' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-zoe-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-zoe-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'zoe' AND revision = 1 AND general = '# AI 작성 초안

## 미니언과 벽 사이에서 수면 각을 지운다

`헤롱헤롱쿨쿨방울(E)`은 첫 대상에 맞지만 벽을 통과하면 사거리가 길어진다. 미니언 뒤를 쓰되, 옆 벽에서 날아오는 각까지 함께 본다. **수면에 맞았다면 조이와 반대 방향보다 통통별 이동 거리를 줄이는 쪽으로 움직인다.**[* 인벤 조이 공략은 수면 뒤 긴 거리 Q가 핵심이며, `차원 넘기(R)`가 반드시 원래 자리로 돌아온다는 점과 로밍형 상대에게 밀리기 쉬운 라인 구조를 설명한다. [조이 참고서](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=141439)]

- 조이가 Q를 뒤로 보냈다면 정면 직선에서 벗어난다.
- `차원 넘기(R)`로 앞으로 나오면 현재 위치보다 돌아갈 표식을 겨냥한다.
- 주문 파편이 떨어진 미니언 근처에서는 조이가 추가 행동을 얻는 순간을 예상한다.

## 수면이 빠진 뒤 웨이브를 민다

E가 빗나가면 조이는 접근을 막는 수단이 크게 줄어든다. 그때 짧게 전진하거나 웨이브를 밀어 다음 수면을 미니언 정리에 쓰게 한다. 시야가 없는 옆 벽에는 E가 길게 넘어올 수 있으므로 중앙에만 시선을 두지 않는다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-zoe-20260912');

-- 베이가 (724자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-veigar', 'matchup', NULL, NULL, 'published', 'veigar', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 감옥이 생기기 전에 바깥으로 나간다

`사건의 지평선(E)`은 테두리가 생긴 뒤 닿으면 기절한다. 예고가 보였을 때 가장 가까운 바깥으로 빠지는 것이 우선이다. 이미 안에 갇혔다면 **테두리를 억지로 넘지 말고 내부에서 `암흑 물질(W)` 착지점을 피한다.**[* 인벤 베이가 공략은 E 없이는 기술 적중과 연계가 어려우며, 피해를 넣으려면 어느 정도 접근해야 한다는 약점을 설명한다. 트위스티드 페이트 상대법도 6레벨 전 베이가를 압박 가능한 성장형 상대로 분류한다. [미드 베이가 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=138154), [베이가 라인전 분류](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848)]

- 베이가가 Q로 막타와 챔피언을 함께 맞히지 못하게 웨이브와 사선으로 선다.
- E가 빠진 뒤에는 베이가의 자기 보호 수단이 줄어든다.
- 체력이 낮을수록 궁극기 피해가 커지므로 애매한 체력으로 한 번 더 막타를 보지 않는다.

## 성장 시간을 공짜로 주지 않는다

베이가는 Q로 유닛을 처치할수록 강해진다. 무리한 다이브보다 웨이브를 먼저 밀어 Q를 막타에 쓰게 하고, E가 없는 동안 강가 시야와 합류 우위를 챙긴다. 감옥을 빼냈다면 그 시간을 아무 행동 없이 보내지 않는다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'veigar' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-veigar-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-veigar-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'veigar' AND revision = 1 AND general = '# AI 작성 초안

## 감옥이 생기기 전에 바깥으로 나간다

`사건의 지평선(E)`은 테두리가 생긴 뒤 닿으면 기절한다. 예고가 보였을 때 가장 가까운 바깥으로 빠지는 것이 우선이다. 이미 안에 갇혔다면 **테두리를 억지로 넘지 말고 내부에서 `암흑 물질(W)` 착지점을 피한다.**[* 인벤 베이가 공략은 E 없이는 기술 적중과 연계가 어려우며, 피해를 넣으려면 어느 정도 접근해야 한다는 약점을 설명한다. 트위스티드 페이트 상대법도 6레벨 전 베이가를 압박 가능한 성장형 상대로 분류한다. [미드 베이가 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=138154), [베이가 라인전 분류](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848)]

- 베이가가 Q로 막타와 챔피언을 함께 맞히지 못하게 웨이브와 사선으로 선다.
- E가 빠진 뒤에는 베이가의 자기 보호 수단이 줄어든다.
- 체력이 낮을수록 궁극기 피해가 커지므로 애매한 체력으로 한 번 더 막타를 보지 않는다.

## 성장 시간을 공짜로 주지 않는다

베이가는 Q로 유닛을 처치할수록 강해진다. 무리한 다이브보다 웨이브를 먼저 밀어 Q를 막타에 쓰게 하고, E가 없는 동안 강가 시야와 합류 우위를 챙긴다. 감옥을 빼냈다면 그 시간을 아무 행동 없이 보내지 않는다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-veigar-20260912');

-- 벡스 (580자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-vex', 'matchup', NULL, NULL, 'published', 'vex', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 공포가 준비됐을 때 이동기로 들어가지 않는다

벡스의 파멸 표식이 준비되면 다음 기본 기술이 공포를 건다. 상태 표시가 켜진 동안에는 이동기로 먼저 접근하지 않는다. **`커지는 어둠(E)`를 피워 공포를 소모시킨 뒤가 가장 분명한 진입 창**이다.[* 인벤의 벡스 상대법은 패시브 공포를 먼저 피하고, E와 근거리 W 범위를 각각 벗어난 뒤 교환하라고 설명한다. [오로라 공략의 벡스 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=148099)]

- E 원이 커지는 동안 가장 가까운 바깥으로 걷는다.
- 가까이 붙을 때는 `거리 두기(W)` 보호막과 공포가 함께 나올 수 있음을 계산한다.
- `그림자 파동(R)`은 미니언을 사이에 둬 첫 적중을 막는다.

## 표식이 묻으면 혼자 깊게 빠지지 않는다

R 표식이 남은 동안 벡스는 다시 시전해 대상에게 날아올 수 있다. 아군과 너무 멀어지는 방향으로 도망치지 말고, 벡스가 도착했을 때 함께 대응할 수 있는 쪽으로 이동한다. 첫 R이 빗나가면 장거리 진입 위협이 사라진다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'vex' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-vex-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-vex-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'vex' AND revision = 1 AND general = '# AI 작성 초안

## 공포가 준비됐을 때 이동기로 들어가지 않는다

벡스의 파멸 표식이 준비되면 다음 기본 기술이 공포를 건다. 상태 표시가 켜진 동안에는 이동기로 먼저 접근하지 않는다. **`커지는 어둠(E)`를 피워 공포를 소모시킨 뒤가 가장 분명한 진입 창**이다.[* 인벤의 벡스 상대법은 패시브 공포를 먼저 피하고, E와 근거리 W 범위를 각각 벗어난 뒤 교환하라고 설명한다. [오로라 공략의 벡스 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=148099)]

- E 원이 커지는 동안 가장 가까운 바깥으로 걷는다.
- 가까이 붙을 때는 `거리 두기(W)` 보호막과 공포가 함께 나올 수 있음을 계산한다.
- `그림자 파동(R)`은 미니언을 사이에 둬 첫 적중을 막는다.

## 표식이 묻으면 혼자 깊게 빠지지 않는다

R 표식이 남은 동안 벡스는 다시 시전해 대상에게 날아올 수 있다. 아군과 너무 멀어지는 방향으로 도망치지 말고, 벡스가 도착했을 때 함께 대응할 수 있는 쪽으로 이동한다. 첫 R이 빗나가면 장거리 진입 위협이 사라진다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-vex-20260912');

-- 카시오페아 (697자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-cassiopeia', 'matchup', NULL, NULL, 'published', 'cassiopeia', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## Q를 피하면 쌍독니의 긴 교환도 끊긴다

카시오페아는 `맹독 폭발(Q)`을 맞힌 뒤 이동 속도를 얻고 강화된 `쌍독니(E)`를 반복한다. 첫 Q를 옆으로 피하고, 맞았다면 독이 끝날 때까지 뒤로 빠진다. **독에 걸린 채 제자리에서 맞딜하는 것이 가장 나쁜 선택**이다.[* 인벤 카시오페아 라인전 공략과 상대법은 Q 적중 뒤 이어지는 E 연타, 독기의 늪에서 이동기가 막히는 점, 궁극기를 예상해 시선을 돌리는 대응을 핵심으로 다룬다. [카시오페아 라인전 디테일](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=145069), [카시오페아 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137300)]

- `독기의 늪(W)` 위에서는 이동 기술이 막히므로 가장 가까운 가장자리로 걷는다.
- Q가 빗나가면 카시오페아가 E를 길게 이어갈 이유가 줄어든다.
- 정면에서 궁극기 동작이 보이면 카시오페아 반대쪽으로 시선을 돌린다.

## 짧게 때리고 독이 없는 시간을 쓴다

카시오페아는 긴 싸움에서 강하다. 기술 하나만 쓰고 빠지는 교환을 반복하고, Q가 없는 동안 웨이브를 건드린다. 미니언이 적어 E를 챔피언에게 계속 쓸 수 있는 넓은 공간에서는 추격하지 않는다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'cassiopeia' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-cassiopeia-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-cassiopeia-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'cassiopeia' AND revision = 1 AND general = '# AI 작성 초안

## Q를 피하면 쌍독니의 긴 교환도 끊긴다

카시오페아는 `맹독 폭발(Q)`을 맞힌 뒤 이동 속도를 얻고 강화된 `쌍독니(E)`를 반복한다. 첫 Q를 옆으로 피하고, 맞았다면 독이 끝날 때까지 뒤로 빠진다. **독에 걸린 채 제자리에서 맞딜하는 것이 가장 나쁜 선택**이다.[* 인벤 카시오페아 라인전 공략과 상대법은 Q 적중 뒤 이어지는 E 연타, 독기의 늪에서 이동기가 막히는 점, 궁극기를 예상해 시선을 돌리는 대응을 핵심으로 다룬다. [카시오페아 라인전 디테일](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=145069), [카시오페아 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137300)]

- `독기의 늪(W)` 위에서는 이동 기술이 막히므로 가장 가까운 가장자리로 걷는다.
- Q가 빗나가면 카시오페아가 E를 길게 이어갈 이유가 줄어든다.
- 정면에서 궁극기 동작이 보이면 카시오페아 반대쪽으로 시선을 돌린다.

## 짧게 때리고 독이 없는 시간을 쓴다

카시오페아는 긴 싸움에서 강하다. 기술 하나만 쓰고 빠지는 교환을 반복하고, Q가 없는 동안 웨이브를 건드린다. 미니언이 적어 E를 챔피언에게 계속 쓸 수 있는 넓은 공간에서는 추격하지 않는다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-cassiopeia-20260912');

-- 탈리야 (611자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-taliyah', 'matchup', NULL, NULL, 'published', 'taliyah', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 돌밭 위로 이동기를 쓰지 않는다

`대지의 파동(E)` 위에서 돌진하거나 밀려나면 바위가 폭발해 기절한다. 장판이 깔리면 이동 기술로 가로지르지 말고 걸어서 가장자리로 나온다. **탈리야의 E가 남아 있을 때 직선 진입을 시작하지 않는다.**[* 인벤 탈리야 공략은 E 위로 돌진한 적이 기절하는 상성과, W로 적을 E 위에 던지는 연계, 순간이동형 이동기와 장거리 포킹에 약한 점을 설명한다. [미드 탈리야 정석](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=129711)]

- `지각변동(W)` 예고가 보이면 뒤가 아니라 옆으로 움직여 밀려날 방향을 비튼다.
- `파편 난사(Q)`는 첫 파편을 피한 뒤 같은 방향으로 계속 달리지 않는다.
- 다져진 땅에서는 큰 바위 한 발이 둔화를 주므로 착지 지점을 먼저 피한다.

## W와 E가 갈린 순간에 접근한다

W가 빗나가거나 E를 웨이브 정리에 썼다면 탈리야의 근거리 자기 보호가 약해진다. 그때만 짧게 압박하고, 두 기술이 다시 준비되기 전에 빠진다. 라인을 민 뒤 시야에서 사라지면 벽을 타고 빠르게 합류할 수 있으므로 바로 알린다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'taliyah' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-taliyah-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-taliyah-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'taliyah' AND revision = 1 AND general = '# AI 작성 초안

## 돌밭 위로 이동기를 쓰지 않는다

`대지의 파동(E)` 위에서 돌진하거나 밀려나면 바위가 폭발해 기절한다. 장판이 깔리면 이동 기술로 가로지르지 말고 걸어서 가장자리로 나온다. **탈리야의 E가 남아 있을 때 직선 진입을 시작하지 않는다.**[* 인벤 탈리야 공략은 E 위로 돌진한 적이 기절하는 상성과, W로 적을 E 위에 던지는 연계, 순간이동형 이동기와 장거리 포킹에 약한 점을 설명한다. [미드 탈리야 정석](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=129711)]

- `지각변동(W)` 예고가 보이면 뒤가 아니라 옆으로 움직여 밀려날 방향을 비튼다.
- `파편 난사(Q)`는 첫 파편을 피한 뒤 같은 방향으로 계속 달리지 않는다.
- 다져진 땅에서는 큰 바위 한 발이 둔화를 주므로 착지 지점을 먼저 피한다.

## W와 E가 갈린 순간에 접근한다

W가 빗나가거나 E를 웨이브 정리에 썼다면 탈리야의 근거리 자기 보호가 약해진다. 그때만 짧게 압박하고, 두 기술이 다시 준비되기 전에 빠진다. 라인을 민 뒤 시야에서 사라지면 벽을 타고 빠르게 합류할 수 있으므로 바로 알린다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-taliyah-20260912');

-- 애니 (587자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-annie', 'matchup', NULL, NULL, 'published', 'annie', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 기절 중첩이 보이면 막타 하나를 버린다

애니는 기술을 네 번 사용하면 다음 공격 기술에 기절이 붙는다. 중첩 표시가 가득 찬 동안에는 사거리 끝에서 막타를 욕심내지 않는다. **기절을 미니언 정리에 쓴 직후가 가장 안전한 교환 창**이다.[* 인벤 애니 상대법 공략은 챔피언별 라인전의 출발점으로 기절 중첩과 짧은 사거리를 반복해 다루며, 기술이 빠진 뒤의 간격 조절을 강조한다. [미드 애니 챔피언별 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=144836)]

- 애니가 Q로 막타를 이어갈 때 중첩 수가 빠르게 바뀌는 것을 본다.
- `소각(W)`은 원뿔 범위이므로 미니언과 겹쳐 맞지 않게 사선으로 선다.
- `용암 방패(E)`가 켜진 동안 무의미한 기본 공격을 반복하지 않는다.

## 6레벨 뒤에는 미니언과 떨어진다

`소환: 티버(R)`는 지정 구역에 즉시 피해와 기절을 겹칠 수 있다. 기절이 준비된 애니가 전진하면 아군과 붙어 한 번에 맞지 않는다. 티버가 나온 뒤에는 애니만 쫓지 말고 주변 지속 피해 범위에서도 빠진다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'annie' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-annie-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-annie-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'annie' AND revision = 1 AND general = '# AI 작성 초안

## 기절 중첩이 보이면 막타 하나를 버린다

애니는 기술을 네 번 사용하면 다음 공격 기술에 기절이 붙는다. 중첩 표시가 가득 찬 동안에는 사거리 끝에서 막타를 욕심내지 않는다. **기절을 미니언 정리에 쓴 직후가 가장 안전한 교환 창**이다.[* 인벤 애니 상대법 공략은 챔피언별 라인전의 출발점으로 기절 중첩과 짧은 사거리를 반복해 다루며, 기술이 빠진 뒤의 간격 조절을 강조한다. [미드 애니 챔피언별 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=144836)]

- 애니가 Q로 막타를 이어갈 때 중첩 수가 빠르게 바뀌는 것을 본다.
- `소각(W)`은 원뿔 범위이므로 미니언과 겹쳐 맞지 않게 사선으로 선다.
- `용암 방패(E)`가 켜진 동안 무의미한 기본 공격을 반복하지 않는다.

## 6레벨 뒤에는 미니언과 떨어진다

`소환: 티버(R)`는 지정 구역에 즉시 피해와 기절을 겹칠 수 있다. 기절이 준비된 애니가 전진하면 아군과 붙어 한 번에 맞지 않는다. 티버가 나온 뒤에는 애니만 쫓지 말고 주변 지속 피해 범위에서도 빠진다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-annie-20260912');

-- 아우렐리온 솔 (608자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-aurelionsol', 'matchup', NULL, NULL, 'published', 'aurelionsol', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## Q 정신 집중을 공짜로 이어가게 두지 않는다

아우렐리온 솔은 `빛의 숨결(Q)`을 같은 대상에게 계속 맞혀 추가 피해와 별가루를 얻는다. 숨결을 맞으면 옆으로 벗어나 시야나 사거리를 끊는다. **제자리에 멈춰 Q를 쓰는 순간이 오히려 기술을 맞히기 쉬운 창**이다.[* 인벤 아우렐리온 솔 공략 페이지는 현재 스킬 설명과 함께 Q 지속 적중, W 비행 중 Q 강화, E 중심 처형과 별가루 성장 구조를 제공한다. [아우렐리온 솔 기본 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=136613)]

- `특이점(E)` 중심으로 걸어가지 말고 가장 가까운 바깥으로 빠진다.
- 체력이 낮은 미니언이 E 안에 몰렸을 때 함께 서서 별가루를 더 주지 않는다.
- `별의 비행(W)` 방향이 정해지면 옆으로 움직여 Q 직선을 끊는다.

## 초반 웨이브에서 성장 시간을 압박한다

별가루가 적을 때는 기술 범위와 처형 기준이 작다. 무리한 처치보다 먼저 밀어 Q와 E를 미니언 정리에 쓰게 하고, 정신 집중이 끊긴 동안 짧게 교환한다. W가 빠진 뒤에는 즉시 거리를 다시 만들기 어렵다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'aurelionsol' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-aurelionsol-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-aurelionsol-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'aurelionsol' AND revision = 1 AND general = '# AI 작성 초안

## Q 정신 집중을 공짜로 이어가게 두지 않는다

아우렐리온 솔은 `빛의 숨결(Q)`을 같은 대상에게 계속 맞혀 추가 피해와 별가루를 얻는다. 숨결을 맞으면 옆으로 벗어나 시야나 사거리를 끊는다. **제자리에 멈춰 Q를 쓰는 순간이 오히려 기술을 맞히기 쉬운 창**이다.[* 인벤 아우렐리온 솔 공략 페이지는 현재 스킬 설명과 함께 Q 지속 적중, W 비행 중 Q 강화, E 중심 처형과 별가루 성장 구조를 제공한다. [아우렐리온 솔 기본 공략](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=136613)]

- `특이점(E)` 중심으로 걸어가지 말고 가장 가까운 바깥으로 빠진다.
- 체력이 낮은 미니언이 E 안에 몰렸을 때 함께 서서 별가루를 더 주지 않는다.
- `별의 비행(W)` 방향이 정해지면 옆으로 움직여 Q 직선을 끊는다.

## 초반 웨이브에서 성장 시간을 압박한다

별가루가 적을 때는 기술 범위와 처형 기준이 작다. 무리한 처치보다 먼저 밀어 Q와 E를 미니언 정리에 쓰게 하고, 정신 집중이 끊긴 동안 짧게 교환한다. W가 빠진 뒤에는 즉시 거리를 다시 만들기 어렵다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-aurelionsol-20260912');

-- 리산드라 (682자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-lissandra', 'matchup', NULL, NULL, 'published', 'lissandra', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 미니언과 일직선으로 서지 않는다

`얼음 파편(Q)`은 첫 대상에서 부서진 뒤 뒤쪽으로 더 뻗는다. 미니언 뒤가 안전지대가 아니므로 웨이브와 사선으로 선다. **리산드라 몸 주변의 `서릿발(W)` 범위 밖에서 교환을 시작한다.**[* 인벤 리산드라 상대법은 미니언을 통과해 길어지는 Q, 근접 진입을 끊는 W, E 재사용 위치와 확정 궁극기를 중심으로 설명한다. [에코의 리산드라 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=134573), [카타리나의 리산드라 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=122233)]

- `얼음갈퀴 길(E)`이 지나가면 리산드라보다 갈퀴 끝 위치를 먼저 본다.
- E 끝에 제어 기술을 미리 두거나, 착지 범위에서 벗어난다.
- 6레벨 이후 체력이 낮을 때는 즉시 `얼음 무덤(R)`에 묶일 거리를 주지 않는다.

## 자기 궁극기를 쓴 동안 다음 위치를 잡는다

리산드라가 자신에게 R을 쓰면 무적이라 피해를 넣을 수 없다. 그 자리에 기술을 낭비하지 말고 얼음 장판 범위에서 빠져, 풀리는 순간의 퇴로를 막는다. 적에게 R을 쓴 뒤에는 확정 제어가 빠졌으므로 다음 교환 창이 열린다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'lissandra' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-lissandra-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-lissandra-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'lissandra' AND revision = 1 AND general = '# AI 작성 초안

## 미니언과 일직선으로 서지 않는다

`얼음 파편(Q)`은 첫 대상에서 부서진 뒤 뒤쪽으로 더 뻗는다. 미니언 뒤가 안전지대가 아니므로 웨이브와 사선으로 선다. **리산드라 몸 주변의 `서릿발(W)` 범위 밖에서 교환을 시작한다.**[* 인벤 리산드라 상대법은 미니언을 통과해 길어지는 Q, 근접 진입을 끊는 W, E 재사용 위치와 확정 궁극기를 중심으로 설명한다. [에코의 리산드라 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=134573), [카타리나의 리산드라 상대법](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=122233)]

- `얼음갈퀴 길(E)`이 지나가면 리산드라보다 갈퀴 끝 위치를 먼저 본다.
- E 끝에 제어 기술을 미리 두거나, 착지 범위에서 벗어난다.
- 6레벨 이후 체력이 낮을 때는 즉시 `얼음 무덤(R)`에 묶일 거리를 주지 않는다.

## 자기 궁극기를 쓴 동안 다음 위치를 잡는다

리산드라가 자신에게 R을 쓰면 무적이라 피해를 넣을 수 없다. 그 자리에 기술을 낭비하지 말고 얼음 장판 범위에서 빠져, 풀리는 순간의 퇴로를 막는다. 적에게 R을 쓴 뒤에는 확정 제어가 빠졌으므로 다음 교환 창이 열린다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-lissandra-20260912');

-- 아지르 (689자)
INSERT OR IGNORE INTO wiki_docs (id, kind, title, title_key, doc_status, champion_slug, general, revision, patch, edit_policy, created_at, updated_at, updated_by)
VALUES ('doc-c-azir', 'matchup', NULL, NULL, 'published', 'azir', '', 0, '16.17.1', 'guarded', '2026-09-12T12:30:00.000Z', '2026-09-12T12:30:00.000Z', 'user-system');
UPDATE wiki_docs
SET general = '# AI 작성 초안

## 아지르가 아니라 병사 사거리를 피한다

아지르의 기본 공격은 모래 병사 위치에서 시작한다. 챔피언 본체와 거리가 있어도 병사 가까이에 서면 계속 맞는다. **병사 옆이 아니라 병사 공격선의 바깥으로 움직여야 한다.**[* 인벤 아지르 상대법은 1레벨부터 맞푸시해 일방적인 견제를 줄이고, W-Q 병사 이동을 계속 움직이며 피하며, 무리한 맞교환보다 웨이브를 유지하라고 설명한다. [아지르 라인전 대처](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848), [탈리야 공략의 아지르 항목](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=129711)]

- 병사가 없는 쪽으로 막타 위치를 바꾼다.
- `사막의 맹습(Q)`으로 병사들이 이동하는 순간 옆으로 비켜 추가 공격을 줄인다.
- 아지르와 병사 사이 직선에서는 `신기루(E)` 충돌 경로를 비운다.

## 밀어내기 각을 벽과 함께 본다

6레벨 이후 아지르가 E로 병사에게 접근하면 `황제의 진영(R)`으로 뒤쪽에 밀 수 있다. 포탑 방향으로 등을 보인 채 추격하지 않고, 옆으로 빠질 공간을 남긴다. 병사를 전진 배치한 뒤에는 아지르 본체 주변의 즉시 공격 범위가 줄어드니 그때 웨이브를 정리한다.', revision = 1, patch = '16.17.1', updated_at = '2026-09-12T12:30:00.000Z', updated_by = 'user-system'
WHERE kind = 'matchup' AND champion_slug = 'azir' AND revision = 0 AND TRIM(general) = ''
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-azir-20260912');
INSERT INTO wiki_edits (id, doc_id, me_slug, base_revision, body, summary, status, author, created_at, accepted_via, revision)
SELECT 'edit-ai-mid-matchup-azir-20260912', id, NULL, 0, general, 'AI 작성: 인벤 기반 실전 라인전 상대법', 'accepted', 'user-system', '2026-09-12T12:30:00.000Z', 'admin', 1 FROM wiki_docs
WHERE kind = 'matchup' AND champion_slug = 'azir' AND revision = 1 AND general = '# AI 작성 초안

## 아지르가 아니라 병사 사거리를 피한다

아지르의 기본 공격은 모래 병사 위치에서 시작한다. 챔피언 본체와 거리가 있어도 병사 가까이에 서면 계속 맞는다. **병사 옆이 아니라 병사 공격선의 바깥으로 움직여야 한다.**[* 인벤 아지르 상대법은 1레벨부터 맞푸시해 일방적인 견제를 줄이고, W-Q 병사 이동을 계속 움직이며 피하며, 무리한 맞교환보다 웨이브를 유지하라고 설명한다. [아지르 라인전 대처](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=137848), [탈리야 공략의 아지르 항목](https://lol.inven.co.kr/dataninfo/champion/manualToolView.php?idx=129711)]

- 병사가 없는 쪽으로 막타 위치를 바꾼다.
- `사막의 맹습(Q)`으로 병사들이 이동하는 순간 옆으로 비켜 추가 공격을 줄인다.
- 아지르와 병사 사이 직선에서는 `신기루(E)` 충돌 경로를 비운다.

## 밀어내기 각을 벽과 함께 본다

6레벨 이후 아지르가 E로 병사에게 접근하면 `황제의 진영(R)`으로 뒤쪽에 밀 수 있다. 포탑 방향으로 등을 보인 채 추격하지 않고, 옆으로 빠질 공간을 남긴다. 병사를 전진 배치한 뒤에는 아지르 본체 주변의 즉시 공격 범위가 줄어드니 그때 웨이브를 정리한다.'
AND updated_at = '2026-09-12T12:30:00.000Z' AND updated_by = 'user-system'
AND NOT EXISTS (SELECT 1 FROM wiki_edits WHERE id = 'edit-ai-mid-matchup-azir-20260912');
