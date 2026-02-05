---
name: solapi-working-backwards
description: Amazon의 Working Backwards 철학을 적용하여 기능 구현 전 PRFAQ와 PRD 문서를 작성하고 검증합니다.
triggers:
  - "기능.*추가"
  - "기능.*구현"
  - "기능.*만들"
  - "기능.*개발"
  - "기능.*수정"
  - "기능.*삭제"
  - "feature.*add"
  - "feature.*implement"
  - "feature.*create"
  - "feature.*develop"
  - "feature.*modify"
  - "feature.*delete"
  - "새로운.*기능"
  - "new.*feature"
  - "추가해.*줘"
  - "만들어.*줘"
  - "구현해.*줘"
  - "개발해.*줘"
---

# Working Backwards 프로세스

## 개요

Amazon의 "Working Backwards" 철학에 따라 기능 구현을 진행합니다.

> "고객에서 출발하여 역으로 작업하면서 최소한의 기술 요구사항에 도달"

## 워크플로우

```
[기능 요청] → [PRFAQ 작성] → [PRFAQ 검증] → [PRD 작성] → [PRD 검증] → [구현 시작]
                               ↓ 반려                    ↓ 반려
                          [PRFAQ 수정]               [PRD 수정]
```

## Amazon의 5가지 핵심 검증 질문

기능 구현 전 반드시 다음 질문에 명확히 답해야 합니다:

1. **고객은 누구인가?**
2. **고객의 문제나 기회는 무엇인가?**
3. **가장 중요한 고객 혜택은 무엇인가?**
4. **고객이 원하는 것을 어떻게 알 수 있는가?**
5. **고객 경험은 어떤 모습인가?**

→ 이 질문들에 명확히 답하지 못하면 **반려**됩니다.

## 프로세스 시작

### 1단계: 기존 문서 확인

먼저 관련 PRFAQ/PRD 문서가 있는지 확인합니다.

```bash
# 기존 문서 검색
ls -la docs/working-backwards/ 2>/dev/null || echo "문서 디렉토리 없음"
```

### 2단계: PRFAQ 작성 또는 확인

**기존 PRFAQ가 없는 경우:**
- `/solapi-working-backwards:prfaq-new [기능명]` 명령으로 새 PRFAQ 생성

**기존 PRFAQ가 있는 경우:**
- `/solapi-working-backwards:doc-status [기능명]` 명령으로 상태 확인

### 3단계: PRFAQ 검증

PRFAQ 작성 후 검증을 수행합니다:
- `/solapi-working-backwards:prfaq-validate` 명령 실행
- validator 에이전트가 5가지 핵심 질문 기반으로 검증
- **Approved** 또는 **Rejected** 결과 반환

### 4단계: PRD 작성 (PRFAQ Approved 후)

PRFAQ가 승인된 후에만 PRD 작성이 가능합니다:
- `/solapi-working-backwards:prd-new [기능명]` 명령으로 PRD 생성

### 5단계: PRD 검증

PRD 작성 후 검증을 수행합니다:
- `/solapi-working-backwards:prd-validate` 명령 실행
- PRFAQ와의 일관성 및 기술 완성도 검증
- **Approved** 또는 **Rejected** 결과 반환

### 6단계: 구현 시작

**PRFAQ + PRD 모두 Approved 상태일 때만 구현을 시작합니다.**

## 템플릿 위치

- PRFAQ 템플릿: `skills/solapi-working-backwards/templates/prfaq-template.md`
- PRD 템플릿: `skills/solapi-working-backwards/templates/prd-template.md`

## 문서 저장 위치

모든 문서는 다음 경로에 저장됩니다:
```
docs/working-backwards/
├── PRFAQ-{feature-slug}-{YYYY-MM-DD}.md
└── PRD-{feature-slug}-{YYYY-MM-DD}.md
```

## 명령어 요약

| 명령어 | 설명 |
|--------|------|
| `/solapi-working-backwards:prfaq-new [기능명]` | 새 PRFAQ 생성 |
| `/solapi-working-backwards:prfaq-validate` | PRFAQ 검증 |
| `/solapi-working-backwards:prd-new [기능명]` | PRD 생성 |
| `/solapi-working-backwards:prd-validate` | PRD 검증 |
| `/solapi-working-backwards:doc-list` | 문서 목록 |
| `/solapi-working-backwards:doc-status [기능명]` | 승인 상태 확인 |

## 반려 시 대응

검증에서 반려되면:
1. 반려 사유를 확인합니다
2. 해당 문서를 수정합니다
3. 다시 검증을 요청합니다

반려는 품질을 보장하기 위한 과정입니다. 명확한 고객 중심 사고가 확인될 때까지 반복합니다.

---

**중요**: 이 프로세스를 건너뛰고 바로 구현을 시도하면 hooks에 의해 차단됩니다.
PRFAQ와 PRD가 모두 승인된 상태에서만 코드 작성이 허용됩니다.
