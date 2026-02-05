---
name: solapi-working-backwards
description: Applies Amazon's Working Backwards philosophy to write and validate PRFAQ and PRD documents before implementing features.
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
  - "add.*feature"
  - "build.*feature"
  - "implement.*feature"
---

# Working Backwards Process

## Overview

Follow Amazon's "Working Backwards" philosophy to proceed with feature implementation.

> "Start from the customer and work backwards to reach the minimum technical requirements"

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

## Starting the Process

### Step 1: Check for Existing Documents

First, check if related PRFAQ/PRD documents exist.

```bash
# Search for existing documents
ls -la docs/working-backwards/ 2>/dev/null || echo "Document directory not found"
```

### Step 2: Write or Check PRFAQ

**If no existing PRFAQ:**
- Create a new PRFAQ with `/solapi-working-backwards:prfaq-new [feature_name]` command

**If existing PRFAQ exists:**
- Check status with `/solapi-working-backwards:doc-status [feature_name]` command

### Step 3: Validate PRFAQ

After writing the PRFAQ, perform validation:
- Run `/solapi-working-backwards:prfaq-validate` command
- Validator agent validates based on 5 key questions
- Returns **Approved** or **Rejected** result

### Step 4: Write PRD (After PRFAQ Approved)

PRD can only be written after PRFAQ is approved:
- Create PRD with `/solapi-working-backwards:prd-new [feature_name]` command

### Step 5: Validate PRD

After writing the PRD, perform validation:
- Run `/solapi-working-backwards:prd-validate` command
- Validates consistency with PRFAQ and technical completeness
- Returns **Approved** or **Rejected** result

### Step 6: Start Implementation

**Implementation starts only when both PRFAQ + PRD are in Approved status.**

## Template Locations

- PRFAQ template: `skills/solapi-working-backwards/templates/prfaq-template.md`
- PRD template: `skills/solapi-working-backwards/templates/prd-template.md`

## Document Storage Location

All documents are saved at the following path:
```
docs/working-backwards/
├── PRFAQ-{feature-slug}-{YYYY-MM-DD}.md
└── PRD-{feature-slug}-{YYYY-MM-DD}.md
```

## Command Summary

| Command | Description |
|---------|-------------|
| `/solapi-working-backwards:prfaq-new [feature_name]` | Create new PRFAQ |
| `/solapi-working-backwards:prfaq-validate` | Validate PRFAQ |
| `/solapi-working-backwards:prd-new [feature_name]` | Create PRD |
| `/solapi-working-backwards:prd-validate` | Validate PRD |
| `/solapi-working-backwards:doc-list` | List documents |
| `/solapi-working-backwards:doc-status [feature_name]` | Check approval status |

## Handling Rejection

When validation rejects:
1. Review the rejection reasons
2. Revise the document
3. Request validation again

Rejection is a process to ensure quality. Repeat until clear customer-centric thinking is confirmed.

---

**Important**: If you attempt to skip this process and implement directly, it will be blocked by hooks.
Code writing is only allowed when both PRFAQ and PRD are in approved status.
