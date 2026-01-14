# 1. 설정 요소별 상세 가이드

> 이 문서는 [CLAUDE-CODE-MASTERY.md](../CLAUDE-CODE-MASTERY.md)의 일부입니다.

---

## 1.1 CLAUDE.md (필수)

**목적**: 프로젝트의 핵심 규칙과 워크플로우 정의

**위치**: 프로젝트 루트 `/CLAUDE.md`

**생성 방법**:

```bash
# Claude Code가 프로젝트를 분석하여 CLAUDE.md 자동 생성
claude init
```

`claude init`은 프로젝트의 package.json, 설정 파일 등을 분석하여 적절한 CLAUDE.md를 생성합니다. 이것이 권장 방법입니다.

**권장 섹션 (참고용)**:

| 섹션 | 목적 |
|------|------|
| 프로젝트 개요 | 프로젝트가 무엇인지 |
| 기술 스택 | 언어, 프레임워크, DB |
| 패키지 관리 | 패키지 매니저, 명령어 |
| 프로젝트 구조 | 폴더 구조와 역할 |
| 개발 워크플로우 | 작업 순서 |
| 코딩 컨벤션 | 스타일 가이드 |
| 테스트 규칙 | 테스트 방법 |
| 금지 사항 | 하지 말아야 할 것들 |

**작성 원칙**:
- 실수할 때마다 규칙 추가 (점진적 개선)
- 구체적인 명령어/코드 예시 포함
- `✅ 해야 할 것` / `❌ 하지 말 것` 명확히 구분

---

## 1.2 Commands (권장)

**목적**: 반복 작업 자동화

**위치**: `.claude/commands/{command-name}.md`

### YAML Frontmatter 옵션

| 필드 | 설명 |
|------|------|
| `description` | 커맨드 설명 |
| `allowed-tools` | 허용할 도구 (예: `Bash(git:*), Read`) |
| `argument-hint` | 인자 힌트 (예: `[message]`) |
| `model` | 사용할 모델 (`sonnet`, `opus`, `haiku`) |
| `hooks` | 커맨드 실행 중 훅 (PreToolUse, PostToolUse, Stop) |

### 범용 템플릿

```markdown
---
description: 커밋 메시지 생성
allowed-tools: Bash(git:*)
argument-hint: [message]
---

# {Command 이름}

{한 줄 설명}

## 사용법

/{command-name} [인자]

$ARGUMENTS를 사용하면 커맨드 호출 시 인자를 받을 수 있습니다.
예: `/commit fix typo` → $ARGUMENTS = "fix typo"

## 수행 작업

### 1단계: {작업명}
{상세 설명 또는 명령어}

### 2단계: {작업명}
{상세 설명}

## 결과 출력

✅ {완료 메시지}
**{항목}**: {값}
```

**범용 권장 커맨드**:

| 커맨드 | 용도 | 모든 프로젝트 |
|--------|------|--------------|
| `/commit-push-pr` | 커밋 → 푸시 → PR 생성 | ✅ |
| `/typecheck` | 타입 검사 | 타입 언어만 |
| `/test` | 테스트 실행 | ✅ |
| `/lint-fix` | 린트 자동 수정 | ✅ |
| `/build` | 빌드 | ✅ |
| `/format` | 코드 포맷팅 | ✅ |

---

## 1.3 Agents (서브에이전트) (권장)

**목적**: 특정 작업 전문화

**위치**: `.claude/agents/{agent-name}.md`

### YAML Frontmatter 옵션 (공식 스펙)

| 필드 | 필수 | 타입 | 기본값 | 설명 |
|------|:----:|------|--------|------|
| `name` | ✓ | String | — | 고유 식별자 (소문자, 하이픈) |
| `description` | ✓ | String | — | 역할 설명 (자동 위임 시 매칭에 사용) |
| `tools` | | CSV | 전체 상속 | 허용 도구 (쉼표 구분) |
| `model` | | String | `sonnet` | 모델: `sonnet`, `opus`, `haiku`, `inherit` |
| `permissionMode` | | String | `default` | 권한 처리 모드 |
| `skills` | | CSV | 없음 | 자동 로드할 스킬 (쉼표 구분) |

### 에이전트 위치 및 우선순위

