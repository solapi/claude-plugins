---
name: prfaq-validate
description: Validates the PRFAQ document and returns approval/rejection results.
arguments:
  - name: file_path
    description: Path to the PRFAQ file to validate (defaults to most recent Draft document if omitted)
    required: false
---

# PRFAQ Validation

## Instructions

Validate the PRFAQ document against Amazon's 5 key questions criteria.

### Step 1: Identify Target Document

If file path is specified:
- Read that file.

If file path is not specified:
- Find the most recent PRFAQ document in `docs/working-backwards/` directory.
- Prioritize documents in Draft or In Review status.

```bash
ls -t docs/working-backwards/PRFAQ-*.md 2>/dev/null | head -5
```

### Step 2: Invoke Validator Agent

Use the validator agent (`agents/validator.md`) to perform validation.

### Step 3: Verify Validation Checklist

Validate the following items:

#### Required Validation Items (Reject if any fail)

| Item | Validation Criteria |
|------|---------------------|
| **Customer Definition** | Is a specific customer segment/persona specified? Fail if only generic terms like "users", "customers" are used |
| **Problem Definition** | Is the customer's specific problem/pain point described? |
| **Customer Benefits** | Is at least one clear customer benefit defined? |
| **Validation Evidence** | Is there data/evidence/assumptions that the customer wants this? |
| **Customer Experience** | Is there a Before/After scenario? |
| **Success Metrics** | Is at least one measurable KPI defined? |

#### Recommended Validation Items (Warning only)

| Item | Validation Criteria |
|------|---------------------|
| Press Release completeness | Are all sections filled? |
| Internal FAQ | Are there at least 3 Q&As? |
| External FAQ | Are there at least 3 Q&As? |
| Customer Journey | Is there step-by-step detail? |

### Step 4: Determine Validation Result

#### ✅ Approved
- All required validation items pass
- Update document status to `Approved`
- Record in validation history

#### ❌ Rejected
- One or more required validation items fail
- Update document status to `Rejected`
- Provide specific rejection reasons
- Include improvement suggestions

### Step 5: Report Results

#### Approval Output Format:

```
✅ PRFAQ Validation Result: Approved

📄 Document: {file path}
📅 Validation Date: {YYYY-MM-DD HH:mm}

Validation Results:
✅ Customer Definition: Pass
✅ Problem Definition: Pass
✅ Customer Benefits: Pass
✅ Validation Evidence: Pass
✅ Customer Experience: Pass
✅ Success Metrics: Pass

⚠️ Recommendations:
- {Recommended improvements if any}

Next steps:
- Start PRD creation with `/solapi-working-backwards:prd-new {feature_name}` command.
```

#### Rejection Output Format:

```
❌ PRFAQ Validation Result: Rejected

📄 Document: {file path}
📅 Validation Date: {YYYY-MM-DD HH:mm}

Validation Results:
✅ Customer Definition: Pass
❌ Problem Definition: Fail
   └─ Reason: {specific failure reason}
   └─ Suggestion: {how to fix}
...

Rejection Summary:
1. {Rejection reason 1}
2. {Rejection reason 2}

Next steps:
1. Modify the PRFAQ referring to the rejection reasons above.
2. After modification, run `/solapi-working-backwards:prfaq-validate` command again.
```

### Step 6: Update Document

Update the PRFAQ document based on validation results:

1. Update **Status** field (Draft → Approved/Rejected)
2. Update **Last Updated** field
3. Update **Validation Checklist** check status (⬜ → ✅/❌)
4. Add new row to **Validation History** table

## Detailed Rejection Criteria

### Examples of Unclear Customer:
- ❌ "Users" - Too generic
- ❌ "Developers" - What kind of developers is unclear
- ✅ "Backend developers using Node.js, with 3+ years of experience working at startups"

### Examples of Unclear Problem:
- ❌ "It's inconvenient" - What is inconvenient is unclear
- ❌ "It's needed" - No basis for why it's needed
- ✅ "The current authentication process requires an average of 5 steps, with a 40% drop-off rate"

### Examples of Missing Success Metrics:
- ❌ "Users will like it" - Not measurable
- ❌ "It will improve" - Not specific
- ✅ "50% reduction in login time, 20% decrease in drop-off rate"
