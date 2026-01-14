# 9. 웹 프로젝트 생성 가이드

> `/first-claude-code` 커맨드에서 참조하는 웹 프로젝트 생성 가이드

---

## 9.1 프론트엔드 프레임워크 (2026 트렌드)

### 자동 선택 기준

| 조건 | 권장 프레임워크 | 이유 |
|------|----------------|------|
| 빠른 프로토타입 | Next.js 16 (App Router) | 파일 기반 라우팅, SSR/SSG, Turbopack |
| SPA 선호 | Vite + React | 빠른 HMR, 가벼움 |
| 풀스택 통합 | Next.js / Nuxt | API Routes 내장 |
| 정적 사이트 | Astro | 최고의 성능 |

> **Note**: Next.js 16 (2025년 10월 출시) - Turbopack이 기본 번들러로 안정화

### 수동 선택 옵션

**React 계열**:
- Next.js 16 (권장) - 풀스택, SSR/SSG, Turbopack 기본
- Vite + React - SPA, 빠른 개발, 가벼움

**Vue 계열**:
- Nuxt 3 - 풀스택, SSR/SSG
- Vite + Vue - SPA

**기타**:
- SvelteKit - 컴파일러 기반, 작은 번들
- Astro - 정적 사이트 최적화
- SolidStart - 고성능 반응형

---

## 9.2 스타일링 (2026 트렌드)

| 방식 | 권장 도구 | 특징 |
|------|----------|------|
| Utility-first | Tailwind CSS v4 | 2025.01 정식 출시, Oxide 엔진, 가장 인기 |
| CSS-in-JS (제로 런타임) | Panda CSS / vanilla-extract | 타입 안전, 빌드 타임 추출 |
| 컴포넌트 라이브러리 | shadcn/ui | 복사-붙여넣기 방식, 완전한 커스터마이징 |
| 전통적 CSS | CSS Modules | 스코프 격리, 간단함 |

### 자동 선택 기본값

```
Tailwind CSS v4 + shadcn/ui
```

- Tailwind: 빠른 개발, 일관된 디자인 시스템
- shadcn/ui: 접근성 보장, 커스터마이징 용이

---

## 9.3 상태관리 (2026 트렌드)

| 프레임워크 | 권장 도구 | 특징 |
|----------|----------|------|
| React | Zustand | 간단한 API, 작은 번들, 보일러플레이트 없음 |
| React | Jotai | 원자적 상태, 미세 조정 |
| React | TanStack Query | 서버 상태 관리, 캐싱 |
| Vue | Pinia | Vue 공식 상태관리 |
| Svelte | Built-in stores | 프레임워크 내장 |

### 자동 선택 기본값

```
Zustand (로컬 상태) + TanStack Query (서버 상태)
```

- Zustand: 클라이언트 상태 (UI 상태, 폼 등)
- TanStack Query: 서버 데이터 페칭, 캐싱, 동기화

---

## 9.4 폼 & 검증 (2026 트렌드)

| 도구 | 용도 |
|------|------|
| React Hook Form | 폼 상태 관리, 성능 최적화 |
| Zod | 스키마 검증, 타입 추론 |
| Conform | Server Actions와 통합 |

### 자동 선택 기본값

```
React Hook Form + Zod
```

---

## 9.5 목업 데이터 전략

### /mocks 폴더 구조

```
/mocks
├── db.json              # 전체 목업 데이터 (JSON Server 호환)
├── handlers.ts          # MSW 핸들러 정의
├── browser.ts           # 브라우저용 MSW 설정
├── server.ts            # 서버용 MSW 설정
├── data/
│   ├── users.json       # 사용자 데이터
│   ├── products.json    # 상품 데이터 (예시)
│   └── [entity].json    # 엔티티별 데이터
└── README.md            # 목업 사용법
```

### 목업 방식

| 방식 | 사용 시점 | 장점 |
|------|----------|------|
| JSON 파일 | 간단한 데이터 | 수정 쉬움, 직관적 |
| MSW (Mock Service Worker) | 실제 API 흉내 | 네트워크 레벨, 프로덕션 전환 쉬움 |
| Faker.js | 대량 더미 데이터 | 현실적인 데이터 생성 |