| 타입 | 위치 | 범위 | 우선순위 |
|------|------|------|:--------:|
| Project | `.claude/agents/` | 현재 프로젝트 | 최상 |
| CLI-defined | `--agents` 플래그 | 세션 | 상 |
| Plugin | 플러그인 내 `agents/` | 플러그인 | 중 |
| User | `~/.claude/agents/` | 모든 프로젝트 | 하 |

### Permission Mode 옵션

| 모드 | 설명 |
|------|------|
| `default` | 기본 권한 요청 |
| `acceptEdits` | 파일 편집 자동 승인 |
| `bypassPermissions` | 권한 완전 우회 (주의: 안전한 환경에서만) |
| `plan` | 계획 모드 - 분석만 가능, 수정/실행 불가 |

### 에이전트 호출 방식

**1. 자동 위임** (description 기반)

```yaml
# description에 "PROACTIVELY" 또는 "MUST BE USED" 포함 시 자동 호출 권장
description: Expert code reviewer. Use PROACTIVELY after code changes.
```

**2. 명시적 호출**

```
> Use the test-runner subagent to fix failing tests
> Have the code-reviewer subagent look at my recent changes
> Ask the debugger subagent to investigate this error
```

**3. CLI 기반 정의**

```bash
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer. Use proactively after code changes.",
    "prompt": "You are a senior code reviewer...",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "sonnet"
  }
}'
```

**4. 에이전트 재개**

```
> Resume agent abc123 and now analyze the authorization logic as well
```

에이전트는 고유 `agentId`를 가지며, 대화는 `agent-{agentId}.jsonl`에 저장됨

### 빌트인 서브에이전트

| 에이전트 | 모델 | 도구 | 용도 |
|----------|------|------|------|
| **General-purpose** | Sonnet | 전체 | 복잡한 멀티스텝 작업 |
| **Plan** | Sonnet | Read, Glob, Grep, Bash | 코드베이스 탐색, 리서치 |
| **Explore** | Haiku | Glob, Grep, Read, Bash (읽기전용) | 빠른 코드베이스 검색 |

**Explore 철저도 레벨**: `Quick`, `Medium`, `Very thorough`

### 범용 템플릿

```yaml
---
name: {agent-name}
description: {역할 설명}. Use PROACTIVELY when {트리거 상황}.
tools: Read, Grep, Glob, Bash
model: sonnet
skills: {관련-스킬}
---

# {Agent 이름}

{상세 시스템 프롬프트}

## 수행 작업
1. {작업 1}
2. {작업 2}

## 성공 기준
- {기준 1}
- {기준 2}
```

### 범용 권장 에이전트

| 에이전트 | 역할 | 모든 프로젝트 |
|----------|------|:------------:|
| `build-validator` | 빌드 검증 | ✅ |
| `code-reviewer` | 코드 리뷰 | ✅ |
| `test-runner` | 테스트 실행 분석 | ✅ |
| `security-scanner` | 보안 취약점 검사 | ✅ |
| `debugger` | 에러 분석/근본 원인 | ✅ |
| `api-doc-generator` | API 문서 생성 | 백엔드 |
| `verify-app` | E2E 테스트 | 프론트엔드 |

### 에이전트 관리 명령어

```bash
/agents  # 대화형 메뉴 열기
         # - 에이전트 목록 조회
         # - 새 에이전트 생성
         # - 기존 에이전트 편집/삭제
         # - 도구 권한 관리
```

### 주요 제약사항

- **컨텍스트 분리**: 각 서브에이전트는 별도 컨텍스트에서 실행
- **중첩 불가**: 서브에이전트는 다른 서브에이전트 생성 불가
- **스킬 미상속**: 부모 대화의 스킬 자동 상속 안 함 (명시적 `skills` 필요)
- **충돌 해결**: 프로젝트 레벨이 사용자 레벨보다 우선

---

## 1.4 Skills (선택, 대규모 프로젝트 권장)

**목적**: 도메인별 전문 컨텍스트 제공

**위치**: `.claude/skills/{skill-name}/SKILL.md`

### YAML Frontmatter 옵션 (공식 스펙)

