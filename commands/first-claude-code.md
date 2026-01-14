---
description: 첫 번째 프로젝트 만들기 - 완전 초보자용 쇼케이스
---

# 첫 번째 프로젝트 만들기

완전 초보자를 위한 **Claude Code 첫 경험**. "너로 대체 뭘 할 수 있어?"에 답하면서 웹 프로젝트를 만드는 쇼케이스 커맨드.

## 사용법

```
/first-claude-code
```

## 왜 이 커맨드가 필요한가?

```
문제: Claude Code가 뭔지 전혀 모르는 사람은 어디서부터 시작해야 할지 모름
해결: 실제로 동작하는 프로젝트를 만들어주면서 "와, 이게 되네?" 경험 제공
결과: 웹 프로젝트 완성 + Claude Code 설정까지 한 번에
```

### 커맨드 포지셔닝

| 커맨드 | 대상 | 목적 |
|--------|------|------|
| `/first-claude-code` | 완전 초보자 | 첫 프로젝트 실행 체험 ("와, 이게 되네?") |
| `/learn-claude-code` | 배우고 싶은 사람 | Claude Code 교육 (레벨별 학습) |
| `/setup-claude-code` | 설정 없는 프로젝트 | 초기 설정 생성 (.claude/, CLAUDE.md) |
| `/upgrade-claude-code` | 설정 있는 프로젝트 | 업그레이드 + 트렌드 분석 (정기 실행 가능) |

---

## 수행 작업

### 0단계: 마스터 가이드 참조

**반드시** 다음 문서를 먼저 읽습니다:

```
.claude/docs/CLAUDE-CODE-MASTERY.md
.claude/docs/mastery/09-web-project-guide.md
.claude/docs/mastery/02-language-templates.md
```

### 1단계: 사전 검증 (백그라운드)

사용자에게 보이지 않게 확인:

1. **필수 도구 확인**

   ```bash
   node --version
   git --version
   ```

   - 미설치 시 → 9.10 에러 메시지 출력 후 종료

2. **임시 폴더 생성 준비**
   - 현재 폴더가 비어있든 아니든 상관없음
   - `/tmp/claude-project-{timestamp}` 에서 작업 후 복사

### 2단계: 인사 & 소개

```
안녕하세요! 저는 Claude Code예요.

코딩을 도와주는 AI 도구인데요, 제가 뭘 할 수 있는지 직접 보여드릴게요!
간단한 웹 프로젝트를 같이 만들어볼까요?
```

### 3단계: 의도 파악

**AskUserQuestion** 사용:

```
어떤 걸 만들고 싶으세요?

예를 들어:
- MBTI 포트폴리오 (MBTI에 따라 스타일이 바뀌는!)
- 할일 관리 앱
- 쇼핑몰
- 대시보드

뭐든 자유롭게 말씀해주세요!
```

### 4단계: 질문 (AskUserQuestion 3회)

**1차 - MBTI**: "MBTI가 어떻게 되세요? (예: INTJ, ENFP)"

**2차 - 직군**: "어떤 분야의 포트폴리오인가요?"

- 디자이너 / 사진작가 / 작가 / 뮤지션 / 마케터 / 개발자 / 기타

**3차 - 스타일**: "어떤 스타일을 원하세요?"

- 미니멀 / 모던 / 레트로 / 다크 / 컬러풀 / 기타

### 5단계: 이해력 쇼케이스

MBTI + 직군 + 스타일 조합으로 맞춤 설계 출력:

```
ENFP 디자이너 + 컬러풀 스타일이시군요!

활동가 타입답게 에너지 넘치는 포트폴리오를 만들어드릴게요:
- 다채로운 그라데이션 배경
- 역동적인 호버 애니메이션
- 친근하고 열정적인 카피

섹션: About, 작업물 갤러리, 디자인 프로세스, 연락처
```

**직군별 차별화**:

| 직군     | 메인 섹션   | 스킬 표시     |
| -------- | ----------- | ------------- |
| 개발자   | 기술 스택   | 프로그레스 바 |
| 디자이너 | 갤러리      | 툴 아이콘     |
| 마케터   | 캠페인 사례 | 성과 지표     |
| 작가     | 작품 목록   | 장르/수상     |
| 사진작가 | 포토 갤러리 | 장비/스타일   |
| 뮤지션   | 앨범/트랙   | 장르/악기     |

