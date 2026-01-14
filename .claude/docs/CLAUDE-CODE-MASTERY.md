# Claude Code Mastery Guide

> **목적**: Claude Code가 이 문서를 읽고 **어떤 프로젝트에서든** 최적의 설정을 생성하고 교육할 수 있도록 하는 범용 마스터 가이드
>
> **버전**: 1.0.0
> **최종 수정**: 2026-01-04
> **원천**: Boris Cherny의 13가지 팁 + [공식 문서](https://code.claude.com/docs) + 실전 패턴 분석

---

## 왜 이 문서가 필요한가?

### 문제 인식

Claude Code를 사용하다 보면 다음과 같은 문제에 직면합니다:

1. **세션 단절 문제**: 새로운 세션을 시작하면 이전 세션의 컨텍스트가 사라짐
2. **일관성 부재**: 같은 작업을 요청해도 매번 다른 결과물
3. **지식 휘발**: 배운 규칙이나 패턴이 세션마다 리셋됨
4. **교육의 반복**: 매번 같은 설명을 반복해야 함
5. **설정의 파편화**: 팀원마다 다른 방식으로 Claude Code 사용

### 해결 방안

**"문서화된 지식은 세션을 초월한다"**

- CLAUDE.md에 규칙을 기록하면 모든 세션에서 동일하게 적용
- Commands/Agents/Skills로 워크플로우 표준화
- 이 마스터 가이드로 Claude Code가 스스로 교육/설정 생성 가능

### 이 문서가 해결하는 것

| 문제 | 해결책 |
|------|--------|
| Claude Code가 뭔지 모름 | /first-claude-code 쇼케이스 |
| 세션마다 컨텍스트 리셋 | CLAUDE.md로 영구 저장 |
| 반복적인 교육 | /learn-claude-code 커맨드 |
| 프로젝트마다 수동 설정 | /setup-claude-code 자동 생성 |
| 최신 트렌드 파악 어려움 | /upgrade-claude-code 트렌드 분석 |
| 팀 지식 축적 안 됨 | PR 자동 문서화 (GitHub Action) |

---

## 이 문서의 사용 방법

### Claude Code에게

이 문서를 읽으면 **어떤 프로젝트에서든** 다음을 수행할 수 있습니다:

1. **설정 생성**: 프로젝트 분석 → 언어/구조에 맞는 `.claude/` 생성
2. **교육 제공**: 사용자 레벨에 맞는 학습 콘텐츠 제공
3. **최신 트렌드 분석**: WebSearch를 통해 최신 사용법 조사
4. **베스트 프랙티스 적용**: Boris Cherny의 팁 기반 최적화

### 사용자에게

```bash
# 슬래시 커맨드로 실행
/first-claude-code          # 완전 초보자용 첫 프로젝트 생성
/learn-claude-code          # 교육 + 설정 가이드
/setup-claude-code          # 프로젝트 설정 생성
/upgrade-claude-code        # 최신 트렌드로 업그레이드
```

---

## 목차

상세 내용은 `mastery/` 폴더의 개별 문서를 참조하세요.

### [핵심 개념 (본 문서)](#핵심-개념)
- Claude Code 설정의 목표
- Boris의 13가지 핵심 원칙
- 설정 파일 구조

### [1. 설정 요소별 상세 가이드](mastery/01-settings-guide.md)
- CLAUDE.md (필수)
- Commands (권장)
- Agents/서브에이전트 (권장)
- Skills (선택, 대규모 프로젝트 권장)
- Hooks (권장)
- MCP (선택)
- GitHub Action (선택)

### [2. 언어/프레임워크별 템플릿](mastery/02-language-templates.md)
- TypeScript/JavaScript (npm, pnpm, Bun, Deno)
- Python (Poetry, pip, uv)
- Go, Rust, Java, C#, Ruby, PHP
- Flutter/Dart, Swift, Kotlin

### [3. 프로젝트 구조별 가이드](mastery/03-project-structures.md)
- 모노레포
- 마이크로서비스
- 단일 앱
- 풀스택 앱

### [4. 교육 커리큘럼](mastery/04-curriculum.md)
- 레벨 1: 기초 (15분)
- 레벨 2: 자동화 (30분)
- 레벨 3: 전문화 (45분)
- 레벨 4: 팀 최적화 (1시간)

### [5. 최신 트렌드 분석 및 실행 워크플로우](mastery/05-advanced.md)
- 최신 트렌드 분석 방법
- 실행 워크플로우 (/learn, /setup, /upgrade)

### [6. Plugins (플러그인)](mastery/06-plugins.md)
- 플러그인 구조
- plugin.json 매니페스트
- 설치 및 개발

### [7. Output Styles (출력 스타일)](mastery/07-output-styles.md)
- 기본 제공 스타일
- 커스텀 스타일 정의

### [8. Programmatic Usage (프로그래매틱 사용)](mastery/08-programmatic.md)
- CLI SDK
- CI/CD 통합
- 스크립트 자동화

### [9. 웹 프로젝트 생성 가이드](mastery/09-web-project-guide.md)
- 프론트엔드 프레임워크 (2026 트렌드)
- 스타일링, 상태관리, 폼 & 검증
- 목업 데이터 전략
- 배포 옵션
- 아키텍처 패턴 (클린 아키텍처 + Atomic Design)
- 프로젝트 유형별 템플릿

---

## 핵심 개념

### Claude Code 설정의 목표

```
┌─────────────────────────────────────────────────────────────┐
│                    Claude Code 최적화 목표                    │
├─────────────────────────────────────────────────────────────┤
│  1. 반복 작업 자동화     → Commands, Hooks                   │
│  2. 컨텍스트 최적화      → Skills, CLAUDE.md                 │
│  3. 품질 보장            → Agents, 검증 루프                  │
│  4. 팀 지식 축적         → Instructions, Git 관리            │
│  5. 외부 도구 통합       → MCP 연결                          │
└─────────────────────────────────────────────────────────────┘
```

### Boris의 13가지 핵심 원칙

| # | 원칙 | 구현 방법 | 적용 언어 |
|---|------|----------|----------|
| 1 | 병렬 작업 | 여러 세션 동시 사용 | 모든 언어 |
| 2 | Web + Mobile 세션 | 모바일에서 시작, 데스크톱에서 마무리 | 모든 언어 |
| 3 | Opus 4.5 우선 | 첫 시도 정확성 > 속도 | 모든 언어 |
| 4 | CLAUDE.md 활용 | 팀 지식 저장소 | 모든 언어 |
| 5 | PR 문서 자동화 | GitHub Action (@.claude 태깅) | 모든 언어 |
| 6 | Plan Mode 우선 | 계획 → 실행 | 모든 언어 |
| 7 | 슬래시 커맨드 | 반복 작업 자동화 | 모든 언어 |
| 8 | 서브 에이전트 | 작업 전문화 | 모든 언어 |
| 9 | PostToolUse 훅 | 포맷팅 자동화 | 언어별 도구 |
| 10 | 권한 화이트리스트 | 보안과 편의 균형 | 언어별 명령어 |
| 11 | MCP 연결 | 외부 도구 통합 | 모든 언어 |
| 12 | 백그라운드 실행 | 긴 작업 비동기 처리 | 모든 언어 |
| 13 | 검증 수단 제공 | 피드백 루프 | 언어별 테스트 |

### 설정 파일 구조 (범용)

```
project/
├── CLAUDE.md                          # 루트: 개발 워크플로우
├── .mcp.json                          # MCP 서버 설정
├── .claude/
│   ├── settings.local.json            # 권한 + 훅 설정
│   ├── commands/                      # 슬래시 커맨드
│   │   ├── commit-push-pr.md
│   │   └── ...
│   ├── agents/                        # 서브 에이전트
│   │   ├── build-validator.md
│   │   └── ...
│   ├── skills/                        # 도메인별 전문 컨텍스트
│   │   └── {skill-name}/SKILL.md
│   ├── docs/                          # 문서 (이 파일 포함)
│   │   ├── CLAUDE-CODE-MASTERY.md     # 마스터 가이드 (목차)
│   │   └── mastery/                   # 상세 가이드
│   │       ├── 01-settings-guide.md
│   │       ├── 02-language-templates.md
│   │       ├── 03-project-structures.md
│   │       ├── 04-curriculum.md
│   │       ├── 05-advanced.md
│   │       ├── 06-plugins.md
│   │       ├── 07-output-styles.md
│   │       ├── 08-programmatic.md
│   │       └── 09-web-project-guide.md
│   └── instructions/                  # 프로젝트 규칙 (선택)
│       ├── coding-conventions.md
│       └── ...
└── .github/
    └── workflows/
        └── claude-docs-update.yml     # PR 자동 문서화
```

---

## 부록

### A. 트러블슈팅

| 문제 | 해결 방법 |
|------|----------|
| 훅이 실행 안 됨 | `settings.local.json` 경로 확인 |
| 커맨드 인식 안 됨 | `.md` 확장자, 파일명 확인 |
| 권한 거부됨 | `permissions.allow`에 패턴 추가 |
| MCP 연결 실패 | `.mcp.json` 문법 검증 |

### B. 참고 링크

- Claude Code 공식 문서: https://code.claude.com/docs
- MCP 서버 목록: https://github.com/modelcontextprotocol/servers
- MCP Registry: https://registry.modelcontextprotocol.io/

### C. 버전 히스토리

| 버전 | 날짜 | 변경 내용 |
|------|------|----------|
| 1.0.0 | 2026-01-04 | 초기 버전 |

---

## Claude Code를 위한 실행 지침

이 문서를 읽은 Claude Code는 **어떤 프로젝트에서든** 다음을 수행해야 합니다:

1. **첫 프로젝트 생성 요청 시** (`/first-claude-code`):
   - 이 문서와 `mastery/09-web-project-guide.md` 먼저 읽기
   - 완전 초보자 대상 쇼케이스 경험 제공
   - 임시 폴더에서 프로젝트 생성 후 현재 폴더로 복사
   - 클린 아키텍처 + Atomic Design 적용
   - `/setup-claude-code`, `/upgrade-claude-code` 자동 실행

2. **교육 요청 시** (`/learn-claude-code`):
   - 이 문서 먼저 읽기
   - 필요한 상세 내용은 `mastery/` 폴더에서 참조
   - 현재 설정 분석
   - 적합한 레벨의 교육 콘텐츠 제공
   - 실습 가이드 제시

3. **설정 생성 요청 시** (`/setup-claude-code`):
   - 이 문서 먼저 읽기
   - `mastery/01-settings-guide.md`와 `mastery/02-language-templates.md` 참조
   - 프로젝트 분석 (언어, 패키지 매니저, 구조)
   - 해당 언어/구조에 맞는 템플릿 선택
   - 파일 생성 및 결과 요약

4. **업그레이드 요청 시** (`/upgrade-claude-code`):
   - 이 문서 먼저 읽기
   - `mastery/05-advanced.md` 참조
   - 현재 설정 분석
   - WebSearch로 최신 트렌드 조사
   - 개선점 제안 및 적용

5. **일반 질문 시**:
   - 이 문서를 참조하여 정확한 답변 제공
   - 필요시 `mastery/` 폴더의 상세 문서 참조
   - 프로젝트 언어에 맞는 예시 사용