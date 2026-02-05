#!/bin/bash
#
# Working Backwards 승인 상태 확인 스크립트
#
# 코드 수정 전 PRFAQ와 PRD가 모두 승인되었는지 확인합니다.
# 승인되지 않은 경우 구현을 차단합니다.
#

# 도구 입력에서 파일 경로 추출
TOOL_INPUT="$1"

# JSON에서 file_path 추출 시도
if command -v jq &> /dev/null; then
    FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.file_path // empty' 2>/dev/null)
fi

# jq가 없거나 실패한 경우 grep으로 시도
if [ -z "$FILE_PATH" ]; then
    FILE_PATH=$(echo "$TOOL_INPUT" | grep -oP '"file_path"\s*:\s*"\K[^"]+' 2>/dev/null)
fi

# 그래도 없으면 입력 자체를 경로로 사용
if [ -z "$FILE_PATH" ]; then
    FILE_PATH="$TOOL_INPUT"
fi

# 제외할 경로 패턴 확인
is_excluded_path() {
    local path="$1"

    # 제외 패턴들
    local patterns=(
        "docs/working-backwards/"
        "\.md$"
        "\.json$"
        "\.txt$"
        "\.yml$"
        "\.yaml$"
        "package\.json$"
        "package-lock\.json$"
        "\.gitignore$"
        "README"
        "LICENSE"
        "CHANGELOG"
        "\.env"
        "test[s]?/"
        "__test__/"
        "\.spec\."
        "\.test\."
    )

    for pattern in "${patterns[@]}"; do
        if echo "$path" | grep -qiE "$pattern"; then
            return 0  # 제외됨
        fi
    done

    return 1  # 제외 아님
}

# 제외 경로면 통과
if is_excluded_path "$FILE_PATH"; then
    exit 0
fi

# 프로젝트 루트 찾기
find_project_root() {
    local current="$PWD"
    while [ "$current" != "/" ]; do
        if [ -d "$current/.git" ] || [ -f "$current/package.json" ]; then
            echo "$current"
            return
        fi
        current=$(dirname "$current")
    done
    echo "$PWD"
}

PROJECT_ROOT=$(find_project_root)
DOCS_DIR="$PROJECT_ROOT/docs/working-backwards"

# Working Backwards 문서 디렉토리 확인
if [ ! -d "$DOCS_DIR" ]; then
    cat << 'EOF'
⚠️ Working Backwards 프로세스 필요

코드를 수정하기 전에 PRFAQ와 PRD 문서가 필요합니다.

다음 단계:
1. `/solapi-working-backwards:prfaq-new [기능명]` 명령으로 PRFAQ를 작성하세요.
2. PRFAQ 승인 후 PRD를 작성하세요.
3. PRD 승인 후 구현을 시작하세요.

Working Backwards 철학:
"고객에서 출발하여 역으로 작업하면서 최소한의 기술 요구사항에 도달"
EOF
    exit 1
fi

# 문서에서 Status 추출
get_status() {
    local file="$1"
    if [ -f "$file" ]; then
        # **Status**: Approved 또는 > **Status**: Approved 형식 찾기
        grep -oP '\*\*Status\*\*:\s*\K\w+' "$file" 2>/dev/null | head -1
    fi
}

# PRFAQ 상태 확인
PRFAQ_EXISTS=false
PRFAQ_APPROVED=false
PRFAQ_FILES=()
PRFAQ_STATUSES=()

for file in "$DOCS_DIR"/PRFAQ-*.md; do
    if [ -f "$file" ]; then
        PRFAQ_EXISTS=true
        status=$(get_status "$file")
        PRFAQ_FILES+=("$(basename "$file")")
        PRFAQ_STATUSES+=("$status")
        if [ "$status" = "Approved" ]; then
            PRFAQ_APPROVED=true
        fi
    fi
done

# PRD 상태 확인
PRD_EXISTS=false
PRD_APPROVED=false
PRD_FILES=()
PRD_STATUSES=()

for file in "$DOCS_DIR"/PRD-*.md; do
    if [ -f "$file" ]; then
        PRD_EXISTS=true
        status=$(get_status "$file")
        PRD_FILES+=("$(basename "$file")")
        PRD_STATUSES+=("$status")
        if [ "$status" = "Approved" ]; then
            PRD_APPROVED=true
        fi
    fi
done

# 모두 승인되었으면 통과
if [ "$PRFAQ_APPROVED" = true ] && [ "$PRD_APPROVED" = true ]; then
    exit 0
fi

# 미승인 상태 - 구현 차단
echo "❌ 구현이 차단되었습니다"
echo ""
echo "Working Backwards 프로세스가 완료되지 않았습니다."
echo ""

# PRFAQ 상태 출력
echo "📋 PRFAQ 상태:"
if [ "$PRFAQ_EXISTS" = false ]; then
    echo "   ❌ PRFAQ 문서 없음"
    echo "   → \`/solapi-working-backwards:prfaq-new [기능명]\` 명령으로 작성하세요."
else
    for i in "${!PRFAQ_FILES[@]}"; do
        file="${PRFAQ_FILES[$i]}"
        status="${PRFAQ_STATUSES[$i]}"
        if [ "$status" = "Approved" ]; then
            echo "   ✅ $file: $status"
        else
            echo "   ❌ $file: ${status:-Unknown}"
        fi
    done
    if [ "$PRFAQ_APPROVED" = false ]; then
        echo "   → \`/solapi-working-backwards:prfaq-validate\` 명령으로 검증하세요."
    fi
fi

echo ""

# PRD 상태 출력
echo "📋 PRD 상태:"
if [ "$PRD_EXISTS" = false ]; then
    echo "   ❌ PRD 문서 없음"
    if [ "$PRFAQ_APPROVED" = true ]; then
        echo "   → \`/solapi-working-backwards:prd-new [기능명]\` 명령으로 작성하세요."
    else
        echo "   → PRFAQ 승인 후 PRD를 작성할 수 있습니다."
    fi
else
    for i in "${!PRD_FILES[@]}"; do
        file="${PRD_FILES[$i]}"
        status="${PRD_STATUSES[$i]}"
        if [ "$status" = "Approved" ]; then
            echo "   ✅ $file: $status"
        else
            echo "   ❌ $file: ${status:-Unknown}"
        fi
    done
    if [ "$PRD_APPROVED" = false ]; then
        echo "   → \`/solapi-working-backwards:prd-validate\` 명령으로 검증하세요."
    fi
fi

echo ""
echo "PRFAQ와 PRD가 모두 Approved 상태일 때만 코드 작성이 허용됩니다."

exit 1