| 필드 | 필수 | 설명 | 제약 |
|------|:----:|------|------|
| `name` | ✓ | 스킬 이름 | 소문자, 숫자, 하이픈만 (최대 64자), 폴더명과 일치 권장 |
| `description` | ✓ | 스킬 용도 및 활성화 시점 | **최대 1024자**, Claude가 시맨틱 매칭에 사용 |
| `allowed-tools` | | 활성화 시 허용 도구 | 쉼표 구분 (예: `Read, Grep, Glob`) |
| `model` | | 스킬 활성화 시 사용 모델 | 예: `claude-sonnet-4-20250514` |

### 스킬 매칭 및 활성화 과정

```
1. Discovery (시작 시)
   └── 각 스킬의 name, description만 로드

2. Activation (요청 매칭)
   └── 사용자 요청과 description 시맨틱 유사도 비교
   └── 매칭 시 "스킬 사용 요청"

3. Execution (활성화)
   └── 전체 SKILL.md 컨텍스트에 로드
   └── 참조 파일 필요시 로드
```

**중요**: `description`에 트리거 키워드 포함 필수!

```yaml
# ✅ 좋은 예: 구체적인 키워드 포함
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files, forms, or document extraction.

# ❌ 나쁜 예: 모호함
description: Helps with documents
```

### 스킬 위치 및 우선순위

| 위치 | 경로 | 적용 범위 | 우선순위 |
|------|------|----------|:--------:|
| Enterprise | managed settings | 조직 전체 | 1 (최상) |
| Personal | `~/.claude/skills/` | 개인, 모든 프로젝트 | 2 |
| Project | `.claude/skills/` | 팀, 저장소 | 3 |
| Plugin | 플러그인 내 | 플러그인 사용자 | 4 (최하) |

**우선순위 규칙**: 동일 이름의 스킬은 높은 우선순위가 우선

### Progressive Disclosure 패턴

`SKILL.md`는 **500줄 이하** 유지:

```
my-skill/
├── SKILL.md           # 필수 - 개요 및 네비게이션
├── reference.md       # 상세 문서 (필요시 로드)
├── examples.md        # 사용 예시
└── scripts/
    └── validate.py    # 유틸리티 스크립트
```

**핵심 원칙**:
- 마크다운 링크로 지원 파일 참조
- 참조는 1단계만 (A→B ✓, A→B→C ✗)
- 스크립트는 **실행**하도록 지시 (읽기 X)

```markdown
# SKILL.md에서 스크립트 실행 지시
폼 검증을 위해 다음 스크립트를 실행하세요:
```bash
python scripts/validate_form.py input.pdf
```
```

### 서브에이전트에서 스킬 사용

서브에이전트는 스킬을 **자동 상속하지 않음**. `skills` 필드로 명시적 부여:

```yaml
# .claude/agents/code-reviewer.md
---
name: code-reviewer
description: 코드 품질 및 보안 검토
skills: pr-review, security-check
---
```

**참고**: 빌트인 에이전트(Explore, Plan, Verify)와 Task 도구는 스킬 접근 불가

### 범용 템플릿

```yaml
---
name: {project}-{domain}
description: {구체적인 기능 설명}. Use when {트리거 키워드 나열}.
allowed-tools: Read, Grep, Glob
---

# {제목}

## Quick Start
[빠른 시작 예시]

## 핵심 규칙
[반드시 따라야 할 규칙]

상세 문서: [REFERENCE.md](REFERENCE.md)
사용 예시: [EXAMPLES.md](EXAMPLES.md)
```

### 스킬 생성 전략: 하이브리드 방식

**1단계: 공통 스킬** (모든 프로젝트)

| 스킬 | 용도 |
|------|------|
| `{project}-architecture` | 전체 아키텍처, 폴더 구조, 의존성 방향 |
| `{project}-testing` | 테스트 패턴, 단위/통합 테스트, 실행 방법 |

**2단계: 프로젝트 유형별 스킬** (구조 분석 후 제안)

| 프로젝트 유형 | 감지 조건 | 제안 스킬 |
|--------------|----------|----------|
| **Hexagonal/DDD** | `modules/`, `domains/` | `{project}-{domain}`, `{project}-database`, `{project}-validation` |
| **모노레포** | `packages/`, `apps/` | `{project}-{package}`, `{project}-shared` |
| **프론트엔드** | `components/`, `pages/` | `{project}-components`, `{project}-routing`, `{project}-state` |
| **MVC 백엔드** | `controllers/`, `routes/` | `{project}-controllers`, `{project}-models`, `{project}-middleware` |
| **마이크로서비스** | `services/` | `{project}-{service}`, `{project}-messaging`, `{project}-deployment` |
| **라이브러리** | `src/` only | `{project}-api`, `{project}-examples` |

