# SOLAPI Claude Plugins

SOLAPI에서 제공하는 Claude Code 플러그인 모음입니다.

[English Documentation](./README.md)

## Quick Start

**1. 플러그인 마켓플레이스 추가**
```
/plugin marketplace add https://github.com/solapi/claude-plugins
```

**2. 플러그인 설치**
```
/plugin install solapi-working-backwards
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

| 플러그인 | 설명 |
|---------|------|
| [solapi-working-backwards](./plugins/solapi-working-backwards/) | Amazon의 Working Backwards 철학 적용 |

## 구조

```
solapi-plugins/
├── .claude-plugin/
│   └── marketplace.json      # 마켓플레이스 설정
├── plugins/
│   └── solapi-working-backwards/
│       ├── .claude-plugin/
│       │   └── plugin.json   # 플러그인 메타데이터
│       ├── agents/           # 에이전트 정의
│       ├── commands/         # 슬래시 명령어
│       ├── hooks/            # Pre/Post 도구 훅
│       └── skills/           # 스킬 정의
├── README.md                 # 영문 문서
└── README.ko.md              # 한국어 문서 (이 파일)
```

## 기여

기여를 환영합니다! Pull Request를 자유롭게 제출해주세요.

## 라이선스

MIT License
