# 6. Plugins (플러그인)

> 이 문서는 [CLAUDE-CODE-MASTERY.md](../CLAUDE-CODE-MASTERY.md)의 일부입니다.

---

## 6.1 플러그인이란?

**플러그인**은 Claude Code의 기능을 확장하는 재사용 가능한 패키지입니다. **Slash Commands, Subagents, MCP servers**를 하나의 번들로 묶어 다른 프로젝트나 팀에 배포할 수 있습니다.

**플러그인 vs 로컬 설정**:

| 구분 | 로컬 설정 | 플러그인 |
|------|----------|----------|
| 위치 | `.claude/` 폴더 | Marketplace 또는 URL |
| 범위 | 해당 프로젝트 | 여러 프로젝트 공유 |
| 배포 | Git | Marketplace/HTTP |
| 업데이트 | 수동 | 자동 |

---

## 6.2 플러그인 구조

플러그인은 **`.claude-plugin/`** 폴더 안에 정의합니다.

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json           # 플러그인 매니페스트 (필수)
├── README.md                 # 설명 문서
├── commands/                 # 슬래시 커맨드
│   └── my-command.md
├── agents/                   # 서브 에이전트
│   └── my-agent.md
├── skills/                   # 스킬
│   └── my-skill/
│       └── SKILL.md
└── hooks/                    # 훅 스크립트
    └── format.sh
```

**중요**: `plugin.json`은 루트가 아닌 **`.claude-plugin/`** 폴더 안에 위치합니다.

---

## 6.3 plugin.json (매니페스트)

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "플러그인 설명",
  "author": "작성자",
  "homepage": "https://github.com/...",
  "license": "MIT",
  "claude": {
    "minVersion": "1.0.0"
  },
  "commands": ["commands/my-command.md"],
  "agents": ["agents/my-agent.md"],
  "skills": ["skills/my-skill"],
  "hooks": {
    "PostToolUse": [{
      "matcher": "Write|Edit",
      "script": "hooks/format.sh"
    }]
  },
  "permissions": {
    "allow": ["Bash(npm:*)"],
    "deny": []
  }
}
```

**필수 필드**:

| 필드 | 설명 |
|------|------|
| `name` | 플러그인 고유 이름 (kebab-case) |
| `version` | Semantic Versioning (1.0.0) |
| `description` | 간단한 설명 (최대 200자) |

**선택 필드**:

| 필드 | 설명 |
|------|------|
| `author` | 작성자/조직 |
| `homepage` | GitHub/웹사이트 URL |
| `license` | 라이선스 (MIT, Apache-2.0 등) |
| `claude.minVersion` | 최소 Claude Code 버전 |
| `commands` | 포함할 커맨드 목록 |
| `agents` | 포함할 에이전트 목록 |
| `skills` | 포함할 스킬 폴더 목록 |
| `hooks` | 훅 정의 |
| `permissions` | 권한 설정 |

---

## 6.4 플러그인 관리 (슬래시 커맨드)

Claude Code 세션 내에서 **`/plugin`** 슬래시 커맨드를 사용합니다.

### 플러그인 검색 및 설치

```
/plugin
```

Discover 탭에서 사용 가능한 플러그인을 탐색합니다.

> **Note**: 공식 Anthropic 마켓플레이스(claude-plugins-official)는 Claude Code 시작 시 자동으로 사용 가능합니다.

```
/plugin marketplace add <plugin-name>
```

### 설치된 플러그인 관리

```
/plugin list                    # 설치된 플러그인 목록
/plugin enable <plugin-name>    # 플러그인 활성화
/plugin disable <plugin-name>   # 플러그인 비활성화
/plugin remove <plugin-name>    # 플러그인 제거
```

### URL에서 설치

```
/plugin add https://github.com/org/plugin/releases/latest/download/plugin.zip
```

### 로컬 경로에서 설치

```
/plugin add ./path/to/plugin
```

---

## 6.5 플러그인 개발

**1단계: 플러그인 구조 생성**

```bash
mkdir my-plugin && cd my-plugin
mkdir -p .claude-plugin commands agents skills hooks
```

**2단계: plugin.json 생성**

```bash
cat > .claude-plugin/plugin.json << 'EOF'
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "My awesome plugin",
  "commands": ["commands/my-command.md"]
}
EOF
```

**3단계: 기능 추가**

```bash
# 커맨드 추가
cat > commands/my-command.md << 'EOF'
# My Command

이 커맨드는...

## 수행 작업
1. ...
2. ...
EOF
```

**4단계: 로컬 테스트**

```
# Claude Code 세션에서
/plugin add ./path/to/my-plugin

# 테스트
/my-command

# 제거
/plugin remove my-plugin
```

**5단계: 배포**

- GitHub Releases로 zip 파일 배포
- 또는 Marketplace에 제출

---

## 6.6 Marketplace

### marketplace.json 구조

Marketplace에 제출할 때 사용하는 형식:

```json
{
  "plugins": [
    {
      "name": "my-plugin",
      "displayName": "My Plugin",
      "description": "플러그인 설명",
      "author": "작성자",
      "version": "1.0.0",
      "url": "https://github.com/org/my-plugin/releases/latest/download/plugin.zip",
      "homepage": "https://github.com/org/my-plugin",
      "tags": ["productivity", "workflow"],
      "downloads": 0
    }
  ]
}
```

### 공식 플러그인 예시

| 플러그인 | 설명 |
|----------|------|
| `@anthropic/git-workflow` | Git 워크플로우 자동화 |
| `@anthropic/code-review` | 코드 리뷰 에이전트 |
| `@anthropic/testing` | 테스트 작성/실행 도구 |
| `@anthropic/docs` | 문서 생성 도구 |

### 검색 및 설치

```
# Claude Code 세션에서
/plugin marketplace                         # Marketplace 열기
/plugin marketplace search "testing"        # 검색
/plugin marketplace add @anthropic/testing  # 설치
```

---

## 6.7 자동 업데이트

Claude Code는 시작 시 마켓플레이스와 설치된 플러그인을 자동으로 업데이트할 수 있습니다.

- 공식 Anthropic 마켓플레이스는 기본적으로 자동 업데이트 활성화
- 서드파티 마켓플레이스는 수동 설정 필요

---

## 6.8 참고

- [Claude Code Plugin Docs](https://code.claude.com/docs/en/discover-plugins)
- [Anthropic Official Plugins](https://github.com/anthropics/claude-plugins-official)