**3단계: 기술 스택별 스킬** (의존성 분석)

| 감지 조건 | 제안 스킬 |
|----------|----------|
| MongoDB (mongoose) | `{project}-database` |
| Fastify/Express | `{project}-api-conventions` |
| Zod | `{project}-validation` |
| Redis | `{project}-cache` |
| GraphQL | `{project}-graphql` |
| Docker | `{project}-deployment` |

**범용 유틸리티 스킬**:

| 스킬 | 용도 |
|------|------|
| `explaining-code` | 코드 설명 (다이어그램 생성) |
| `commit-messages` | 커밋 메시지 생성 |
| `pdf-processing` | PDF 파일 처리 |

---

## 1.5 Hooks (settings.local.json) (권장)

**목적**: 도구 실행 전후 자동화, 권한 관리

**위치**: `.claude/settings.local.json`

### 모든 훅 이벤트 (공식 스펙)

| 훅 이벤트 | 실행 시점 | Matcher | 주요 용도 |
|-----------|----------|:-------:|----------|
| **PreToolUse** | 도구 실행 전 | ✅ | 승인/거부, 입력 검증/수정 |
| **PermissionRequest** | 권한 대화 표시 시 | ✅ | 자동 승인/거부, 입력 수정 |
| **PostToolUse** | 도구 실행 후 | ✅ | 포맷팅, 린트, 로깅 |
| **Notification** | 알림 발생 시 | ✅ | 커스텀 알림 |
| **UserPromptSubmit** | 프롬프트 제출 시 | ❌ | 컨텍스트 주입, 검증 |
| **Stop** | Claude 응답 완료 시 | ❌ | 지능형 계속 실행 결정 |
| **SubagentStop** | 서브에이전트 완료 시 | ❌ | 작업 완료 검증 |
| **PreCompact** | 대화 압축 전 | ✅ | 압축 전 설정 |
| **SessionStart** | 세션 시작 시 | ✅ | 환경 변수, 컨텍스트 로드 |
| **SessionEnd** | 세션 종료 시 | ❌ | 정리, 로깅 |

> **Note**: SessionStart, SessionEnd, Notification은 TypeScript SDK에서만 사용 가능. Python SDK는 미지원.

**Notification matcher**: `permission_prompt`, `idle_prompt` (60초 대기 후), `auth_success`, `elicitation_dialog`
**SessionStart matcher**: `startup`, `resume`, `clear`, `compact`
**PreCompact matcher**: `manual`, `auto`

