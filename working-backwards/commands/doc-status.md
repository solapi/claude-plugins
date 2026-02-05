---
name: doc-status
description: 특정 기능의 PRFAQ/PRD 문서 상태를 확인합니다.
arguments:
  - name: feature_name
    description: 기능 이름 (예: user-authentication)
    required: true
---

# 문서 상태 확인

## 지시사항

특정 기능의 PRFAQ 및 PRD 문서 상태를 상세히 확인합니다.

### 1단계: 관련 문서 검색

```bash
ls -la docs/working-backwards/*{feature_name}*.md 2>/dev/null
```

### 2단계: 문서가 없는 경우

```
📄 "{feature_name}" 관련 문서를 찾을 수 없습니다.

검색 경로: docs/working-backwards/
검색 패턴: *{feature_name}*

가능한 원인:
1. 해당 기능의 문서가 아직 작성되지 않았습니다.
2. 기능 이름이 다르게 지정되었을 수 있습니다.

다음 단계:
- `/working-backwards:doc-list` 명령으로 전체 문서 목록을 확인하세요.
- `/working-backwards:prfaq-new {feature_name}` 명령으로 새 PRFAQ를 작성하세요.
```

### 3단계: 문서 상태 추출

각 문서에서 다음 정보를 추출합니다:
- Status
- Created 날짜
- Last Updated 날짜
- 검증 체크리스트 상태
- 검증 이력

### 4단계: 상세 결과 출력

```
📄 "{feature_name}" 문서 상태

═══════════════════════════════════════════════════════════════

📋 PRFAQ 상태

파일: docs/working-backwards/PRFAQ-{feature-slug}-{date}.md
상태: {✅ Approved | 📝 Draft | 🔍 In Review | ❌ Rejected}
생성일: {YYYY-MM-DD}
최종 수정일: {YYYY-MM-DD}

검증 체크리스트:
  ✅ 고객이 명확히 정의되었는가?
  ✅ 고객 문제가 구체적으로 기술되었는가?
  ❌ 솔루션이 문제를 해결하는가?
  ⬜ 고객 혜택이 명확한가?
  ⬜ 성공 지표가 정의되었는가?
  ⬜ FAQ가 핵심 질문을 다루는가?

검증 이력:
  | 날짜 | 결과 | 비고 |
  |------|------|------|
  | 2026-02-01 | Rejected | 솔루션 구체화 필요 |
  | 2026-02-03 | Approved | |

═══════════════════════════════════════════════════════════════

📋 PRD 상태

{PRD가 있는 경우}
파일: docs/working-backwards/PRD-{feature-slug}-{date}.md
상태: {✅ Approved | 📝 Draft | 🔍 In Review | ❌ Rejected}
PRFAQ 참조: {PRFAQ 파일 경로}
생성일: {YYYY-MM-DD}
최종 수정일: {YYYY-MM-DD}

검증 체크리스트:
  ✅ PRFAQ와 일관성이 있는가?
  ✅ 기술 요구사항이 명확한가?
  ✅ 범위(scope)가 명확한가?
  ⬜ 의존성이 식별되었는가?
  ⬜ 위험 요소와 대응책이 있는가?
  ⬜ 검증 기준(acceptance criteria)이 있는가?

검증 이력:
  | 날짜 | 결과 | 비고 |
  |------|------|------|
  | 2026-02-05 | Draft | 최초 작성 |

{PRD가 없는 경우}
❌ PRD가 아직 작성되지 않았습니다.

═══════════════════════════════════════════════════════════════

🎯 현재 단계 및 다음 행동

{상태에 따른 안내}
```

### 5단계: 상태별 안내 메시지

#### PRFAQ Draft:
```
📍 현재 단계: PRFAQ 작성 중

다음 행동:
1. PRFAQ 문서를 완성하세요.
2. `/working-backwards:prfaq-validate` 명령으로 검증을 요청하세요.
```

#### PRFAQ Rejected:
```
📍 현재 단계: PRFAQ 수정 필요

반려 사유:
- {검증 이력에서 가장 최근 반려 사유}

다음 행동:
1. 위 반려 사유를 참고하여 PRFAQ를 수정하세요.
2. `/working-backwards:prfaq-validate` 명령으로 재검증을 요청하세요.
```

#### PRFAQ Approved, PRD 없음:
```
📍 현재 단계: PRD 작성 대기

다음 행동:
1. `/working-backwards:prd-new {feature_name}` 명령으로 PRD를 작성하세요.
```

#### PRD Draft:
```
📍 현재 단계: PRD 작성 중

다음 행동:
1. PRD 문서를 완성하세요.
2. `/working-backwards:prd-validate` 명령으로 검증을 요청하세요.
```

#### PRD Rejected:
```
📍 현재 단계: PRD 수정 필요

반려 사유:
- {검증 이력에서 가장 최근 반려 사유}

다음 행동:
1. 위 반려 사유를 참고하여 PRD를 수정하세요.
2. `/working-backwards:prd-validate` 명령으로 재검증을 요청하세요.
```

#### PRFAQ + PRD 모두 Approved:
```
🎉 구현 준비 완료!

✅ PRFAQ: Approved
✅ PRD: Approved

이제 코드 작성을 시작할 수 있습니다.
PRD의 기능 요구사항과 검증 기준을 참고하세요.

참고 문서:
- PRFAQ: {파일 경로}
- PRD: {파일 경로}
```