### 자동 선택 기본값

```
JSON 파일 + MSW
```

- JSON 파일: 핵심 데이터 정의
- MSW: API 요청 인터셉트, 지연 시뮬레이션

---

## 9.6 배포 옵션

### 자동 배포 (권장)

| 플랫폼 | 특징 | 적합 프로젝트 |
|--------|------|--------------|
| Vercel | Next.js 최적화, 자동 프리뷰 | Next.js/React |
| Netlify | 정적 사이트 최적화, 폼 지원 | Astro/정적 |
| Railway | 백엔드 포함, DB 지원 | 풀스택 |
| Cloudflare Pages | 엣지 배포, 무료 티어 | 모든 정적 |

### 수동 배포

- Docker + AWS ECS/EKS
- GitHub Actions + S3/CloudFront
- Kubernetes

### 자동 선택 기본값

```
Vercel (배포 설정만, 실제 배포는 사용자 선택)
```

---

## 9.7 아키텍처 패턴

### 클린 아키텍처 (Clean Architecture)

**레이어 구조**:

```
src/
├── domain/                 # 도메인 레이어 (핵심 비즈니스 로직)
│   ├── entities/           # 엔티티 정의
│   │   └── User.ts
│   ├── repositories/       # 레포지토리 인터페이스
│   │   └── UserRepository.ts
│   └── usecases/           # 유스케이스 (비즈니스 규칙)
│       └── CreateUser.ts
│
├── application/            # 애플리케이션 레이어
│   ├── services/           # 애플리케이션 서비스
│   │   └── UserService.ts
│   └── dto/                # 데이터 전송 객체
│       └── UserDTO.ts
│
└── infrastructure/         # 인프라 레이어 (외부 연동)
    ├── api/                # API 클라이언트
    │   └── UserApi.ts
    ├── repositories/       # 레포지토리 구현체
    │   └── UserRepositoryImpl.ts
    └── storage/            # 로컬 저장소
        └── LocalStorage.ts
```

**의존성 방향**:
```
UI → Application → Domain ← Infrastructure
```

- Domain: 외부 의존성 없음 (순수 비즈니스 로직)
- Application: Domain 사용
- Infrastructure: Domain 인터페이스 구현
- UI: Application 서비스 호출

---

### Atomic Design 패턴

**컴포넌트 계층**:

```
src/components/
├── atoms/                  # 원자: 더 이상 분해 불가한 기본 요소
│   ├── Button.tsx
│   ├── Input.tsx
│   ├── Label.tsx
│   ├── Icon.tsx
│   └── Text.tsx
│
├── molecules/              # 분자: 원자들의 조합
│   ├── SearchInput.tsx     # Input + Button + Icon
│   ├── FormField.tsx       # Label + Input + ErrorText
│   ├── Card.tsx            # 이미지 + 텍스트 + 버튼
│   └── NavLink.tsx         # Icon + Text
│
├── organisms/              # 유기체: 분자들의 조합, 독립적 섹션
│   ├── Header.tsx          # Logo + Navigation + SearchInput
│   ├── Sidebar.tsx         # NavLinks + UserProfile
│   ├── ProductList.tsx     # Cards 목록
│   └── Footer.tsx          # Links + Copyright
│
└── templates/              # 템플릿: 페이지 레이아웃 (콘텐츠 없음)
    ├── MainLayout.tsx      # Header + Sidebar + Content + Footer
    ├── AuthLayout.tsx      # 로그인/회원가입용 레이아웃
    └── DashboardLayout.tsx # 대시보드용 레이아웃
```

**네이밍 규칙**:
- atoms: 단일 기능 (`Button`, `Input`)
- molecules: 조합 기능 (`SearchInput`, `FormField`)
- organisms: 섹션명 (`Header`, `ProductList`)
- templates: `*Layout` 접미사

---

### 통합 구조 (클린 아키텍처 + Atomic Design)

