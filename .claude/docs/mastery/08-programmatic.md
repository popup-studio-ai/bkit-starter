# 8. Programmatic Usage (프로그래매틱 사용)

> 이 문서는 [CLAUDE-CODE-MASTERY.md](../CLAUDE-CODE-MASTERY.md)의 일부입니다.

---

## 8.1 CLI SDK 개요

Claude Code는 프로그래매틱 방식으로 호출하여 자동화 파이프라인, CI/CD, 스크립트에서 사용할 수 있습니다.

---

## 8.2 기본 CLI 플래그

**프롬프트 전달**:

```bash
# -p: 단일 프롬프트 실행 후 종료
claude -p "package.json 분석해줘"

# stdin으로 프롬프트 전달
echo "테스트 작성해줘" | claude
```

**출력 형식**:

```bash
# JSON 출력 (파싱 용이)
claude -p "버그 찾아줘" --output-format json

# 스트리밍 JSON (대용량 응답, 실시간 처리)
claude -p "분석해줘" --output-format stream-json

# 텍스트만 출력 (마크다운 없음)
claude -p "요약해줘" --output-format text

# 스트리밍 비활성화
claude -p "분석해줘" --no-stream

# 최대 턴 수 제한
claude -p "리뷰해줘" --max-turns 3
```

**도구 제한**:

```bash
# 특정 도구만 허용
claude -p "코드 분석해줘" --allowedTools "Read,Grep,Glob"

# 특정 도구 금지
claude -p "분석해줘" --disallowedTools "Bash,Write,Edit"

# 도구 사용 금지 (대화만)
claude -p "설명해줘" --allowedTools ""
```

| 플래그 | 설명 |
|--------|------|
| `--allowedTools` | 허용할 도구 목록 (화이트리스트) |
| `--disallowedTools` | 금지할 도구 목록 (블랙리스트) |

**세션 중 도구 관리**:

```
/allowed-tools              # 현재 허용된 도구 목록 확인
```

---

## 8.3 JSON Schema 출력

구조화된 출력을 위해 JSON Schema를 지정할 수 있습니다:

```bash
# 스키마 파일로 지정
claude -p "이슈 목록 추출" --json-schema ./issue-schema.json

# 인라인 스키마
claude -p "버그 분석" --json-schema '{"type":"object","properties":{"bugs":{"type":"array"}}}'
```

**스키마 예시** (`analysis-schema.json`):

```json
{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "issues": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "severity": { "type": "string", "enum": ["critical", "major", "minor"] },
          "file": { "type": "string" },
          "line": { "type": "number" },
          "description": { "type": "string" }
        }
      }
    },
    "recommendations": {
      "type": "array",
      "items": { "type": "string" }
    }
  },
  "required": ["summary", "issues"]
}
```

---

## 8.4 CI/CD 통합

**GitHub Actions 예시**:

```yaml
name: Claude Code Analysis

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code

      - name: Analyze PR changes
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          git diff origin/main...HEAD > changes.diff
          claude -p "다음 diff 분석해줘: $(cat changes.diff)" \
            --output-format json \
            --json-schema ./schemas/pr-review.json \
            > analysis.json

      - name: Post comment
        uses: actions/github-script@v7
        with:
          script: |
            const analysis = require('./analysis.json');
            // PR에 코멘트 작성 로직
```

**GitLab CI 예시**:

```yaml
code-review:
  stage: review
  script:
    - npm install -g @anthropic-ai/claude-code
    - claude -p "MR 변경사항 리뷰해줘" --allowedTools "Read,Grep" > review.md
    - cat review.md
  artifacts:
    paths:
      - review.md
```

---

## 8.5 스크립트 자동화

**Bash 스크립트 예시**:

```bash
#!/bin/bash
# 코드베이스 분석 스크립트

OUTPUT=$(claude -p "보안 취약점 스캔해줘" \
  --output-format json \
  --allowedTools "Read,Grep,Glob" \
  --json-schema ./security-schema.json)

# 결과 파싱
CRITICAL=$(echo "$OUTPUT" | jq '.vulnerabilities | map(select(.severity == "critical")) | length')

if [ "$CRITICAL" -gt 0 ]; then
  echo "⚠️ Critical vulnerabilities found: $CRITICAL"
  exit 1
fi

echo "✅ No critical vulnerabilities"
```

**Node.js 스크립트 예시**:

```javascript
const { execSync } = require('child_process');

async function analyzeCode(prompt) {
  const result = execSync(
    `claude -p "${prompt}" --output-format json`,
    { encoding: 'utf8' }
  );
  return JSON.parse(result);
}

// 사용
const analysis = await analyzeCode('테스트 커버리지 분석해줘');
console.log(analysis.coverage);
```

---

## 8.6 프로그래매틱 사용 시 주의사항

| 항목 | 권장 사항 |
|------|----------|
| API 키 관리 | 환경 변수 또는 시크릿 매니저 사용 |
| 타임아웃 | 복잡한 작업은 충분한 타임아웃 설정 |
| 에러 처리 | 종료 코드 확인 및 stderr 로깅 |
| 도구 제한 | 필요한 도구만 `--allowedTools`로 제한 |
| 출력 파싱 | JSON 출력 + 스키마로 안정적 파싱 |