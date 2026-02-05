---
name: doc-status
description: Checks the PRFAQ/PRD document status for a specific feature.
arguments:
  - name: feature_name
    description: Feature name (e.g., user-authentication)
    required: true
---

# Document Status Check

## Instructions

Check the detailed status of PRFAQ and PRD documents for a specific feature.

### Step 1: Search for Related Documents

```bash
ls -la docs/working-backwards/*{feature_name}*.md 2>/dev/null
```

### Step 2: If No Documents Found

```
📄 No documents found for "{feature_name}".

Search path: docs/working-backwards/
Search pattern: *{feature_name}*

Possible reasons:
1. Documents for this feature have not been created yet.
2. The feature name may have been specified differently.

Next steps:
- Check the full document list with `/solapi-working-backwards:doc-list` command.
- Create a new PRFAQ with `/solapi-working-backwards:prfaq-new {feature_name}` command.
```

### Step 3: Extract Document Status

Extract the following information from each document:
- Status
- Created date
- Last Updated date
- Validation checklist status
- Validation history

### Step 4: Output Detailed Results

```
📄 "{feature_name}" Document Status

═══════════════════════════════════════════════════════════════

📋 PRFAQ Status

File: docs/working-backwards/PRFAQ-{feature-slug}-{date}.md
Status: {✅ Approved | 📝 Draft | 🔍 In Review | ❌ Rejected}
Created: {YYYY-MM-DD}
Last Updated: {YYYY-MM-DD}

Validation Checklist:
  ✅ Is the customer clearly defined?
  ✅ Is the customer problem specifically described?
  ❌ Does the solution solve the problem?
  ⬜ Are customer benefits clear?
  ⬜ Are success metrics defined?
  ⬜ Does the FAQ address key questions?

Validation History:
  | Date | Result | Notes |
  |------|--------|-------|
  | 2026-02-01 | Rejected | Solution needs more detail |
  | 2026-02-03 | Approved | |

═══════════════════════════════════════════════════════════════

📋 PRD Status

{If PRD exists}
File: docs/working-backwards/PRD-{feature-slug}-{date}.md
Status: {✅ Approved | 📝 Draft | 🔍 In Review | ❌ Rejected}
PRFAQ Reference: {PRFAQ file path}
Created: {YYYY-MM-DD}
Last Updated: {YYYY-MM-DD}

Validation Checklist:
  ✅ Is it consistent with PRFAQ?
  ✅ Are technical requirements clear?
  ✅ Is scope clearly defined?
  ⬜ Are dependencies identified?
  ⬜ Are there risk factors and mitigation strategies?
  ⬜ Are there acceptance criteria?

Validation History:
  | Date | Result | Notes |
  |------|--------|-------|
  | 2026-02-05 | Draft | Initial creation |

{If PRD does not exist}
❌ PRD has not been created yet.

═══════════════════════════════════════════════════════════════

🎯 Current Stage and Next Actions

{Guidance based on status}
```

### Step 5: Status-Specific Guidance Messages

#### PRFAQ Draft:
```
📍 Current Stage: PRFAQ in progress

Next actions:
1. Complete the PRFAQ document.
2. Request validation with `/solapi-working-backwards:prfaq-validate` command.
```

#### PRFAQ Rejected:
```
📍 Current Stage: PRFAQ needs revision

Rejection reason:
- {Most recent rejection reason from validation history}

Next actions:
1. Revise the PRFAQ referring to the rejection reason above.
2. Request re-validation with `/solapi-working-backwards:prfaq-validate` command.
```

#### PRFAQ Approved, No PRD:
```
📍 Current Stage: Awaiting PRD creation

Next actions:
1. Create PRD with `/solapi-working-backwards:prd-new {feature_name}` command.
```

#### PRD Draft:
```
📍 Current Stage: PRD in progress

Next actions:
1. Complete the PRD document.
2. Request validation with `/solapi-working-backwards:prd-validate` command.
```

#### PRD Rejected:
```
📍 Current Stage: PRD needs revision

Rejection reason:
- {Most recent rejection reason from validation history}

Next actions:
1. Revise the PRD referring to the rejection reason above.
2. Request re-validation with `/solapi-working-backwards:prd-validate` command.
```

#### Both PRFAQ + PRD Approved:
```
🎉 Ready for Implementation!

✅ PRFAQ: Approved
✅ PRD: Approved

You can now start writing code.
Refer to the PRD functional requirements and acceptance criteria.

Reference documents:
- PRFAQ: {file path}
- PRD: {file path}
```
