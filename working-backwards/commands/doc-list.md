---
name: doc-list
description: 프로젝트 내 모든 PRFAQ/PRD 문서 목록을 조회합니다.
arguments: []
---

# 문서 목록 조회

## 지시사항

`docs/working-backwards/` 디렉토리의 모든 PRFAQ 및 PRD 문서를 조회하여 목록을 표시합니다.

### 1단계: 문서 디렉토리 확인

```bash
if [ -d "docs/working-backwards" ]; then
  echo "디렉토리 존재"
else
  echo "디렉토리 없음"
fi
```

디렉토리가 없는 경우:
```
📂 Working Backwards 문서가 없습니다.

아직 PRFAQ/PRD 문서가 작성되지 않았습니다.

시작하기:
- `/working-backwards:prfaq-new [기능명]` 명령으로 첫 PRFAQ를 작성하세요.
```

### 2단계: 문서 목록 수집

```bash
ls -la docs/working-backwards/*.md 2>/dev/null
```

### 3단계: 각 문서의 상태 확인

각 문서를 읽어 Status 필드를 추출합니다.

### 4단계: 결과 출력

#### 출력 형식:

```
📂 Working Backwards 문서 목록

=== PRFAQ 문서 ===

| 파일명 | 기능 | 상태 | 생성일 | 최종 수정일 |
|--------|------|------|--------|-------------|
| PRFAQ-user-auth-2026-02-01.md | User Authentication | ✅ Approved | 2026-02-01 | 2026-02-03 |
| PRFAQ-payment-2026-02-05.md | Payment System | 📝 Draft | 2026-02-05 | 2026-02-05 |
| PRFAQ-notification-2026-02-04.md | Notification | ❌ Rejected | 2026-02-04 | 2026-02-04 |

=== PRD 문서 ===

| 파일명 | 기능 | 상태 | PRFAQ 연결 | 생성일 |
|--------|------|------|-----------|--------|
| PRD-user-auth-2026-02-03.md | User Authentication | ✅ Approved | PRFAQ-user-auth-2026-02-01.md | 2026-02-03 |

=== 요약 ===

📊 통계:
- PRFAQ: 3개 (Approved: 1, Draft: 1, Rejected: 1)
- PRD: 1개 (Approved: 1, Draft: 0, Rejected: 0)

🚀 구현 가능 기능:
- ✅ User Authentication (PRFAQ + PRD 모두 Approved)

⏳ 진행 중:
- Payment System: PRFAQ 작성 중 (Draft)

⚠️ 조치 필요:
- Notification: PRFAQ 반려됨 - 수정 후 재검증 필요
```

### 상태 아이콘

| 상태 | 아이콘 |
|------|--------|
| Draft | 📝 |
| In Review | 🔍 |
| Approved | ✅ |
| Rejected | ❌ |

### 5단계: 추가 안내

문서 상태에 따른 다음 단계 안내:

- **Draft PRFAQ가 있는 경우**:
  "PRFAQ를 완성하고 `/working-backwards:prfaq-validate` 명령으로 검증하세요."

- **Rejected PRFAQ가 있는 경우**:
  "반려된 PRFAQ를 수정하고 재검증하세요. `/working-backwards:doc-status [기능명]`으로 반려 사유를 확인하세요."

- **Approved PRFAQ만 있고 PRD가 없는 경우**:
  "PRD 작성을 시작하세요: `/working-backwards:prd-new [기능명]`"

- **Draft PRD가 있는 경우**:
  "PRD를 완성하고 `/working-backwards:prd-validate` 명령으로 검증하세요."

- **모두 Approved인 기능이 있는 경우**:
  "🎉 구현을 시작할 수 있습니다!"
