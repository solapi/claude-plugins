---
name: prfaq-new
description: 새로운 PRFAQ (Press Release + FAQ) 문서를 생성합니다.
arguments:
  - name: feature_name
    description: 기능 이름 (예: user-authentication)
    required: true
---

# 새 PRFAQ 생성

## 지시사항

사용자가 새로운 기능에 대한 PRFAQ 문서 생성을 요청했습니다.

### 1단계: 문서 디렉토리 확인

```bash
mkdir -p docs/working-backwards
```

### 2단계: 기존 문서 확인

먼저 동일한 기능에 대한 기존 PRFAQ가 있는지 확인합니다:

```bash
ls -la docs/working-backwards/PRFAQ-*{feature_name}* 2>/dev/null || echo "기존 PRFAQ 없음"
```

기존 문서가 있으면 사용자에게 알리고 기존 문서를 수정할 것인지 확인합니다.

### 3단계: PRFAQ 템플릿 로드

PRFAQ 템플릿을 읽어옵니다:
- 경로: `skills/working-backwards/templates/prfaq-template.md`

### 4단계: 사용자와 대화형 작성

다음 순서로 사용자와 대화하며 PRFAQ를 작성합니다:

1. **기능 개요**: "이 기능이 무엇인지 간단히 설명해주세요."

2. **5가지 핵심 질문** (순서대로 질문):
   - "이 기능의 **고객**은 누구인가요? (구체적인 페르소나/세그먼트)"
   - "고객이 겪고 있는 **문제**나 활용하고자 하는 **기회**는 무엇인가요?"
   - "이 기능이 제공하는 **가장 중요한 고객 혜택** 3가지는 무엇인가요?"
   - "고객이 이것을 원한다는 것을 **어떻게 알 수 있나요**? (데이터, 피드백, 가정)"
   - "고객이 이 기능을 사용하는 **경험**은 어떤 모습인가요? (Before/After)"

3. **Press Release 작성**: 수집된 정보를 바탕으로 보도자료 형식 작성

4. **FAQ 작성**: Internal FAQ와 External FAQ 작성

5. **성공 지표 정의**: KPI와 측정 방법 정의

### 5단계: 문서 저장

완성된 PRFAQ를 저장합니다:

```
docs/working-backwards/PRFAQ-{feature-slug}-{YYYY-MM-DD}.md
```

파일명 규칙:
- feature-slug: 기능명을 kebab-case로 변환
- YYYY-MM-DD: 오늘 날짜

### 6단계: 다음 단계 안내

문서 저장 후 사용자에게 안내합니다:

```
✅ PRFAQ 문서가 생성되었습니다.

📄 파일 위치: docs/working-backwards/PRFAQ-{feature-slug}-{date}.md
📋 상태: Draft

다음 단계:
1. PRFAQ 내용을 검토하고 필요시 수정하세요.
2. 준비가 되면 `/working-backwards:prfaq-validate` 명령으로 검증을 요청하세요.

검증을 통과해야 PRD 작성으로 진행할 수 있습니다.
```

## 주의사항

- 5가지 핵심 질문 중 하나라도 명확하지 않으면 추가 질문을 통해 명확히 합니다.
- "잘 모르겠다" 또는 모호한 답변은 그대로 기록하되, 검증 단계에서 반려 사유가 될 수 있음을 안내합니다.
- 템플릿의 모든 섹션을 채워야 합니다. 해당 없는 항목은 "N/A" 또는 "추후 정의"로 표시합니다.
