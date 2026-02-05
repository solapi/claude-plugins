---
name: prd-new
description: 승인된 PRFAQ를 기반으로 새로운 PRD (Product Requirements Document)를 생성합니다.
arguments:
  - name: feature_name
    description: 기능 이름 (PRFAQ와 동일해야 함)
    required: true
---

# 새 PRD 생성

## 지시사항

승인된 PRFAQ를 기반으로 PRD 문서를 생성합니다.

### 전제 조건

⚠️ **PRD는 PRFAQ가 Approved 상태일 때만 생성할 수 있습니다.**

### 1단계: PRFAQ 승인 상태 확인

해당 기능의 PRFAQ를 찾아 상태를 확인합니다:

```bash
grep -l "{feature_name}" docs/working-backwards/PRFAQ-*.md 2>/dev/null
```

PRFAQ 파일을 읽어 Status가 `Approved`인지 확인합니다.

#### PRFAQ 미승인 시:

```
❌ PRD 생성 불가

해당 기능의 PRFAQ가 아직 승인되지 않았습니다.

현재 상태: {Draft|In Review|Rejected}
PRFAQ 파일: {파일 경로}

다음 단계:
1. PRFAQ를 완성하세요.
2. `/working-backwards:prfaq-validate` 명령으로 검증을 받으세요.
3. Approved 상태가 되면 PRD 생성이 가능합니다.
```

#### PRFAQ가 없는 경우:

```
❌ PRD 생성 불가

해당 기능의 PRFAQ가 존재하지 않습니다.

다음 단계:
1. `/working-backwards:prfaq-new {feature_name}` 명령으로 PRFAQ를 먼저 작성하세요.
2. PRFAQ가 승인되면 PRD 생성이 가능합니다.
```

### 2단계: PRD 템플릿 로드

PRD 템플릿을 읽어옵니다:
- 경로: `skills/working-backwards/templates/prd-template.md`

### 3단계: PRFAQ에서 정보 추출

승인된 PRFAQ에서 다음 정보를 추출하여 PRD에 반영합니다:

- **기능 요약**: Press Release의 요약 섹션
- **핵심 고객 혜택**: 5가지 핵심 질문의 "가장 중요한 고객 혜택"
- **고객 정의**: 고객 세그먼트/페르소나
- **성공 지표**: Internal FAQ의 성공 지표

### 4단계: 사용자와 대화형 작성

다음 순서로 사용자와 대화하며 PRD를 작성합니다:

1. **범위 정의**:
   - "이 기능의 **In Scope** (이번에 구현할 것)은 무엇인가요?"
   - "**Out of Scope** (이번에 제외할 것)은 무엇인가요?"

2. **기능 요구사항**:
   - "구현해야 할 **핵심 기능**들을 나열해주세요."
   - 각 기능에 대해 우선순위(High/Medium/Low) 확인

3. **비기능 요구사항**:
   - "성능 요구사항이 있나요? (응답 시간, 처리량 등)"
   - "보안 요구사항이 있나요? (인증, 인가, 데이터 보호)"
   - "확장성/가용성 요구사항이 있나요?"

4. **시스템 설계**:
   - "기존 시스템과 어떻게 통합되나요?"
   - "새로운 데이터 모델이 필요한가요?"
   - "새로운 API가 필요한가요?"

5. **의존성**:
   - "필요한 내부 모듈/서비스가 있나요?"
   - "외부 라이브러리/서비스가 필요한가요?"

6. **위험 요소**:
   - "예상되는 기술적 위험은 무엇인가요?"
   - "비즈니스적 위험은 무엇인가요?"
   - "각 위험에 대한 대응책은?"

7. **검증 기준**:
   - "이 기능이 완료되었다고 판단하는 기준은 무엇인가요?"
   - Gherkin 형식(Given-When-Then)으로 시나리오 작성

8. **테스트 전략**:
   - "어떤 종류의 테스트가 필요한가요?"

### 5단계: PRFAQ와의 일관성 확인

PRD 작성 중 PRFAQ와의 일관성을 확인합니다:

- PRD의 목표가 PRFAQ의 고객 혜택과 일치하는가?
- PRD의 범위가 PRFAQ에서 약속한 기능을 포함하는가?
- PRD의 성공 지표가 PRFAQ의 지표와 일치하는가?

불일치가 발견되면 사용자에게 알리고 조정합니다.

### 6단계: 문서 저장

완성된 PRD를 저장합니다:

```
docs/working-backwards/PRD-{feature-slug}-{YYYY-MM-DD}.md
```

PRD 문서에 PRFAQ 참조 경로를 반드시 포함합니다.

### 7단계: 다음 단계 안내

```
✅ PRD 문서가 생성되었습니다.

📄 파일 위치: docs/working-backwards/PRD-{feature-slug}-{date}.md
📋 상태: Draft
🔗 PRFAQ 참조: {PRFAQ 파일 경로}

다음 단계:
1. PRD 내용을 검토하고 필요시 수정하세요.
2. 준비가 되면 `/working-backwards:prd-validate` 명령으로 검증을 요청하세요.

검증을 통과해야 구현을 시작할 수 있습니다.
```

## 주의사항

- PRD는 반드시 승인된 PRFAQ에 기반해야 합니다.
- PRFAQ에서 정의한 고객 혜택을 달성하는 데 집중합니다.
- 기술적 구현 세부사항보다 "무엇을" 구현할지에 초점을 맞춥니다.
- "어떻게" 구현할지는 구현 단계에서 결정합니다.
