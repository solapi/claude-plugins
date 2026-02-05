# SOLAPI Claude Plugins

A collection of Claude Code plugins provided by SOLAPI.

[한국어 문서 (Korean)](./README.ko.md)

## Quick Start

**1. Add Plugin Marketplace**
```
/plugin marketplace add https://github.com/solapi/claude-plugins
```

**2. Install Plugin**
```
/plugin install solapi-working-backwards
```

**3. Start Using**
```
# Create new PRFAQ with Working Backwards plugin
/solapi-working-backwards:prfaq-new

# Create PRD document
/solapi-working-backwards:prd-new

# Check document status
/solapi-working-backwards:doc-status
```

## Plugin List

| Plugin | Description |
|--------|-------------|
| [solapi-working-backwards](./plugins/solapi-working-backwards/) | Applies Amazon's Working Backwards philosophy |

## Structure

```
solapi-plugins/
├── .claude-plugin/
│   └── marketplace.json      # Marketplace configuration
├── plugins/
│   └── solapi-working-backwards/
│       ├── .claude-plugin/
│       │   └── plugin.json   # Plugin metadata
│       ├── agents/           # Agent definitions
│       ├── commands/         # Slash commands
│       ├── hooks/            # Pre/Post tool hooks
│       └── skills/           # Skill definitions
├── README.md                 # This file (English)
└── README.ko.md              # Korean documentation
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License
