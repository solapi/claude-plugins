---
name: doc-list
description: Lists all PRFAQ/PRD documents in the project.
arguments: []
---

# Document List

## Instructions

Query all PRFAQ and PRD documents in the `docs/working-backwards/` directory and display the list.

### Step 1: Check Document Directory

```bash
if [ -d "docs/working-backwards" ]; then
  echo "Directory exists"
else
  echo "Directory not found"
fi
```

If directory does not exist:
```
📂 No Working Backwards documents found.

No PRFAQ/PRD documents have been created yet.

Getting started:
- Create your first PRFAQ with `/solapi-working-backwards:prfaq-new [feature_name]` command.
```

### Step 2: Collect Document List

```bash
ls -la docs/working-backwards/*.md 2>/dev/null
```

### Step 3: Check Status of Each Document

Read each document and extract the Status field.

### Step 4: Output Results

#### Output Format:

```
📂 Working Backwards Document List

=== PRFAQ Documents ===

| Filename | Feature | Status | Created | Last Updated |
|----------|---------|--------|---------|--------------|
| PRFAQ-user-auth-2026-02-01.md | User Authentication | ✅ Approved | 2026-02-01 | 2026-02-03 |
| PRFAQ-payment-2026-02-05.md | Payment System | 📝 Draft | 2026-02-05 | 2026-02-05 |
| PRFAQ-notification-2026-02-04.md | Notification | ❌ Rejected | 2026-02-04 | 2026-02-04 |

=== PRD Documents ===

| Filename | Feature | Status | PRFAQ Link | Created |
|----------|---------|--------|------------|---------|
| PRD-user-auth-2026-02-03.md | User Authentication | ✅ Approved | PRFAQ-user-auth-2026-02-01.md | 2026-02-03 |

=== Summary ===

📊 Statistics:
- PRFAQ: 3 (Approved: 1, Draft: 1, Rejected: 1)
- PRD: 1 (Approved: 1, Draft: 0, Rejected: 0)

🚀 Ready for Implementation:
- ✅ User Authentication (Both PRFAQ + PRD Approved)

⏳ In Progress:
- Payment System: PRFAQ in progress (Draft)

⚠️ Action Required:
- Notification: PRFAQ rejected - Needs revision and re-validation
```

### Status Icons

| Status | Icon |
|--------|------|
| Draft | 📝 |
| In Review | 🔍 |
| Approved | ✅ |
| Rejected | ❌ |

### Step 5: Provide Additional Guidance

Provide next step guidance based on document status:

- **If there are Draft PRFAQs**:
  "Complete the PRFAQ and validate with `/solapi-working-backwards:prfaq-validate` command."

- **If there are Rejected PRFAQs**:
  "Revise the rejected PRFAQ and re-validate. Check rejection reasons with `/solapi-working-backwards:doc-status [feature_name]`."

- **If there are Approved PRFAQs but no PRD**:
  "Start PRD creation: `/solapi-working-backwards:prd-new [feature_name]`"

- **If there are Draft PRDs**:
  "Complete the PRD and validate with `/solapi-working-backwards:prd-validate` command."

- **If there are features with both Approved**:
  "🎉 You can start implementation!"
