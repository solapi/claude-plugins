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
/working-backwards:prfaq-new

# PRD 문서 생성
/working-backwards:prd-new

# 문서 상태 확인
/working-backwards:doc-status
```

## 플러그인 목록

| 플러그인 | 설명 | 버전 |
|---------|------|------|
| [working-backwards](./working-backwards/) | Amazon의 Working Backwards 철학 적용 | 1.0.0 |

## 디렉토리 구조

```
solapi-plugins/
├── .claude-plugin/
│   └── marketplace.json      # 마켓플레이스 매니페스트
├── working-backwards/        # Working Backwards 플러그인
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── skills/
│   ├── commands/
│   ├── agents/
│   ├── hooks/
│   └── README.md
├── [future-plugin]/          # 향후 추가될 플러그인
│   ├── .claude-plugin/
│   │   └── plugin.json
│   └── ...
└── README.md
```

## 새 플러그인 추가 방법

1. 루트에 새 플러그인 디렉토리 생성
   ```bash
   mkdir -p new-plugin/.claude-plugin
   ```

2. 플러그인 매니페스트 작성
   ```bash
   # new-plugin/.claude-plugin/plugin.json
   {
     "name": "new-plugin",
     "displayName": "New Plugin",
     "version": "1.0.0",
     "description": "플러그인 설명"
   }
   ```

3. 마켓플레이스에 등록
   ```jsonc
   // .claude-plugin/marketplace.json의 plugins 배열에 추가
   {
     "name": "new-plugin",
     "displayName": "New Plugin",
     "source": "./new-plugin",
     "version": "1.0.0",
     "description": "플러그인 설명"
   }
   ```

## 플러그인 개발 가이드

각 플러그인은 다음 구조를 따릅니다:

```
plugin-name/
├── .claude-plugin/
│   └── plugin.json           # 필수: 플러그인 매니페스트
├── skills/                   # 선택: Agent Skills
│   └── skill-name/
│       ├── SKILL.md
│       └── templates/
├── commands/                 # 선택: Slash Commands
│   └── command-name.md
├── agents/                   # 선택: Custom Agents
│   └── agent-name.md
├── hooks/                    # 선택: Lifecycle Hooks
│   ├── hooks.json
│   └── scripts/
└── README.md                 # 권장: 플러그인 문서
```

### plugin.json 필수 필드

```jsonc
{
  "name": "plugin-name",        // 고유 ID (kebab-case)
  "version": "1.0.0",           // Semantic versioning
  "description": "플러그인 설명"
}
```

### 네임스페이싱

- 모든 명령어는 자동으로 `/<plugin-name>:<command>` 형식으로 네임스페이싱됩니다.
- 플러그인 간 충돌을 방지합니다.

## 기여

이슈와 PR은 [GitHub](https://github.com/solapi/claude-plugins)에서 환영합니다.

## 라이선스

MIT License
