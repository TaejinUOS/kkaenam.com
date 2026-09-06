import Link from "next/link";

import { PATCH, SYNCED_AT } from "@/data/champions";

import styles from "./SiteFooter.module.css";

const SITE_LINKS = [
  { label: "소개", href: "/about" },
  { label: "이용약관", href: "/terms" },
  { label: "개인정보처리방침", href: "/privacy" },
  { label: "문의", href: "/contact" },
];

/** 마지막 Data Dragon 갱신일 표시 (PRD 14 "패치 갱신 절차와 마지막 갱신일을 표시한다"). */
function formatSyncedAt(iso: string) {
  const date = new Date(iso);
  return new Intl.DateTimeFormat("ko-KR", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    timeZone: "Asia/Seoul",
  }).format(date);
}

export function SiteFooter() {
  return (
    <footer className={styles.footer}>
      <div className={`shell ${styles.inner}`}>
        <p className={`mono ${styles.meta}`}>
          <span className="sticker sticker--cobalt">patch {PATCH}</span>
          <span>스킬 데이터 갱신 {formatSyncedAt(SYNCED_AT)}</span>
        </p>

        <nav className={styles.links} aria-label="사이트 정보">
          <ul className={styles.linkList}>
            {SITE_LINKS.map((item) => (
              <li key={item.href}>
                <Link href={item.href}>{item.label}</Link>
              </li>
            ))}
          </ul>
        </nav>

        {/*
          Riot 비공식 프로젝트 고지 (PRD 16).

          영어 문장은 **Riot이 문구를 지정한 것**이라 옮기거나 줄이지 않고 그대로 둔다.
          일반 정책이 이 문장을 "플레이어 눈에 쉽게 띄는 곳"에 붙이도록 요구한다.
          한국어 문장은 읽는 사람을 위한 설명이지 그 요구를 대신하지 못한다.
          근거: https://developer.riotgames.com/policies/general
        */}
        <p className={styles.legal}>
          깨남.COM는 Riot Games가 승인하거나 후원하지 않은 비공식 프로젝트입니다. 챔피언 이미지와
          스킬 정보는 Riot Games의 Data Dragon을 사용하며, Riot Games의 &ldquo;Legal Jibber
          Jabber&rdquo; 정책에 따른 팬 프로젝트입니다.
        </p>
        <p className={`${styles.legal} ${styles.legalEn}`} lang="en">
          깨남.COM isn&rsquo;t endorsed by Riot Games and doesn&rsquo;t reflect the views or opinions
          of Riot Games or anyone officially involved in producing or managing Riot Games properties.
          Riot Games, and all associated properties are trademarks or registered trademarks of Riot
          Games, Inc.
        </p>
      </div>
    </footer>
  );
}