### 6단계: 생성 방식 선택

**AskUserQuestion** 사용:

```
자, 이제 만들어볼게요!

어떤 방식으로 할까요?

1. 자동 생성 (추천)
   제가 알아서 최신 기술로 만들게요.
   빠르게 시작하고 싶으면 이거예요!

2. 수동 생성
   프레임워크, 스타일 등을 직접 고르고 싶으면요.
   이미 선호하는 기술이 있으면 이거예요!
```

### 7단계: 기술 스택 결정

#### 7.1 자동 생성 시

**WebSearch 실행**:

```
검색어: "best web tech stack 2026", "Next.js 16 features 2026"
```

**기본 스택 결정**:

| 항목         | 선택                    | 이유                                   |
| ------------ | ----------------------- | -------------------------------------- |
| 프레임워크   | Next.js 16 (App Router) | 가장 널리 사용, 풀스택, Turbopack |
| 언어         | TypeScript              | 타입 안전                              |
| 스타일링     | Tailwind CSS v4         | 빠른 개발                              |
| UI           | shadcn/ui               | 커스터마이징 용이                      |
| 상태관리     | Zustand                 | 간단한 API                             |
| 패키지매니저 | pnpm                    | 빠른 설치                              |
| 목업         | JSON 파일               | 간단하고 직관적                        |

**출력**:

```
2026년 최신 트렌드로 설정할게요!

- Next.js 16 (가장 인기 있는 프레임워크)
- Tailwind CSS (빠르게 예쁜 디자인)
- TypeScript (안전한 코드)
- shadcn/ui (깔끔한 컴포넌트)

시작합니다!
```

#### 7.2 수동 생성 시

**순차적 AskUserQuestion**:

1. **프레임워크 선택**

```
프레임워크를 선택해주세요:

React 계열:
  1. Next.js 16 (추천) - 모든 기능 포함
  2. Vite + React - 가볍고 빠름

Vue 계열:
  3. Nuxt 3 - Vue의 Next.js
  4. Vite + Vue - 가볍고 빠름

기타:
  5. SvelteKit - 새로운 접근
  6. Astro - 초고속 정적 사이트
```

2. **스타일링 선택**

```
스타일링 방식을 선택해주세요:

1. Tailwind CSS (추천) - 빠른 개발
2. CSS Modules - 전통적인 방식
3. Panda CSS - 최신 CSS-in-JS
4. styled-components - 인기 CSS-in-JS
```

3. **UI 컴포넌트 선택**

```
UI 컴포넌트 라이브러리를 선택해주세요:

1. shadcn/ui (추천) - 자유로운 커스터마이징
2. Radix UI - 접근성 중심
3. Chakra UI - 완성형
4. 직접 구현 - 라이브러리 없음
```

### 8단계: 능력 쇼케이스 2 - 프로젝트 생성

```
지금부터 제가 하는 걸 지켜보세요!
```

**생성 순서** (임시 폴더는 프로젝트 생성만! 나머지는 현재 폴더에서!):

⚠️ **중요: 임시 폴더에서는 create-next-app만 실행하고 즉시 복사!** ⚠️

```
1. [순차] 임시 폴더에서 프로젝트 뼈대만 생성
   - /tmp/claude-project-{timestamp} 에서 create-next-app 실행
   - 이것만 하고 바로 복사!

2. [순차] ⚠️ 즉시 현재 폴더로 복사 ⚠️
   - cp -r /tmp/claude-project-{timestamp}/{project_name}/* {현재_작업_폴더}/
   - cp -r /tmp/claude-project-{timestamp}/{project_name}/.* {현재_작업_폴더}/ (숨김 파일)
   - rm -rf /tmp/claude-project-{timestamp} (임시 폴더 삭제)

--- 이후 모든 작업은 현재 폴더에서! ---

3. [순차] 의존성 설치 (현재 폴더에서)
   - cd {현재_작업_폴더} && pnpm add zustand 등

4. [병렬] 기본 파일 생성 (현재 폴더에서, 클린 아키텍처 + Atomic Design)
   ├── 페이지 구조 (app/)
   ├── Atomic Design 컴포넌트 (atoms/, molecules/, organisms/, templates/)
   ├── 클린 아키텍처 (domain/, application/, infrastructure/)
   ├── /mocks 폴더 + 목업 데이터
   ├── .env.example
   └── README.md

5. [순차] Git 초기화 (현재 폴더에서)
   - **먼저 .git 폴더 존재 여부 확인**
   - .git 있으면 → "기존 Git 저장소 감지! 초기화 건너뜁니다." 출력 후 스킵
   - .git 없으면 → git init + .gitignore + 첫 커밋
```

