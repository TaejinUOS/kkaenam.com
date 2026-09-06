"use client";

import Link from "next/link";
import { useState } from "react";

import type { VideoView } from "@/lib/videoStore";
import { youTubeEmbedUrl, youTubeThumbnailUrl, youTubeWatchUrl } from "@/lib/youtube";

import styles from "./VideoPanel.module.css";
import type { ChampionView } from "./types";

/**
 * 영상 탭 (PRD 5.3.2, FR-10).
 *
 * **누르기 전까지 플레이어를 불러오지 않는다.** 탭을 여는 것만으로 iframe이 두세 개
 * 붙으면 요청 수십 개가 나가고, 무엇보다 보기만 한 사람에게 유튜브의 시청 기록·광고
 * 쿠키가 심어진다. 그래서 먼저 썸네일 한 장만 그리고, 누른 카드에만
 * `youtube-nocookie.com` iframe을 넣는다.
 *
 * 다만 **"유튜브에 아무 요청도 가지 않는다"는 아니다.** 썸네일 자체가 유튜브 이미지
 * 서버(`i.ytimg.com`)에서 오므로 보는 사람의 IP와 브라우저 정보는 그쪽에 닿는다.
 * 쿠키를 심지 않는 정적 이미지 CDN이라 플레이어와는 무게가 다르지만, 0은 아니다 —
 * 개인정보처리방침 6조가 이 사실을 그대로 적고 있으므로 문구를 고칠 때 함께 본다.
 *
 * 목록 조판은 블루프린트 6.4의 2열 구성 그대로다.
 */
export function VideoPanel({
  champion,
  positionLabel,
  videos,
}: {
  champion: ChampionView;
  positionLabel: string;
  videos: VideoView[];
}) {
  /*
   * 재생 중인 영상은 **하나뿐이다.** 카드마다 상태를 두면 여러 개가 동시에 소리를
   * 내는데, 그 상태에서 소리의 출처를 찾는 것은 사용자의 일이 되어서는 안 된다.
   */
  const [playing, setPlaying] = useState<string | null>(null);

  if (videos.length === 0) {
    return (
      <div className={styles.panel}>
        <p className="section-index">영상 / 운영자 선별</p>

        <div className={styles.empty}>
          <p className={styles.title}>
            {positionLabel} {champion.name} 상대법 영상을 준비하고 있습니다.
          </p>
          <p className={styles.body}>
            운영자가 검수해 등록한 영상만 여기에 올라옵니다. 등록 전까지는 상대법 문서가
            가장 최신입니다.
          </p>
        </div>

        {/* 등록 전까지 자리만 잡아 두는 2열 골격. 가짜 썸네일은 넣지 않는다. */}
        <ul className={styles.skeleton} aria-hidden="true">
          <li />
          <li />
        </ul>
      </div>
    );
  }

  return (
    <div className={styles.panel}>
      <p className="section-index">영상 / 운영자 선별</p>

      <ul className={styles.list}>
        {videos.map((video) => (
          <li key={video.id} className={styles.card}>
            <div className={styles.frame}>
              {playing === video.id ? (
                <iframe
                  className={styles.player}
                  src={youTubeEmbedUrl(video.videoId)}
                  title={video.title}
                  /*
                   * `allow`에 적은 것만 iframe이 쓸 수 있다. 전체 화면과 자동 재생은
                   * 필요하고, 그 밖의 권한(카메라·마이크·위치)은 주지 않는다.
                   */
                  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                  allowFullScreen
                  referrerPolicy="strict-origin-when-cross-origin"
                />
              ) : (
                <button
                  type="button"
                  className={styles.facade}
                  onClick={() => setPlaying(video.id)}
                  aria-label={`${video.title} 재생`}
                >
                  <img
                    className={styles.thumb}
                    src={youTubeThumbnailUrl(video.videoId)}
                    alt=""
                    width={480}
                    height={360}
                    loading="lazy"
                  />
                  <span className={styles.play} aria-hidden="true">
                    ▶
                  </span>
                </button>
              )}
            </div>

            <div className={styles.caption}>
              <p className={styles.cardTitle}>{video.title}</p>
              {/*
                채널 이름과 원본 링크는 늘 함께 둔다. 남이 만든 영상을 빌려 보여 주는
                자리라 누구 것인지 밝혀야 하고, 임베드가 막힌 영상은 여기가 유일한
                탈출구가 된다.
              */}
              <p className={`mono ${styles.cardMeta}`}>
                {video.author && <span>{video.author} · </span>}
                <a
                  className={styles.source}
                  href={youTubeWatchUrl(video.videoId)}
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  유튜브에서 보기 ↗
                </a>
              </p>
            </div>
          </li>
        ))}
      </ul>

      <p className={`mono ${styles.note}`}>
        재생을 누르면 유튜브 플레이어를 불러옵니다. 누르기 전까지는 미리보기 이미지만
        표시합니다 (<Link className={styles.source} href="/privacy">개인정보처리방침 6조</Link>).
      </p>
    </div>
  );
}
