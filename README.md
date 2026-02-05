# SOLAPI Claude Plugins

SOLAPI에서 제공하는 Claude Code 플러그인 모음입니다.

## Quick Start

**1. 플러그인 마켓플레이스 추가**
```
/plugin marketplace add solapi/claude-plugins
```

**2. 플러그인 설치**
```
/plugin install solapi-working-backwards@solapi-claude-plugins
```

**3. 사용 시작**
```
# Working Backwards 플러그인으로 새 PRFAQ 생성
/solapi-working-backwards:prfaq-new

# PRD 문서 생성
/solapi-working-backwards:prd-new

# 문서 상태 확인
/solapi-working-backwards:doc-status
```

## 플러그인 목록

| 플러그인 | 설명 | 버전 |
|---------|------|------|
| [solapi-working-backwards](./solapi-working-backwards/) | Amazon의 Working Backwards 철학 적용 | 1.0.0 |

## 사용 방법

### 자동 활용 (Automatic)

플러그인 설치 후 다음 기능이 자동으로 작동합니다:

**자동 트리거**
- "기능 추가", "기능 구현", "기능 개발" 등의 요청 시 Working Backwards 프로세스가 자동으로 시작됩니다.
- Claude가 PRFAQ와 PRD 작성을 먼저 안내합니다.

**구현 차단**
- Write/Edit 도구 사용 시 PRFAQ + PRD 승인 상태를 자동으로 확인합니다.
- 문서가 승인되지 않은 상태에서는 코드 구현이 차단됩니다.
- 승인된 문서가 있어야 구현을 진행할 수 있습니다.

### 수동 사용 (Manual Commands)

필요할 때 직접 명령어를 사용할 수 있습니다:

| 명령어 | 설명 |
|--------|------|
| `/solapi-working-backwards:prfaq-new [기능명]` | 새 PRFAQ 문서 생성 |
| `/solapi-working-backwards:prfaq-validate [파일경로]` | PRFAQ 문서 검증 |
| `/solapi-working-backwards:prd-new [기능명]` | 새 PRD 문서 생성 |
| `/solapi-working-backwards:prd-validate [파일경로]` | PRD 문서 검증 |
| `/solapi-working-backwards:doc-list` | 전체 문서 목록 조회 |
| `/solapi-working-backwards:doc-status [기능명]` | 특정 기능의 문서 상태 확인 |

## 워크플로우

기능 구현까지의 전체 흐름:

```
기능 요청 → PRFAQ 작성 → PRFAQ 검증 → PRD 작성 → PRD 검증 → 구현
```

1. **기능 요청**: 새로운 기능 구현을 요청합니다.
2. **PRFAQ 작성**: Press Release와 FAQ를 작성하여 고객 관점에서 기능을 정의합니다.
3. **PRFAQ 검증**: 작성된 PRFAQ가 기준에 부합하는지 확인합니다.
4. **PRD 작성**: 기술적 요구사항과 구현 계획을 담은 PRD를 작성합니다.
5. **PRD 검증**: PRD가 PRFAQ와 일관성이 있는지 확인합니다.
6. **구현**: 승인된 문서를 바탕으로 코드를 구현합니다.

## 라이선스

MIT License