**절대 금지**:

- ❌ 임시 폴더에서 의존성 설치
- ❌ 임시 폴더에서 파일 생성
- ❌ 임시 폴더에서 Git 초기화
- ❌ 임시 폴더에서 개발 서버 실행

**임시 폴더는 create-next-app 실행 용도로만 사용! 즉시 복사 후 삭제!**

**진행 상황 출력**:

```
프로젝트 뼈대 만드는 중... 완료!
현재 폴더로 복사하는 중... 완료!
필요한 라이브러리 설치 중... 완료!
페이지와 컴포넌트 만드는 중... 완료!
테스트용 데이터 만드는 중... 완료!
Git 설정하는 중... 완료!  (또는 "기존 Git 저장소 유지!")
```

### 8.5단계: 외부 이미지 검증

프로젝트에서 외부 이미지를 사용하는 경우, 설정과 접근 가능 여부를 검증합니다.

**1. 코드에서 외부 이미지 URL 추출**

```bash
# src 폴더 내 모든 파일에서 http:// 또는 https:// 이미지 URL 찾기
grep -rE "https?://[^\"'>\s]+\.(jpg|jpeg|png|gif|webp|svg|ico)" src/ --include="*.tsx" --include="*.ts" --include="*.jsx" --include="*.js" --include="*.vue" --include="*.svelte" --include="*.astro"
```

**2. 이미지 실제 존재 여부 확인**

```bash
# 각 외부 이미지 URL에 대해 HEAD 요청으로 존재 확인
curl -I --silent --head --max-time 5 "이미지_URL" | head -n 1
```

- 200 OK: 이미지 존재 ✅
- 404 Not Found: 이미지 없음 ❌ → 경고 출력
- 403 Forbidden: 접근 거부 ⚠️ → 경고 출력
- 타임아웃/에러: 접근 불가 ⚠️ → 경고 출력

**3. 프레임워크별 설정 검증**

| 프레임워크 | 설정 파일 | 필요한 설정 |
|------------|-----------|-------------|
| Next.js | `next.config.*` | `images.remotePatterns` |
| Nuxt | `nuxt.config.*` | `image.domains` 또는 `@nuxt/image` 모듈 |
| Astro | `astro.config.*` | `image.domains` |
| Vite (React/Vue) | 없음 | 설정 불필요 (일반 img 태그) |
| SvelteKit | 없음 | 설정 불필요 |

**Next.js인 경우 자동 수정**:

```javascript
// next.config.mjs에 추가
images: {
  remotePatterns: [
    { protocol: 'https', hostname: 'example.com' },
    { protocol: 'https', hostname: '*.amazonaws.com' },
  ],
}
```

**출력 예시**:

```
🔍 외부 이미지 검증 중...

발견된 외부 이미지 (3개):
  ✅ https://example.com/photo.png (200 OK)
  ❌ https://cdn.test.com/missing.jpg (404 Not Found)
  ⚠️ https://private.com/image.webp (403 Forbidden)

⚠️ 문제가 있는 이미지:
  - cdn.test.com/missing.jpg → 이미지가 존재하지 않습니다
  - private.com/image.webp → 접근이 거부되었습니다

Next.js 설정 업데이트:
  - example.com 도메인을 next.config.mjs에 추가했습니다
```

**문제 없을 경우**:

```
✅ 외부 이미지 검증 완료!
   - 외부 이미지 없음 또는 모든 이미지 정상
```

