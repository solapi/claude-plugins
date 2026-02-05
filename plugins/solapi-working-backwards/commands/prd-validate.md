---
name: prd-validate
description: Validates the PRD document and returns approval/rejection results.
arguments:
  - name: file_path
    description: Path to the PRD file to validate (defaults to most recent Draft document if omitted)
    required: false
---

# PRD Validation

## Instructions

Validate the PRD document against PRFAQ consistency and technical completeness criteria.

### Step 1: Identify Target Document

If file path is specified:
- Read that file.

If file path is not specified:
- Find the most recent PRD document in `docs/working-backwards/` directory.
- Prioritize documents in Draft or In Review status.

```bash
ls -t docs/working-backwards/PRD-*.md 2>/dev/null | head -5
```

### Step 2: Verify Linked PRFAQ

Verify the PRFAQ referenced in the PRD document:
- Does the PRFAQ exist?
- Is the PRFAQ in Approved status?

If PRFAQ is not in Approved status, reject immediately:

```
❌ PRD Validation Failed: Prerequisites not met

The linked PRFAQ is not in approved status.

PRFAQ file: {file path}
PRFAQ status: {current status}

Next steps:
1. Get the PRFAQ approved first.
2. Run `/solapi-working-backwards:prfaq-validate` command.
```

### Step 3: Invoke Validator Agent

Use the validator agent (`agents/validator.md`) to perform validation.

### Step 4: Verify Validation Checklist

#### Required Validation Items (Reject if any fail)

| Item | Validation Criteria |
|------|---------------------|
| **PRFAQ Consistency** | Do the PRD goals/scope align with PRFAQ customer benefits/experience? |
| **Technical Requirements** | Is at least one functional requirement clearly defined? |
| **Scope Definition** | Are In Scope and Out of Scope clearly distinguished? |
| **Dependency Identification** | Are internal/external dependencies identified? (Specify "None" if none exist) |
| **Risk Factors** | Is there at least one risk factor and mitigation strategy? |
| **Acceptance Criteria** | Is there at least one Acceptance Criteria? |

#### Consistency Validation Details

| PRFAQ Item | PRD Item | Validation |
|------------|----------|------------|
| Customer Definition | Feature Target | Are they the same? |
| Key Benefits | Functional Requirements | Do they achieve the benefits? |
| Success Metrics | Acceptance Criteria | Can the metrics be measured? |
| Customer Experience | User Flow | Does it implement the experience? |

#### Recommended Validation Items (Warning only)

| Item | Validation Criteria |
|------|---------------------|
| Non-Functional Requirements | At least one of performance/security/scalability defined |
| System Design | Architecture or data model defined |
| Test Strategy | Test types and scope defined |
| Implementation Plan | Milestones or work breakdown defined |

### Step 5: Determine Validation Result

#### ✅ Approved
- All required validation items pass
- PRFAQ consistency confirmed
- Update document status to `Approved`
- Record in validation history

#### ❌ Rejected
- One or more required validation items fail
- Or inconsistency with PRFAQ found
- Update document status to `Rejected`
- Provide specific rejection reasons
- Include improvement suggestions

### Step 6: Report Results

#### Approval Output Format:

```
✅ PRD Validation Result: Approved

📄 Document: {file path}
🔗 PRFAQ: {PRFAQ file path}
📅 Validation Date: {YYYY-MM-DD HH:mm}

Validation Results:
✅ PRFAQ Consistency: Pass
✅ Technical Requirements: Pass (N defined)
✅ Scope Definition: Pass
✅ Dependency Identification: Pass
✅ Risk Factors: Pass (N identified)
✅ Acceptance Criteria: Pass (N defined)

⚠️ Recommendations:
- {Recommended improvements if any}

🎉 Both PRFAQ and PRD have been approved!
You can now start implementation.

Next steps:
- Start writing code.
- Refer to the PRD functional requirements and acceptance criteria.
```

#### Rejection Output Format:

```
❌ PRD Validation Result: Rejected

📄 Document: {file path}
🔗 PRFAQ: {PRFAQ file path}
📅 Validation Date: {YYYY-MM-DD HH:mm}

Validation Results:
✅ PRFAQ Consistency: Pass
❌ Technical Requirements: Fail
   └─ Reason: {specific failure reason}
   └─ Suggestion: {how to fix}
✅ Scope Definition: Pass
...

PRFAQ-PRD Inconsistency Items:
- {Inconsistency item 1}: PRFAQ says X, PRD says Y
- {Inconsistency item 2}: ...

Rejection Summary:
1. {Rejection reason 1}
2. {Rejection reason 2}

Next steps:
1. Modify the PRD referring to the rejection reasons above.
2. Verify consistency with PRFAQ.
3. After modification, run `/solapi-working-backwards:prd-validate` command again.
```

### Step 7: Update Document

Update the PRD document based on validation results:

1. Update **Status** field (Draft → Approved/Rejected)
2. Update **Last Updated** field
3. Update **Validation Checklist** check status (⬜ → ✅/❌)
4. Add new row to **Validation History** table

## Detailed Rejection Criteria

### PRFAQ Inconsistency Examples:
- ❌ PRFAQ: "50% reduction in login time" → PRD: No performance requirements
- ❌ PRFAQ: "Feature for administrators" → PRD: Targeting general users
- ❌ PRFAQ: "Mobile first" → PRD: Only desktop mentioned

### Insufficient Technical Requirements Examples:
- ❌ "User can log in" - Not specific
- ✅ "FR-1: Login with email/password - Email format validation, minimum 8 character password, lock after 5 failed attempts"

### Insufficient Acceptance Criteria Examples:
- ❌ "Login should work" - Not testable
- ✅ "Given a registered user exists, When logging in with valid credentials, Then a JWT token is returned and redirected to dashboard"
