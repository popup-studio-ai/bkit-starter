# 7. Output Styles (출력 스타일)

> 이 문서는 [CLAUDE-CODE-MASTERY.md](../CLAUDE-CODE-MASTERY.md)의 일부입니다.

---

## 7.1 출력 스타일이란?

**출력 스타일**은 Claude Code의 **시스템 프롬프트를 교체**하여 응답 형식과 행동을 커스터마이즈하는 기능입니다.

**중요**: 출력 스타일은 단순한 형식 변경이 아니라 **시스템 프롬프트 전체를 대체**합니다. 기본 코딩 지침을 유지하려면 `keep-coding-instructions` 옵션을 사용하세요.

---

## 7.2 기본 제공 스타일

| 스타일 | 설명 | 사용 사례 |
|--------|------|----------|
| **Default** | 표준 출력 (소프트웨어 엔지니어링 최적화) | 일반적인 코딩 작업 |
| **Explanatory** | 상세 설명 + "Insights" 제공 | 구현 선택, 코드베이스 패턴 이해 |
| **Learning** | 협업 학습 모드 + `TODO(human)` 마커 | 직접 코드 작성하며 학습 |

> **Note**: Concise, Verbose 등은 커스텀 스타일로 직접 생성해야 합니다.

**스타일 적용 (세션 중)**:

```
/output-style explanatory
```

**스타일 목록 확인 및 선택**:

```
/output-style
```

> `/config` 메뉴에서도 출력 스타일에 접근할 수 있습니다.

---

## 7.3 Learning 스타일 특징

Learning 스타일은 특별한 기능을 제공합니다:

- **`TODO(human)` 마커**: 사용자가 직접 해야 할 작업 표시
- **단계별 설명**: 각 코드 변경의 이유 설명
- **개념 링크**: 관련 문서나 개념 참조

```
/output-style learning
```

출력 예시:
```
# 인증 미들웨어 추가

TODO(human): JWT 시크릿 키를 환경 변수에 설정하세요.

이 코드는 다음을 수행합니다:
1. 요청 헤더에서 토큰 추출
2. JWT 검증
3. 사용자 정보를 req.user에 첨부
```

---

## 7.4 커스텀 스타일 정의

### 위치

**`.claude/output-styles/{style-name}.md`**

### 생성 방법

**방법 1: 슬래시 커맨드로 생성**

```
/output-style:new I want concise responses with code examples first
```

Claude가 스타일 파일을 자동 생성합니다.

**방법 2: 수동 생성**

`.claude/output-styles/my-style.md`:

```markdown
---
name: my-style
description: 나만의 출력 스타일
keep-coding-instructions: true
---

# Output Style Instructions

## 톤과 형식
- 간결하고 직접적으로 답변
- 불필요한 서론 생략
- 코드 예시 우선

## 구조
- 핵심 내용 먼저
- 추가 설명은 접기(collapse) 사용
- 관련 파일 경로 항상 표시

## 포맷팅
- 마크다운 사용
- 코드 블록에 언어 명시
- 테이블로 비교 정리
```

### 중요 옵션

| 옵션 | 설명 | 기본값 |
|------|------|:------:|
| `keep-coding-instructions` | 기본 코딩 지침 유지 여부 | `false` |

**`keep-coding-instructions: true`** 사용 시:
- 기본 코딩 규칙 (보안, 에러 처리 등) 유지
- 출력 형식만 변경
- 권장 설정

**`keep-coding-instructions: false`** 사용 시:
- 시스템 프롬프트 전체 교체
- 완전한 커스터마이징 가능
- 주의: 기본 안전 지침이 사라질 수 있음

---

## 7.5 스타일 활용 예시

### 간결한 코드 리뷰 스타일

`.claude/output-styles/brief-review.md`:

```markdown
---
name: brief-review
description: 핵심만 짚는 코드 리뷰
keep-coding-instructions: true
---

# Brief Review Style

## 형식
- 문제점만 나열 (잘된 점 생략)
- 수정 코드 바로 제시
- 1-2줄 설명

## 예시 출력
❌ `any` 타입 사용 → `string | number`로 수정
❌ 미사용 변수 `temp` 삭제
⚠️ 에러 핸들링 추가 권장
```

### 교육용 스타일

`.claude/output-styles/teaching.md`:

```markdown
---
name: teaching
description: 개념 설명 중심
keep-coding-instructions: true
---

# Teaching Style

## 형식
- 코드 전에 개념 설명
- 왜(Why) 설명 필수
- 단계별 진행
- 실수하기 쉬운 부분 강조

## 구조
1. 개념 소개
2. 간단한 예시
3. 실제 적용
4. 주의사항
```

---

## 7.6 명령어 요약

| 명령어 | 설명 |
|--------|------|
| `/output-style` | 사용 가능한 스타일 목록 |
| `/output-style <name>` | 스타일 적용 |
| `/output-style:new <description>` | 새 스타일 생성 |
| `/output-style default` | 기본 스타일로 복원 |

---

## 7.7 참고

- [Claude Code Output Styles](https://code.claude.com/docs/en/output-styles)
- [ClaudeLog Output Styles Guide](https://claudelog.com/mechanics/output-styles/)
