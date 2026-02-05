# Working Backwards Plugin

A plugin that enforces Amazon's **Working Backwards** philosophy in Claude Code.

[한국어 문서 (Korean)](./README.ko.md)

> "Start from the customer and work backwards to reach the minimum technical requirements"

## Overview

This plugin enforces the following process for feature implementation/addition/modification/deletion requests:

1. **PRFAQ** (Press Release + FAQ) document creation
2. **PRD** (Product Requirements Document) creation
3. **Validation and rejection** process

## Installation

```bash
# Clone from GitHub
git clone https://github.com/solapi/claude-plugins.git

# Load plugin when running Claude Code
claude --plugin-dir ./claude-plugins/plugins/solapi-working-backwards
```

## Workflow

```
[Feature Request] → [Write PRFAQ] → [Validate PRFAQ] → [Write PRD] → [Validate PRD] → [Start Implementation]
                                          ↓ Rejected                      ↓ Rejected
                                     [Revise PRFAQ]                  [Revise PRD]
```

## Amazon's 5 Key Validation Questions

Before implementing a feature, you must clearly answer the following questions:

1. **Who is the customer?**
2. **What is the customer's problem or opportunity?**
3. **What is the most important customer benefit?**
4. **How do you know the customer wants this?**
5. **What does the customer experience look like?**

→ If you cannot clearly answer these questions, it will be **rejected**.

## Commands

| Command | Description |
|---------|-------------|
| `/solapi-working-backwards:prfaq-new [feature_name]` | Create new PRFAQ |
| `/solapi-working-backwards:prfaq-validate` | Validate PRFAQ |
| `/solapi-working-backwards:prd-new [feature_name]` | Create PRD |
| `/solapi-working-backwards:prd-validate` | Validate PRD |
| `/solapi-working-backwards:doc-list` | List documents |
| `/solapi-working-backwards:doc-status [feature_name]` | Check approval status |

## Auto Triggers

The Working Backwards skill automatically activates for requests like:

- "feature add/implement/create/develop/modify/delete"
- "new feature"
- "add feature"
- "build feature"

## Validation Criteria

### PRFAQ Validation Checklist

| Item | Criteria |
|------|----------|
| Customer Definition | Specific customer segment/persona specified |
| Problem Definition | Customer's specific problem/pain point described |
| Customer Benefits | At least 1 clear benefit defined |
| Validation Evidence | Data/evidence/assumptions for customer needs |
| Customer Experience | Before/After scenario exists |
| Success Metrics | Measurable KPI defined |

### PRD Validation Checklist

| Item | Criteria |
|------|----------|
| PRFAQ Consistency | PRD matches PRFAQ customer benefits/experience |
| Technical Requirements | At least 1 clear functional requirement |
| Scope Definition | In Scope/Out of Scope clearly distinguished |
| Dependency Identification | Internal/external dependencies identified |
| Risk Factors | At least 1 risk and mitigation |
| Acceptance Criteria | At least 1 Acceptance Criteria |

## Rejection Conditions

1. Unclear who the customer is
2. Vague customer problem/benefits
3. No success metrics
4. PRFAQ-PRD inconsistency
5. Missing technical requirements

## Document Storage Location

All documents are saved in the `docs/working-backwards/` directory:

```
docs/working-backwards/
├── PRFAQ-{feature-slug}-{YYYY-MM-DD}.md
└── PRD-{feature-slug}-{YYYY-MM-DD}.md
```

Example:
- `docs/working-backwards/PRFAQ-user-authentication-2026-02-05.md`
- `docs/working-backwards/PRD-user-authentication-2026-02-05.md`

## Hooks

This plugin checks approval status before code modification via PreToolUse hooks:

- Checks PRFAQ+PRD approval before using `Write` or `Edit` tools
- Blocks implementation and displays guidance message if not approved

### Excluded Paths

The following files can be modified without approval:
- Working Backwards documents (`docs/working-backwards/`)
- Markdown files (`.md`)
- Configuration files (`.json`, `.yml`, `.yaml`)
- Test files (`test/`, `__test__/`, `.spec.`, `.test.`)
- Other document files (`README`, `LICENSE`, `CHANGELOG`)

## Usage Examples

### New Feature Request

```
User: "I want to add user authentication"

Claude: Starting Working Backwards process.
        First, let's create a PRFAQ.

        1. Who is the customer for this feature?
```

### Rejection Scenario

```
User: "Add login feature"
Claude: After PRFAQ creation and validation...

❌ Rejection Reasons:
- Customer unclear (regular user? admin?)
- No success metrics
- Unclear differentiation from existing authentication

User: [Revise PRFAQ]
Claude: Re-validation...
✅ PRFAQ Approved → Create PRD → Validate PRD → Start Implementation
```

## Plugin Structure

```
solapi-working-backwards/
├── .claude-plugin/
│   └── plugin.json           # Plugin manifest
├── skills/
│   └── solapi-working-backwards/
│       ├── SKILL.md          # Main skill (auto-trigger)
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
│   ├── validator.md          # Validation specialist agent
│   └── interviewer.md        # Interview agent
├── hooks/
│   ├── hooks.json
│   └── scripts/
│       └── check-approval.sh
├── README.md                 # This file (English)
└── README.ko.md              # Korean documentation
```

## FAQ

### Q: Do small bug fixes require PRFAQ too?

A: Test files, documents, and configuration files are excluded. Small bug fixes can be modified without approval if the file path matches exclusion patterns. However, new features or significant changes require PRFAQ/PRD.

### Q: How do I apply this to existing projects?

A: It only applies to new feature additions or significant changes. Maintenance of existing code is not affected.

### Q: Can I customize the validation criteria?

A: Yes, you can adjust validation criteria by modifying the `agents/validator.md` file.

## License

MIT License
