---
description: Claude Code 학습 가이드 - 체계적인 학습 커리큘럼
argument-hint: [레벨]
---

# Claude Code 학습 가이드

사용자에게 Claude Code 설정 방법을 교육합니다. **어떤 프로젝트, 어떤 언어에서든** 동일하게 작동합니다.

## 사용법

```
/learn-claude-code [레벨]
```

- 레벨 생략 시: 현재 설정 분석 후 적합한 레벨 추천
- 레벨 지정: 1 (기초), 2 (자동화), 3 (전문화), 4 (팀 최적화)

## 왜 이 커맨드가 필요한가?

```
문제: Claude Code 기능이 많아서 어디서부터 배워야 할지 모름
해결: 현재 설정 수준을 분석하고 레벨별 교육 콘텐츠 제공
결과: 단계별로 Claude Code 마스터
```

## 수행 작업

### 1단계: 마스터 가이드 참조

**반드시** 다음 문서를 먼저 읽어야 합니다:

```
.claude/docs/CLAUDE-CODE-MASTERY.md          # 목차 및 핵심 개념
.claude/docs/mastery/04-curriculum.md        # 교육 커리큘럼 (레벨 시스템 정의)
.claude/docs/mastery/02-language-templates.md # 언어별 템플릿
.claude/docs/mastery/03-project-structures.md # 프로젝트 구조별 가이드
```

### 2단계: 현재 설정 분석

프로젝트의 Claude Code 설정 현황을 분석합니다:

```bash
# 분석할 파일/폴더
- CLAUDE.md (루트)
- .claude/settings.local.json
- .claude/commands/
- .claude/agents/
- .claude/skills/
- .mcp.json
- .github/workflows/
```

#### 기본 제공 파일 제외 (중요!)

다음 파일/폴더는 **이 학습 시스템의 기본 제공 파일**이므로 평가 시 **제외**해야 합니다:

```bash
# 제외할 파일/폴더 (사용자 설정으로 카운트하지 않음)
- .claude/commands/learn-claude-code.md      # 학습 커맨드
- .claude/commands/setup-claude-code.md      # 설정 생성 커맨드
- .claude/commands/upgrade-claude-code.md    # 업그레이드 커맨드
- .claude/commands/first-claude-code.md      # 첫 프로젝트 커맨드
- .claude/docs/                              # 마스터 가이드 문서 전체
```

### 3단계: 레벨 및 체크리스트 평가

**중요**: 레벨 정의, 항목별 체크리스트, 대시보드 형식은 모두 `.claude/docs/mastery/04-curriculum.md`의 "4.0 Claude Code 설정 현황 시스템"을 참조합니다.

해당 문서에서 다음 내용을 확인:
- 레벨 정의 (0-5)
- 항목별 체크리스트 (8개 항목)
- 대시보드 출력 형식
- 빠른 레벨업 가이드

### 4단계: 대시보드 출력

`.claude/docs/mastery/04-curriculum.md`의 "대시보드 출력 형식"에 따라 분석 결과를 시각화합니다.

### 5단계: 교육 콘텐츠 제공

현재 레벨에 맞는 교육 콘텐츠를 `.claude/docs/mastery/04-curriculum.md`에서 참조:

| 레벨 | 참조 섹션 | 핵심 안내 |
|------|----------|----------|
| 0 | 4.0 설정 현황 시스템 | `/first-claude-code` 또는 `/setup-claude-code` 안내 |
| 1 | 4.1 레벨 1: 기초 | CLAUDE.md 작성법, 금지사항 추가 |
| 2 | 4.2 레벨 2: 자동화 | Commands 생성, Hooks 설정 |
| 3 | 4.3 레벨 3: 전문화 | Agents, Skills, MCP 연결 |
| 4 | 4.4 레벨 4: 팀 최적화 | GitHub Action, 팀 규칙 |

**동적 개선 제안**:

현재 상태를 기반으로 가장 효과적인 개선 방법을 제안합니다:

```
예시 (레벨 2, Hooks ❌):
→ "Hooks 설정이 비어있네요. PostToolUse 훅으로 코드 포맷팅을 자동화하면 레벨 3 진입!"

예시 (레벨 3, Skills ❌):
→ "Skills를 추가하면 Claude가 도메인 맥락을 더 잘 이해합니다. 레벨 4 달성 가능!"
```

### 6단계: 다음 단계 안내

현재 레벨 완료 후 다음 레벨로 진행하도록 안내합니다.

## 결과 출력

```
📚 Claude Code 학습 완료!

**현재 레벨**: {레벨} ({레벨명})
**진행 현황**: {X}/8 항목 설정됨
**학습 내용**: {커리큘럼 해당 레벨 내용 요약}

📊 항목별 상태:
[04-curriculum.md 대시보드 형식 사용]

💡 빠른 레벨업:
- {가장 효과적인 항목 1}
- {가장 효과적인 항목 2}

🎯 다음 단계:
- /learn-claude-code {다음레벨} 로 계속 학습
- /setup-claude-code 로 설정 자동 생성
- /upgrade-claude-code 로 최신 트렌드 확인
```

## 에러 처리

### 마스터 가이드를 찾을 수 없는 경우

```
⚠️ 마스터 가이드 문서를 찾을 수 없습니다.

이 프로젝트에 bkit-starter가 설정되지 않았을 수 있습니다.

해결 방법:
1. bkit-starter 저장소에서 .claude/docs/ 폴더를 복사하세요
2. 또는 /setup-claude-code 를 실행하세요
```

### 프로젝트 분석 실패 시

```
⚠️ 프로젝트 분석에 실패했습니다.

확인할 사항:
- 현재 디렉토리가 프로젝트 루트인지 확인
- package.json 또는 설정 파일이 있는지 확인

분석 없이 진행하려면:
→ /learn-claude-code 1 (레벨 1부터 시작)
```

## 참고 문서

- .claude/docs/CLAUDE-CODE-MASTERY.md
- .claude/docs/mastery/04-curriculum.md **(레벨 시스템 정의 - 단일 소스)**