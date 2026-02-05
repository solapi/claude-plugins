#!/bin/bash
#
# Working Backwards Approval Status Check Script
#
# Checks that both PRFAQ and PRD are approved before code modification.
# Blocks implementation if not approved.
#

# Extract file path from tool input
TOOL_INPUT="$1"

# Try to extract file_path from JSON
if command -v jq &> /dev/null; then
    FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.file_path // empty' 2>/dev/null)
fi

# If jq is not available or failed, try with grep
if [ -z "$FILE_PATH" ]; then
    FILE_PATH=$(echo "$TOOL_INPUT" | grep -oP '"file_path"\s*:\s*"\K[^"]+' 2>/dev/null)
fi

# If still empty, use the input itself as the path
if [ -z "$FILE_PATH" ]; then
    FILE_PATH="$TOOL_INPUT"
fi

# Check if path should be excluded
is_excluded_path() {
    local path="$1"

    # Exclusion patterns
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
            return 0  # Excluded
        fi
    done

    return 1  # Not excluded
}

# Pass if excluded path
if is_excluded_path "$FILE_PATH"; then
    exit 0
fi

# Find project root
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

# Check Working Backwards document directory
if [ ! -d "$DOCS_DIR" ]; then
    cat << 'EOF'
⚠️ Working Backwards Process Required

PRFAQ and PRD documents are required before modifying code.

Next steps:
1. Create a PRFAQ with `/solapi-working-backwards:prfaq-new [feature_name]` command.
2. After PRFAQ approval, create a PRD.
3. After PRD approval, start implementation.

Working Backwards Philosophy:
"Start from the customer and work backwards to reach the minimum technical requirements"
EOF
    exit 1
fi

# Extract Status from document
get_status() {
    local file="$1"
    if [ -f "$file" ]; then
        # Find **Status**: Approved or > **Status**: Approved format
        grep -oP '\*\*Status\*\*:\s*\K\w+' "$file" 2>/dev/null | head -1
    fi
}

# Check PRFAQ status
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

# Check PRD status
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

# Pass if all approved
if [ "$PRFAQ_APPROVED" = true ] && [ "$PRD_APPROVED" = true ]; then
    exit 0
fi

# Not approved - block implementation
echo "❌ Implementation blocked"
echo ""
echo "Working Backwards process is not complete."
echo ""

# Output PRFAQ status
echo "📋 PRFAQ Status:"
if [ "$PRFAQ_EXISTS" = false ]; then
    echo "   ❌ No PRFAQ document"
    echo "   → Create one with \`/solapi-working-backwards:prfaq-new [feature_name]\` command."
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
        echo "   → Validate with \`/solapi-working-backwards:prfaq-validate\` command."
    fi
fi

echo ""

# Output PRD status
echo "📋 PRD Status:"
if [ "$PRD_EXISTS" = false ]; then
    echo "   ❌ No PRD document"
    if [ "$PRFAQ_APPROVED" = true ]; then
        echo "   → Create one with \`/solapi-working-backwards:prd-new [feature_name]\` command."
    else
        echo "   → You can create a PRD after PRFAQ is approved."
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
        echo "   → Validate with \`/solapi-working-backwards:prd-validate\` command."
    fi
fi

echo ""
echo "Code writing is only allowed when both PRFAQ and PRD are in Approved status."

exit 1
