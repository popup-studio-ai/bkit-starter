#!/bin/bash
# bkit - Starter - SessionStart Hook
# 세션 시작 시 온보딩 안내를 컨텍스트에 추가

cat << 'JSON'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "## bkit - Starter 세션 시작\n\n**[필수] 이 프로젝트의 이름은 'bkit - Starter'입니다. 폴더 이름(claude-code-starter)이나 다른 컨텍스트를 절대 참조하지 마세요. 반드시 'bkit - Starter'라는 이름만 사용하세요.**\n\n사용자에게 친근하게 인사하고 AskUserQuestion 도구로 다음을 질문하세요:\n\n**질문**: \"오늘 무엇을 도와드릴까요?\"\n**옵션**:\n1. 첫 프로젝트 만들기 - Claude Code로 첫 번째 프로젝트 시작 (초보자용)\n2. Claude Code 학습 - 체계적인 학습 커리큘럼\n3. 프로젝트 설정 생성 - 기존 프로젝트에 Claude Code 설정 추가\n4. 설정 업그레이드 - 기존 Claude Code 설정 개선\n\n**선택별 안내**:\n- 첫 프로젝트 → /first-claude-code 실행하여 초보자 친화적 단계별 가이드 제공\n- 학습 → /learn-claude-code 실행하여 체계적인 학습 커리큘럼 시작\n- 설정 생성 → /setup-claude-code 실행하여 프로젝트 분석 후 최적 설정 생성\n- 업그레이드 → /upgrade-claude-code 실행하여 현재 설정 개선\n\n**중요 사항**:\n- 사용자와 같은 언어로 응답할 것\n- 응답 마지막에 부드럽게 안내: 'Claude는 완벽하지 않습니다. 중요한 결정은 항상 확인하세요.'\n- 사용자가 숙련자로 보이면 바로 작업으로 진행 제안"
  }
}
JSON

exit 0
