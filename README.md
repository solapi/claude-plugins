# SOLAPI Claude Plugins

SOLAPI에서 제공하는 Claude Code 플러그인 모음입니다.

## Quick Start

**1. 플러그인 마켓플레이스 추가**
```
/plugin marketplace add https://github.com/solapi/claude-plugins
```

**2. 플러그인 설치**
```
/plugin install solapi-plugins
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

## 라이선스

MIT License