### 9단계: 롤백 전략

**실패 시 전체 롤백** (임시 폴더 방식이라 간단함):

```
IF 어느 단계에서든 실패하면:
  1. 실행 중인 프로세스 종료
  2. 임시 폴더 삭제 (/tmp/claude-project-{timestamp})
  3. 현재 폴더는 전혀 건드리지 않음 (안전!)
  4. 에러 메시지 출력
  5. 재시도 여부 질문
```

**에러 메시지**:

```
앗, 문제가 생겼어요!

원인: [에러 메시지]
실패한 단계: [단계명]

걱정 마세요, 다 정리해뒀어요.
다시 시도해볼까요? (Y/n)
```

### 10단계: 능력 쇼케이스 3 - 즉시 실행

**중요**: 이 단계는 **현재 작업 폴더**에서 실행해야 합니다. (임시 폴더 아님!)

```
짜잔! 완성됐어요!

실행해볼게요...
```

**실행 명령** (현재 작업 폴더에서):

```bash
cd {현재_작업_폴더} && {package_manager} run dev
```

**확인 후 출력**:

```
서버가 시작됐어요!

브라우저에서 확인해보세요:
👉 http://localhost:3000

(Ctrl+C로 서버를 멈출 수 있어요)
```

### 11단계: 능력 쇼케이스 4 - Claude Code 설정

```
잠깐, 저랑 더 잘 협업할 수 있도록 설정도 해둘게요.
```

⚠️ **사용자에게 묻지 않고 자동으로 실행** ⚠️

다음 커맨드를 **순차적으로 자동 실행** (AskUserQuestion 사용 금지!):

1. `/setup-claude-code standard` → Skill 도구로 직접 실행
2. `/upgrade-claude-code` → Skill 도구로 직접 실행

**절대 금지**:

- ❌ "setup-claude-code를 실행할까요?" 질문
- ❌ "upgrade-claude-code를 실행할까요?" 질문
- ❌ 사용자 확인 대기

**출력** (모든 설정 완료 후):

```
Claude Code 설정도 완료!

이제 저랑 이런 것들을 할 수 있어요:
- CLAUDE.md에 프로젝트 규칙 저장됨
- 자주 쓰는 커맨드 설정됨
- 코드 품질 검사 자동화됨
```

### 12단계: 마무리 & 다음 안내

```
🎉 첫 번째 프로젝트 완성!

📁 만들어진 구조 (클린 아키텍처 + Atomic Design):
{project_name}/
├── src/
│   ├── app/                    # Next.js App Router
│   ├── components/             # Atomic Design
│   │   ├── atoms/              # 버튼, 인풋 등 기본 요소
│   │   ├── molecules/          # 검색바, 카드 등 조합
│   │   ├── organisms/          # 헤더, 사이드바 등 섹션
│   │   └── templates/          # 페이지 레이아웃
│   ├── domain/                 # 비즈니스 로직 (엔티티, 유스케이스)
│   ├── application/            # 애플리케이션 서비스
│   └── infrastructure/         # 외부 연동 (API, 저장소)
├── mocks/                      # 테스트용 데이터
├── CLAUDE.md                   # 저와의 규칙
└── README.md                   # 프로젝트 설명

🔧 사용된 기술:
- {framework}
- {styling}
- {state_management}

🚀 지금 실행 중:
- http://localhost:3000

---

이제 저랑 이런 것들을 할 수 있어요:

💬 "이 버튼 색상 빨간색으로 바꿔줘"
   → 바로 수정해드려요

💬 "새 페이지 추가해줘"
   → 바로 만들어드려요

💬 "여기 버그 있어"
   → 찾아서 고쳐드려요

💬 "이 코드 설명해줘"
   → 자세히 설명해드려요

---

더 알고 싶으면: /learn-claude-code
설정 더 하고 싶으면: /setup-claude-code
```

---

## 참고 문서

- `.claude/docs/CLAUDE-CODE-MASTERY.md` - 마스터 가이드
- `.claude/docs/mastery/09-web-project-guide.md` - 웹 프로젝트 상세 가이드
- `.claude/docs/mastery/02-language-templates.md` - 언어별 템플릿