```
src/
├── app/                    # Next.js App Router (페이지)
│   ├── (auth)/             # 인증 관련 라우트 그룹
│   ├── (dashboard)/        # 대시보드 라우트 그룹
│   └── layout.tsx
│
├── components/             # Atomic Design
│   ├── atoms/
│   ├── molecules/
│   ├── organisms/
│   └── templates/
│
├── domain/                 # 클린 아키텍처 - 도메인
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
├── application/            # 클린 아키텍처 - 애플리케이션
│   ├── services/
│   └── dto/
│
├── infrastructure/         # 클린 아키텍처 - 인프라
│   ├── api/
│   ├── repositories/
│   └── storage/
│
├── hooks/                  # 커스텀 훅
│   ├── useUser.ts
│   └── useProducts.ts
│
├── stores/                 # Zustand 스토어
│   ├── userStore.ts
│   └── cartStore.ts
│
├── lib/                    # 유틸리티
│   ├── utils.ts
│   └── constants.ts
│
└── types/                  # 타입 정의
    └── index.ts
```

---

## 9.8 기본 포함 사항

모든 생성 프로젝트에 자동 포함:

| 항목 | 내용 |
|------|------|
| Git 초기화 | `.git` 없으면 `git init` + `.gitignore` (있으면 스킵) |
| 첫 커밋 | "Initial project setup" (기존 Git 있으면 스킵) |
| README.md | 프로젝트 설명, 실행 방법, 구조 |
| .env.example | 환경변수 템플릿 |
| /mocks | 목업 데이터 폴더 |
| CLAUDE.md | Claude Code 설정 |
| .claude/ | Claude Code 폴더 (setup-claude-code 결과) |

---

## 9.9 프로젝트 유형별 템플릿

### 할일 관리 앱 (Todo)

```
필요 엔티티: Task, Category
필요 페이지: 홈(목록), 상세
필요 기능: CRUD, 필터링, 정렬
```

### 쇼핑몰 (E-commerce)

```
필요 엔티티: Product, Category, Cart, Order
필요 페이지: 홈, 상품목록, 상품상세, 장바구니, 결제
필요 기능: 상품 검색, 장바구니, (목업)결제
```

### 포트폴리오 (MBTI 기반)

```
필요 엔티티: Project, Skill, Experience, MBTITheme, ColorPalette
필요 페이지: MBTI 입력, 홈, 프로젝트, 스킬, 경험, 연락처
필요 기능:
  - MBTI 4글자 입력 → 성격에 맞는 테마 자동 생성
  - 같은 MBTI도 매번 다른 스타일 (시드 기반 랜덤)
  - 색상, 레이아웃, 폰트, 애니메이션 차별화
  - "다시 생성" 버튼으로 새로운 변형 제공
```

### 대시보드

```
필요 엔티티: 도메인별 데이터
필요 페이지: 대시보드, 상세, 설정
필요 기능: 차트, 테이블, 필터
```

---

## 9.10 에러 처리 메시지

### 폴더가 비어있지 않은 경우

```
앗, 이 폴더에 이미 파일이 있네요!

새 프로젝트를 만들려면 빈 폴더가 필요해요.
방법 1: 새 폴더 만들기 → mkdir my-project && cd my-project
방법 2: 다른 빈 폴더로 이동

준비되면 다시 /first-claude-code 해주세요!
```

### Node.js 미설치

```
Node.js가 설치되지 않았어요!

Node.js는 JavaScript를 실행하는 도구예요.
여기서 설치할 수 있어요: https://nodejs.org

설치 후 터미널을 다시 열고 /first-claude-code 해주세요!
```

### Git 미설치

```
Git이 설치되지 않았어요!

Git은 코드 버전을 관리하는 도구예요.
여기서 설치할 수 있어요: https://git-scm.com

설치 후 /first-claude-code 해주세요!
```

---

## 9.11 WebSearch 검색어 템플릿

최신 트렌드 조회 시 사용:

```
"best web framework 2026"
"Next.js 16 features 2026"
"React state management 2026"
"CSS framework trends 2026"
"shadcn/ui alternatives 2026"
```