### 훅 설정 구조

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolPattern",
        "hooks": [
          {
            "type": "command",
            "command": "bash-command",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

### Matcher 패턴

| 패턴 | 설명 | 예시 |
|------|------|------|
| 정확 매칭 | 특정 도구만 | `Write` |
| 정규식 | OR 패턴 | `Edit\|Write` |
| 와일드카드 | 전체 매칭 | `*` 또는 `""` |
| MCP 도구 | MCP 서버 도구 | `mcp__memory__.*` |

### 훅 타입

**1. Command 훅** (`type: "command"`)

```json
{
  "type": "command",
  "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/validate.sh",
  "timeout": 60
}
```

**2. Prompt 훅** (`type: "prompt"`)

`Stop`, `SubagentStop`, `UserPromptSubmit`, `PreToolUse`, `PermissionRequest`에서 사용:

```json
{
  "type": "prompt",
  "prompt": "Evaluate if Claude should stop: $ARGUMENTS\n\nRespond with JSON: {\"decision\": \"approve\" or \"block\", \"reason\": \"explanation\"}",
  "timeout": 30
}
```

### 환경 변수

| 변수 | 설명 |
|------|------|
| `$CLAUDE_PROJECT_DIR` | 프로젝트 루트 절대 경로 |
| `$CLAUDE_CODE_REMOTE` | 웹이면 `"true"`, CLI면 비어있음 |
| `$CLAUDE_ENV_FILE` | 환경 변수 저장 파일 경로 (SessionStart) |
| `${CLAUDE_PLUGIN_ROOT}` | 플러그인 디렉토리 |

### 훅 입력 (JSON via stdin)

**공통 필드**:

```json
{
  "session_id": "string",
  "transcript_path": "string",
  "cwd": "string",
  "permission_mode": "default|plan|acceptEdits|dontAsk|bypassPermissions",
  "hook_event_name": "string"
}
```

**이벤트별 추가 필드**:

| 이벤트 | 추가 필드 |
|--------|----------|
| PreToolUse | `tool_name`, `tool_input`, `tool_use_id` |
| PostToolUse | `tool_name`, `tool_input`, `tool_response`, `tool_use_id` |
| UserPromptSubmit | `prompt` |
| Stop/SubagentStop | `stop_hook_active` |
| SessionStart | `source` (startup/resume/clear/compact) |
| SessionEnd | `reason` (clear/logout/prompt_input_exit/other) |
| Notification | `message`, `notification_type` |
| PreCompact | `trigger` (manual/auto), `custom_instructions` |

### 훅 출력

**Exit Code**:

| Code | 동작 | 사용 |
|:----:|------|------|
| 0 | 성공 - stdout/JSON 처리 | 정상 작업 |
| 2 | 차단 - stderr 표시 | 작업 차단, 에러 표시 |
| 기타 | 비차단 경고 | verbose 모드에서 표시 |

**JSON 출력** (exit 0일 때만):

```json
{
  "continue": true,
  "stopReason": "continue=false일 때 메시지",
  "suppressOutput": false,
  "systemMessage": "사용자에게 표시할 경고"
}
```

### 이벤트별 Decision Control

**PreToolUse**:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow|deny|ask",
    "permissionDecisionReason": "설명",
    "updatedInput": { "field": "수정값" }
  }
}
```

**PermissionRequest**:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PermissionRequest",
    "decision": {
      "behavior": "allow|deny",
      "updatedInput": {},
      "message": "거부 이유",
      "interrupt": false
    }
  }
}
```

**Stop/SubagentStop**:

```json
{
  "decision": "block",
  "reason": "Claude가 계속 작업해야 하는 이유"
}
```

### 실용적인 훅 예시

**1. 파일 쓰기 포맷팅**:

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "npx prettier --write \"$(cat | jq -r '.tool_input.file_path')\" 2>/dev/null || true"
      }]
    }]
  }
}
```

**2. .env 파일 보호**:

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "python3 -c \"import json,sys; d=json.load(sys.stdin); p=d.get('tool_input',{}).get('file_path',''); sys.exit(2 if '.env' in p or 'secret' in p.lower() else 0)\""
      }]
    }]
  }
}
```

**3. 세션 시작 환경 설정**:

```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "startup",
      "hooks": [{
        "type": "command",
        "command": "if [ -n \"$CLAUDE_ENV_FILE\" ]; then echo 'export NODE_ENV=development' >> \"$CLAUDE_ENV_FILE\"; fi"
      }]
    }]
  }
}
```

**4. 지능형 Stop 훅** (Prompt 타입):

```json
{
  "hooks": {
    "Stop": [{
      "hooks": [{
        "type": "prompt",
        "prompt": "작업 완료 여부 평가:\n1. 모든 사용자 요청 완료?\n2. 수정할 에러 있음?\n3. 후속 작업 필요?\n\nJSON 응답: {\"decision\": \"approve\" or \"block\", \"reason\": \"설명\"}"
      }]
    }]
  }
}
```

### 권한 설정

```json
{
  "permissions": {
    "allow": [
      "Bash({PACKAGE_MANAGER}:*)",
      "Bash({BUILD_COMMAND}:*)",
      "Bash({TEST_COMMAND}:*)"
    ],
    "deny": [],
    "ask": []
  }
}
```

---

## 1.6 MCP (Model Context Protocol) (선택)

**목적**: 외부 도구 통합 (Slack, GitHub, Jira 등)

### 파일 위치 및 스코프

