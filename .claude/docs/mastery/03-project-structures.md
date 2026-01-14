# 3. 프로젝트 구조별 가이드

> 이 문서는 [CLAUDE-CODE-MASTERY.md](../CLAUDE-CODE-MASTERY.md)의 일부입니다.

---

## 3.1 프로젝트 구조 감지

| 구조 | 감지 방법 |
|------|----------|
| 모노레포 | `pnpm-workspace.yaml`, `turbo.json`, `lerna.json`, `nx.json`, `rush.json` |
| 마이크로서비스 | `docker-compose.yml` + 여러 서비스 폴더 |
| 단일 앱 | 단일 `package.json` 또는 설정 파일 |
| 라이브러리 | `lib/`, `src/` 구조 + 배포 설정 |
| 풀스택 | `frontend/`, `backend/` 또는 `client/`, `server/` |

---

## 3.2 모노레포

**특징**: 여러 패키지가 하나의 저장소에 존재

### 빌드 도구 (선택)

| 도구 | 설치 | 특징 |
|------|------|------|
| **Turborepo** | `npx create-turbo@latest` | 빠른 캐싱, 간단한 설정 |
| **Nx** | `npx create-nx-workspace` | 종합 프레임워크, 플러그인 생태계 |
| **Rush** | `npm install -g @microsoft/rush` | 엔터프라이즈급, 정책 관리 |

> **권장**: pnpm workspaces + Turborepo 조합이 2025년 가장 인기

**권장 설정**:

```markdown
<!-- CLAUDE.md -->
# Monorepo 개발 워크플로우

## 패키지 관리
- pnpm workspace / npm workspaces / yarn workspaces
- `pnpm --filter {package} {command}` 형식

## 개발 순서
pnpm -r typecheck        # 전체 타입체크
pnpm --filter {pkg} test # 패키지별 테스트
pnpm -r build            # 전체 빌드

## 구조
packages/
├── core/          # 공통 유틸리티
├── ui/            # UI 컴포넌트
├── api/           # API 클라이언트
└── app/           # 메인 앱
```

**Skills 권장**:
- `{project}-core`: 공통 레이어
- `{project}-{domain}`: 각 도메인별

---

## 3.3 마이크로서비스

**특징**: 독립적인 서비스들이 컨테이너로 실행

### Docker Compose 베스트 프랙티스 (2025)

- `version:` 필드 불필요 (직접 `services:` 시작)
- `docker compose watch` 로 라이브 리로드
- healthcheck 추가로 서비스 상태 관리
- 비-root 사용자로 보안 강화

**docker-compose.yml 예시**:

```yaml
# version 필드 불필요 (obsolete)
services:
  api:
    build: ./api
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

**권장 설정**:

```markdown
<!-- CLAUDE.md -->
# Microservices 개발 워크플로우

## 서비스 관리
- Docker Compose로 로컬 개발
- 각 서비스는 독립적으로 빌드/배포

## 개발 순서
docker compose watch     # 라이브 리로드 (권장)
docker compose up -d     # 백그라운드 실행
docker compose logs -f   # 로그 확인
docker compose down      # 서비스 중지

## 구조
services/
├── auth/          # 인증 서비스
├── user/          # 사용자 서비스
├── order/         # 주문 서비스
└── gateway/       # API Gateway
```

**Skills 권장**:
- `{project}-architecture`: 전체 아키텍처
- `{project}-{service}`: 각 서비스별

---

## 3.4 단일 앱

**특징**: 하나의 애플리케이션

**권장 설정**:

```markdown
<!-- CLAUDE.md -->
# 개발 워크플로우

## 구조
src/
├── components/    # UI 컴포넌트
├── hooks/         # 커스텀 훅
├── lib/           # 유틸리티
├── pages/         # 페이지 (또는 routes/)
└── styles/        # 스타일
```

**최소 설정으로 시작**:
- CLAUDE.md
- settings.local.json (훅)
- 2-3개 커맨드

---

## 3.5 풀스택 앱

**특징**: 프론트엔드 + 백엔드가 함께

**권장 설정**:

```markdown
<!-- CLAUDE.md -->
# Fullstack 개발 워크플로우

## 구조
frontend/          # React/Vue/Angular
├── src/
└── package.json

backend/           # Node/Python/Go
├── src/
└── package.json (또는 해당 언어 설정)

## 개발 순서
# 백엔드 먼저
cd backend && npm run dev

# 프론트엔드
cd frontend && npm run dev
```

**Skills 권장**:
- `{project}-frontend`: 프론트엔드 규칙
- `{project}-backend`: 백엔드 규칙
- `{project}-api`: API 규약