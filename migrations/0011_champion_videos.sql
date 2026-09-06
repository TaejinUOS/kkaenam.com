-- 운영자 선별 영상 (PRD 5.3.2, 데이터 모델 "영상", 미결정 9번의 절반).
--
-- PRD의 데이터 모델은 영상을 `상대 포지션 ID + 상대 챔피언 ID`로 잡았지만 여기서는
-- **챔피언 하나**에만 매단다. 마이그레이션 0003이 매치업 문서를 챔피언에 매단 뒤로
-- 럭스 문서는 하나인데, 영상만 미드·서폿으로 갈리면 같은 화면 안에서 문서와 영상이
-- 서로 다른 단위로 말하게 된다. 포지션별 구분이 정말 필요해지면 그때 열이 하나
-- 늘어날 뿐이고, 지금 미리 갈라 두면 되돌릴 때 이미 쌓인 행을 합쳐야 한다.
--
-- **썸네일 주소는 저장하지 않는다.** 유튜브의 썸네일은 영상 ID에서 규칙으로 유도되므로
-- (`i.ytimg.com/vi/<id>/hqdefault.jpg`) 저장하면 같은 값을 두 곳에 두는 것이 된다.
-- 반대로 제목과 채널 이름은 등록할 때 한 번 받아 여기 박아 둔다 — 화면을 그릴 때마다
-- 유튜브에 물어보면 영상 탭이 남의 서비스 응답 시간에 매이고, 그쪽이 죽으면 우리 화면도
-- 함께 빈다.
CREATE TABLE champion_videos (
  id            TEXT PRIMARY KEY,
  champion_slug TEXT NOT NULL,
  -- 지금은 'youtube' 하나뿐이다. 열을 두는 것은 나중에 다른 제공자가 붙을 때
  -- 표를 새로 만들지 않기 위해서다. 임베드 주소는 이 값으로 갈린다.
  provider      TEXT NOT NULL DEFAULT 'youtube',
  -- 제공자 안에서의 영상 식별자. 유튜브는 11자 문자열이다.
  video_id      TEXT NOT NULL,
  title         TEXT NOT NULL,
  -- 채널 이름. 누가 만든 영상인지는 밝히고 써야 한다.
  author        TEXT,
  -- 0이면 목록에서 감춘다. 지우는 것과 다르다 — 잠깐 내렸다 올릴 수 있어야 한다.
  published     INTEGER NOT NULL DEFAULT 1,
  sort_order    INTEGER NOT NULL,
  added_at      TEXT NOT NULL,
  added_by      TEXT REFERENCES users(id)
);

-- 같은 영상을 같은 챔피언에 두 번 등록하지 않는다. 운영자가 다른 검색어로 같은
-- 영상을 다시 찾아오는 일이 흔하다.
CREATE UNIQUE INDEX idx_champion_videos_unique
  ON champion_videos (champion_slug, provider, video_id);

-- 영상 탭이 매번 쓰는 조회 그대로다. 챔피언 하나의 게시된 영상을 순서대로.
CREATE INDEX idx_champion_videos_list
  ON champion_videos (champion_slug, published, sort_order);
