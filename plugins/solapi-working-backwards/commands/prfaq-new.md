---
name: prfaq-new
description: Creates a new PRFAQ (Press Release + FAQ) document.
arguments:
  - name: feature_name
    description: Feature name (e.g., user-authentication)
    required: true
---

# Create New PRFAQ

## Instructions

The user has requested to create a PRFAQ document for a new feature.

### Step 1: Verify Document Directory

```bash
mkdir -p docs/working-backwards
```

### Step 2: Check for Existing Documents

First, check if a PRFAQ already exists for the same feature:

```bash
ls -la docs/working-backwards/PRFAQ-*{feature_name}* 2>/dev/null || echo "No existing PRFAQ found"
```

If an existing document is found, notify the user and ask whether to modify the existing document.

### Step 3: Load PRFAQ Template

Load the PRFAQ template:
- Path: `skills/solapi-working-backwards/templates/prfaq-template.md`

### Step 4: Interactive Writing with User (Using AskUserQuestion Tool)

**Important**: All questions must be asked using the **AskUserQuestion tool**.
Do not ask questions through text output only.

Follow the interviewer agent (`agents/interviewer.md`) guide to conduct the interview in the following order:

1. **Feature Overview** (Using AskUserQuestion):
   ```
   AskUserQuestion: "Please briefly describe the feature you want to implement. What problem does it solve or what value does it provide?"
   ```

2. **5 Key Questions** (Each using AskUserQuestion, in order):
   - Q1: Customer Definition → Receive answer → Follow-up if insufficient
   - Q2: Problem/Opportunity Definition → Receive answer → Follow-up if insufficient
   - Q3: Customer Benefits → Receive answer → Follow-up if insufficient
   - Q4: Validation Evidence → Receive answer → Follow-up if insufficient
   - Q5: Customer Experience (Before/After) → Receive answer → Follow-up if insufficient

3. **Press Release Information** (Using AskUserQuestion):
   ```
   AskUserQuestion: "If this feature were to be released, what would you like the press release headline to be?"
   ```

4. **Success Metrics** (Using AskUserQuestion):
   ```
   AskUserQuestion: "How will you measure the success of this feature? Please provide specific KPIs."
   ```

5. Write the PRFAQ document based on the collected information

### Step 5: Save Document

Save the completed PRFAQ:

```
docs/working-backwards/PRFAQ-{feature-slug}-{YYYY-MM-DD}.md
```

Filename rules:
- feature-slug: Convert feature name to kebab-case
- YYYY-MM-DD: Today's date

### Step 6: Provide Next Steps

After saving the document, inform the user:

```
✅ PRFAQ document has been created.

📄 File location: docs/working-backwards/PRFAQ-{feature-slug}-{date}.md
📋 Status: Draft

Next steps:
1. Review the PRFAQ content and make modifications if needed.
2. When ready, request validation with `/solapi-working-backwards:prfaq-validate` command.

Validation must pass before proceeding to PRD creation.
```

## Notes

- If any of the 5 key questions are unclear, ask follow-up questions to clarify.
- Record "I don't know" or vague answers as-is, but inform that they may become rejection reasons during validation.
- All sections in the template must be filled. Mark items that don't apply as "N/A" or "To be defined".
