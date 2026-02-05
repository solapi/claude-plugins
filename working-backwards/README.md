# Working Backwards Plugin

Amazon의 **Working Backwards** 철학을 Claude Code에서 강제 적용하는 플러그인입니다.

> "고객에서 출발하여 역으로 작업하면서 최소한의 기술 요구사항에 도달"

## 개요

이 플러그인은 기능 구현/추가/수정/삭제 요청 시 다음 프로세스를 강제합니다:

1. **PRFAQ** (Press Release + FAQ) 문서 작성
2. **PRD** (Product Requirements Document) 작성
3. **검증 및 반려** 프로세스 수행

## 설치

```bash
# GitHub에서 클론
git clone https://github.com/solapi/claude-plugins.git

# Claude Code 실행 시 플러그인 로드
claude --plugin-dir ./claude-plugins/working-backwards
```

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

## 명령어

| 명령어 | 설명 |
|--------|------|
| `/working-backwards:prfaq-new [기능명]` | 새 PRFAQ 생성 |
| `/working-backwards:prfaq-validate` | PRFAQ 검증 |
| `/working-backwards:prd-new [기능명]` | PRD 생성 |
| `/working-backwards:prd-validate` | PRD 검증 |
| `/working-backwards:doc-list` | 문서 목록 조회 |
| `/working-backwards:doc-status [기능명]` | 승인 상태 확인 |

## 자동 트리거

다음과 같은 요청 시 자동으로 Working Backwards 스킬이 활성화됩니다:

- "기능 추가/구현/만들어/개발/수정/삭제"
- "feature add/implement/create/develop/modify/delete"
- "새로운 기능", "new feature"
- "추가해줘", "만들어줘", "구현해줘", "개발해줘"

## 검증 기준

### PRFAQ 검증 체크리스트

| 항목 | 기준 |
|------|------|
| 고객 정의 | 구체적인 고객 세그먼트/페르소나가 명시됨 |
| 문제 정의 | 고객의 구체적인 문제/고충점이 기술됨 |
| 고객 혜택 | 최소 1개 이상의 명확한 혜택 정의됨 |
| 검증 근거 | 고객 니즈의 데이터/근거/가정이 있음 |
| 고객 경험 | Before/After 시나리오가 있음 |
| 성공 지표 | 측정 가능한 KPI가 정의됨 |

### PRD 검증 체크리스트

| 항목 | 기준 |
|------|------|
| PRFAQ 일관성 | PRD가 PRFAQ의 고객 혜택/경험과 일치 |
| 기술 요구사항 | 최소 1개 이상의 명확한 기능 요구사항 |
| 범위 정의 | In Scope/Out of Scope 명확히 구분 |
| 의존성 식별 | 내부/외부 의존성 식별됨 |
| 위험 요소 | 최소 1개 이상의 위험과 대응책 |
| 검증 기준 | 최소 1개 이상의 Acceptance Criteria |

## 반려 조건

1. 고객이 누구인지 불명확
2. 고객 문제/혜택이 모호
3. 성공 지표 없음
4. PRFAQ-PRD 간 불일치
5. 기술 요구사항 누락

## 문서 저장 위치

모든 문서는 `docs/working-backwards/` 디렉토리에 저장됩니다:

```
docs/working-backwards/
├── PRFAQ-{feature-slug}-{YYYY-MM-DD}.md
└── PRD-{feature-slug}-{YYYY-MM-DD}.md
```

예시:
- `docs/working-backwards/PRFAQ-user-authentication-2026-02-05.md`
- `docs/working-backwards/PRD-user-authentication-2026-02-05.md`

## Hooks

이 플러그인은 PreToolUse 훅을 통해 코드 수정 전 승인 상태를 확인합니다:

- `Write` 또는 `Edit` 도구 사용 전 PRFAQ+PRD 승인 여부 확인
- 미승인 시 구현 차단 및 안내 메시지 출력

### 제외 경로

다음 파일들은 승인 확인 없이 수정 가능합니다:
- Working Backwards 문서 (`docs/working-backwards/`)
- 마크다운 파일 (`.md`)
- 설정 파일 (`.json`, `.yml`, `.yaml`)
- 테스트 파일 (`test/`, `__test__/`, `.spec.`, `.test.`)
- 기타 문서 파일 (`README`, `LICENSE`, `CHANGELOG`)

## 사용 예시

### 새 기능 추가 요청

```
사용자: "사용자 인증 기능을 추가하고 싶어"

Claude: Working Backwards 프로세스를 시작합니다.
        먼저 PRFAQ를 작성하겠습니다.

        1. 이 기능의 고객은 누구인가요?
```

### 반려 시나리오

```
사용자: "로그인 기능 추가해줘"
Claude: PRFAQ 작성 후 검증...

❌ 반려 사유:
- 고객이 불명확 (일반 사용자? 관리자?)
- 성공 지표 없음
- 기존 인증 방식과의 차별점 불명확

사용자: [PRFAQ 수정]
Claude: 재검증...
✅ PRFAQ 승인 → PRD 작성 → PRD 검증 → 구현 시작
```

## 플러그인 구조

```
working-backwards/
├── .claude-plugin/
│   └── plugin.json           # 플러그인 매니페스트
├── skills/
│   └── working-backwards/
│       ├── SKILL.md          # 메인 스킬 (자동 트리거)
│       └── templates/
│           ├── prfaq-template.md
│           └── prd-template.md
├── commands/
│   ├── prfaq-new.md
│   ├── prfaq-validate.md
│   ├── prd-new.md
│   ├── prd-validate.md
│   ├── doc-list.md
│   └── doc-status.md
├── agents/
│   └── validator.md          # 검증 전문 에이전트
├── hooks/
│   ├── hooks.json
│   └── scripts/
│       └── check-approval.sh
└── README.md
```

## FAQ

### Q: 작은 버그 수정도 PRFAQ가 필요한가요?

A: 테스트 파일, 문서, 설정 파일 등은 제외됩니다. 작은 버그 수정의 경우 해당 파일 경로가 제외 패턴에 해당하면 승인 없이 수정 가능합니다. 그러나 새로운 기능이나 중요한 변경사항은 PRFAQ/PRD가 필요합니다.

### Q: 기존 프로젝트에 어떻게 적용하나요?

A: 새로운 기능 추가나 중요한 변경사항에 대해서만 적용됩니다. 기존 코드의 유지보수는 영향받지 않습니다.

### Q: 검증 기준을 커스터마이즈할 수 있나요?

A: `agents/validator.md` 파일을 수정하여 검증 기준을 조정할 수 있습니다.

## 라이선스

MIT License