| 스코프 | 위치 | 용도 |
|--------|------|------|
| **Project** | `.mcp.json` (프로젝트 루트) | 팀 공유, 버전 관리 포함 |
| **Local** | `~/.claude.json` (프로젝트 하위) | 개인 개발, 민감한 자격증명 |
| **User** | `~/.claude.json` (글로벌) | 모든 프로젝트 접근 |
| **Enterprise** | `/Library/Application Support/ClaudeCode/managed-mcp.json` | 조직 전체 |

**스코프 우선순위**: Local > Project > User

### 서버 타입

**1. HTTP 서버** (권장)

```bash
claude mcp add --transport http stripe https://mcp.stripe.com

# Bearer 토큰 포함
claude mcp add --transport http api https://api.example.com/mcp \
  --header "Authorization: Bearer your-token"
```

**2. SSE 서버** (Server-Sent Events)

```bash
claude mcp add --transport sse asana https://mcp.asana.com/sse \
  --header "X-API-Key: your-key"
```

**3. Stdio 서버** (로컬)

```bash
claude mcp add --transport stdio airtable \
  --env AIRTABLE_API_KEY=YOUR_KEY \
  -- npx -y airtable-mcp-server

# Windows: cmd /c 래퍼 필수
claude mcp add --transport stdio my-server -- cmd /c npx -y @some/package
```

**`--` 파라미터**: `--` 이전은 CLI 옵션, 이후는 MCP 서버 명령어

### .mcp.json 구조

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/"
    },
    "database": {
      "type": "stdio",
      "command": "/usr/local/bin/db-server",
      "args": ["--config", "/etc/config.json"],
      "env": {
        "DB_URL": "${DB_URL}",
        "CACHE_DIR": "/tmp"
      }
    },
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}"
      }
    }
  }
}
```

### 환경 변수 문법

| 문법 | 설명 |
|------|------|
| `${VAR}` | 환경 변수 직접 참조 |
| `${VAR:-default}` | 미설정 시 기본값 |
| `${CLAUDE_PLUGIN_ROOT}` | 플러그인 루트 경로 |

### 주요 CLI 명령어

```bash
# 서버 추가
claude mcp add --transport <type> <name> <url/command>
claude mcp add --transport http github --scope project https://mcp.github.com

# JSON으로 추가
claude mcp add-json <name> '<json>'

# Claude Desktop에서 가져오기
claude mcp add-from-claude-desktop

# 목록/상세/제거
claude mcp list
claude mcp get <name>
claude mcp remove <name>

# OAuth 인증 (Claude Code 내에서)
/mcp

# 프로젝트 승인 초기화
claude mcp reset-project-choices
```

### MCP 리소스 및 프롬프트 사용

```bash
# @ 멘션으로 리소스 참조
> Can you analyze @github:issue://123 and suggest a fix?
> Compare @postgres:schema://users with @docs:file://api/auth

