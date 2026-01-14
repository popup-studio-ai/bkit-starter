# 5. 최신 트렌드 분석 및 실행 워크플로우

> 이 문서는 [CLAUDE-CODE-MASTERY.md](../CLAUDE-CODE-MASTERY.md)의 일부입니다.

---

## 5.1 최신 트렌드 분석 방법 - 시간대별

AI 도구는 빠르게 변화하므로, 시간대별로 검색을 세분화합니다.

### Claude Code가 수행할 분석

**명령어**: `/upgrade-claude-code` 실행 시

```markdown
## 분석 단계

### 1단계: 최신 정보 수집 (WebSearch) - 시간대별

**년도 트렌드** (전체 방향성):
- "Claude Code best practices {current_year}"
- "{detected_language} Claude Code setup {current_year}"
- "Claude Code configuration guide {current_year}"

**월간 트렌드** (최근 업데이트):
- "Claude Code updates {current_month} {current_year}"
- "Anthropic Claude Code {current_month}"
- "Claude Code new features {current_month}"

**주간 트렌드** (핫 토픽):
- "Claude Code this week"
- "Claude Code latest"
- "MCP servers new releases"

**플랫폼별 심층 검색** (선택):
| 플랫폼 | 검색어 | 특징 |
|--------|--------|------|
| Reddit | site:reddit.com Claude Code | 실사용 리뷰, 팁 |
| HN | site:news.ycombinator.com Claude | 기술적 토론 |
| Discord | Anthropic Discord 직접 | 실시간 지원 |
| GitHub | Claude Code stars:>50 | 인기 프로젝트 |

### 2단계: 현재 설정 분석
- 기존 .claude/ 구조 파악
- CLAUDE.md 내용 분석
- 누락된 설정 식별

### 3단계: 개선 제안
- 새로운 기능 추천
- 설정 최적화 방안
- 트렌드 반영 업그레이드
```

### 분석 결과 형식

```markdown
## Claude Code 업그레이드 분석 결과

### 현재 상태

**레벨 기준**: `.claude/docs/mastery/04-curriculum.md` 참조

| 항목 | 상태 | 세부 |
|------|:----:|------|
| CLAUDE.md | ✅ | 4/6 요소 |
| Commands | ✅ | 3개 |
| Agents | ❌ | 없음 |
| Skills | ❌ | 없음 |
| Hooks | ✅ | PostToolUse |
| Permissions | ⚠️ | allow만 |
| MCP | ❌ | 없음 |
| GitHub Action | ❌ | 없음 |

**현재 레벨**: 2 (자동화) - 4/8 항목

### 권장 업그레이드
1. **[높음]** Agents 폴더 추가 → 레벨 3 달성
2. **[중간]** Skills 폴더 추가 → 레벨 4 달성
3. **[낮음]** MCP 서버 연결

### 트렌드 분석 결과

#### 년도 트렌드 ({current_year})
| 트렌드 | 설명 | 적용 권장 |
|--------|------|:--------:|
| Memory Bank | CLAUDE.md를 세션 간 메모리로 활용 | 높음 |
| Git Worktree | 병렬 Claude 세션 | 중간 |

#### 월간 트렌드 ({current_month})
| 업데이트 | 날짜 | 영향도 |
|----------|------|:------:|
| {업데이트} | {날짜} | {영향도} |

#### 주간 핫토픽
- 🔥 [높음] {핫토픽}
- ⚡ [중간] {핫토픽}
```

---

## 5.2 실행 워크플로우

### /learn-claude-code 워크플로우

```
시작
  ↓
이 문서(CLAUDE-CODE-MASTERY.md) 읽기
  ↓
현재 .claude/ 구조 분석
  ↓
사용자 레벨 추정 (1-4)
  ↓
해당 레벨 교육 콘텐츠 제공
  ↓
실습 가이드 + 코드 예시 제공
  ↓
다음 레벨 안내
```

### /setup-claude-code 워크플로우

```
시작
  ↓
이 문서(CLAUDE-CODE-MASTERY.md) 읽기
  ↓
프로젝트 분석
  ├── 언어 감지 (package.json, go.mod, Cargo.toml 등)
  ├── 구조 감지 (모노레포, 마이크로서비스 등)
  └── 기존 설정 확인
  ↓
적합한 템플릿 선택
  ↓
파일 생성
  ↓
결과 요약 출력
```

### /upgrade-claude-code 워크플로우

```
시작
  ↓
이 문서(CLAUDE-CODE-MASTERY.md) 읽기
  ↓
현재 설정 분석 및 레벨 산출
  ↓
WebSearch로 최신 트렌드 조사
  ↓
개선점 식별 및 우선순위화
  ↓
사용자에게 제안
  ↓
승인 시 업그레이드 적용
  ↓
결과 요약
```