# MCP 프롬프트를 슬래시 명령어로
/mcp__github__list_prs
/mcp__github__pr_review 456
```

### 출력 제한

- **경고 임계값**: 10,000 토큰 초과 시 경고
- **기본 제한**: 25,000 토큰
- **조정**: `MAX_MCP_OUTPUT_TOKENS=50000 claude`

### MCP 서버 보안 주의사항

> "Use third party MCP servers at your own risk - Anthropic has not verified the correctness or security of all these servers."

**MCP 서버는 사용자가 명시적으로 선택해야 합니다.** 기본 포함되는 서버는 없습니다.

### 유용한 MCP 서버 목록

**📊 데이터베이스**

| 서버 | 설명 | 감지 조건 |
|------|------|----------|
| PostgreSQL | 관계형 DB 쿼리 | `pg`, `postgres` 의존성 |
| MongoDB | NoSQL (Atlas 지원) | `mongoose`, `mongodb` 의존성 |
| Redis | 키-값 저장소/캐시 | `redis`, `ioredis` 의존성 |
| Elasticsearch | 검색 엔진 | `@elastic/elasticsearch` 의존성 |
| DuckDB | 데이터 분석 | `duckdb` 의존성 |

**🌐 웹 & 브라우저**

| 서버 | 설명 |
|------|------|
| Fetch | 웹 콘텐츠 가져오기/변환 |
| Puppeteer | 브라우저 자동화 |
| Firecrawl | 웹 스크래핑 |
| Browserbase | 클라우드 브라우저 |

**💼 협업 & 생산성**

| 서버 | 설명 |
|------|------|
| Notion | 문서/데이터베이스 관리 |
| Linear | 이슈 트래킹 |
| Atlassian | Jira/Confluence |
| Asana | 프로젝트 관리 |

**💰 결제 & 금융**

| 서버 | 설명 | 감지 조건 |
|------|------|----------|
| Stripe | 결제 처리 | `stripe` 의존성 |
| PayPal | 결제 처리 | `@paypal/checkout-server-sdk` |

**🔐 보안 & 모니터링**

| 서버 | 설명 | 감지 조건 |
|------|------|----------|
| Sentry | 에러 모니터링 | `@sentry/*` 의존성 |
| Datadog | APM/로깅 | `dd-trace` 의존성 |

**☁️ 클라우드 & 인프라**

| 서버 | 설명 | 감지 조건 |
|------|------|----------|
| AWS | AWS 서비스 | `@aws-sdk/*` 의존성 |
| Firebase | 백엔드 서비스 | `firebase-admin` 의존성 |

**🛠️ 개발 도구**

| 서버 | 설명 |
|------|------|
| Git | 저장소 조작 |
| Filesystem | 파일 작업 |
| Memory | 지식 그래프 메모리 |
| E2B | 코드 샌드박스 |

### 프로젝트 기반 MCP 추천 전략

`/setup-claude-code` 실행 시 프로젝트 의존성을 분석하여 MCP 서버를 **추천**합니다.

> **중요**: 모든 MCP 서버는 사용자가 명시적으로 선택해야 합니다. 자동 추가되는 서버는 없습니다.

```
1. 의존성 분석 (package.json, requirements.txt 등)
   ├── mongoose/mongodb → MongoDB MCP 추천
   ├── pg/postgres → PostgreSQL MCP 추천
   ├── redis/ioredis → Redis MCP 추천
   ├── stripe → Stripe MCP 추천
   ├── @sentry/* → Sentry MCP 추천
   ├── @aws-sdk/* → AWS MCP 추천
   └── firebase-admin → Firebase MCP 추천

2. 사용자 확인 (AskUserQuestion)
   └── 추천 서버 선택 UI 제공
```

**추천 프롬프트 예시**:

```markdown
프로젝트 분석 결과, 다음 MCP 서버를 추천합니다:

🔧 협업 도구 (선택):
[ ] GitHub - PR/이슈 관리
[ ] Linear - 이슈 트래킹
[ ] Jira - 프로젝트 관리

📦 의존성 감지 (선택):
[x] MongoDB (mongoose 감지됨)
[x] Redis (ioredis 감지됨)
[ ] Stripe (stripe 감지됨)

기타:
[ ] 건너뛰기 - MCP 연결 안 함

선택한 서버를 .mcp.json에 추가할까요?
```

**참고**:
- MCP 서버 전체 목록: https://github.com/modelcontextprotocol/servers
- MCP Registry: https://registry.modelcontextprotocol.io/

---

## 1.7 GitHub Action (선택)

**목적**: PR 코멘트로 문서 자동 업데이트

**위치**: `.github/workflows/claude-docs-update.yml`

**범용 템플릿**:

```yaml
name: Claude Documentation Update

on:
  pull_request_review_comment:
    types: [created]
  issue_comment:
    types: [created]

jobs:
  update-docs:
    if: |
      contains(github.event.comment.body, '@claude') &&
      (github.event_name == 'pull_request_review_comment' ||
       (github.event_name == 'issue_comment' && github.event.issue.pull_request))
    runs-on: ubuntu-latest

    permissions:
      contents: write
      pull-requests: write

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Run Claude Code
        uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          github_token: ${{ secrets.GITHUB_TOKEN }}
          comment: ${{ github.event.comment.body }}

      - name: Commit changes
        run: |
          git config --local user.email "claude-bot@anthropic.com"
          git config --local user.name "Claude Bot"
          git add -A
          if git diff --staged --quiet; then
            echo "No changes to commit"
          else
            git commit -m "docs: Claude가 문서를 업데이트했습니다

            요청: ${{ github.event.comment.body }}

            Co-Authored-By: Claude <claude-bot@anthropic.com>"
            git push
          fi
```
