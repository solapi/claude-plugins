---
name: prd-new
description: Creates a new PRD (Product Requirements Document) based on an approved PRFAQ.
arguments:
  - name: feature_name
    description: Feature name (must match the PRFAQ)
    required: true
---

# Create New PRD

## Instructions

Create a PRD document based on an approved PRFAQ.

### Prerequisites

⚠️ **PRD can only be created when the PRFAQ is in Approved status.**

### Step 1: Verify PRFAQ Approval Status

Find and verify the status of the feature's PRFAQ:

```bash
grep -l "{feature_name}" docs/working-backwards/PRFAQ-*.md 2>/dev/null
```

Read the PRFAQ file and verify that Status is `Approved`.

#### If PRFAQ is not approved:

```
❌ Cannot create PRD

The PRFAQ for this feature has not been approved yet.

Current status: {Draft|In Review|Rejected}
PRFAQ file: {file path}

Next steps:
1. Complete the PRFAQ.
2. Get validation with `/solapi-working-backwards:prfaq-validate` command.
3. PRD creation will be available once Approved status is achieved.
```

#### If PRFAQ does not exist:

```
❌ Cannot create PRD

The PRFAQ for this feature does not exist.

Next steps:
1. Create a PRFAQ first with `/solapi-working-backwards:prfaq-new {feature_name}` command.
2. PRD creation will be available once PRFAQ is approved.
```

### Step 2: Load PRD Template

Load the PRD template:
- Path: `skills/solapi-working-backwards/templates/prd-template.md`

### Step 3: Extract Information from PRFAQ

Extract the following information from the approved PRFAQ and reflect in the PRD:

- **Feature Summary**: Summary section from Press Release
- **Key Customer Benefits**: "Most important customer benefits" from 5 key questions
- **Customer Definition**: Customer segment/persona
- **Success Metrics**: Success metrics from Internal FAQ

### Step 4: Interactive Writing with User (Using AskUserQuestion Tool)

**Important**: All questions must be asked using the **AskUserQuestion tool**.
Do not ask questions through text output only.

Follow the interviewer agent (`agents/interviewer.md`) guide to conduct the interview in the following order:

1. **Scope Definition** (Using AskUserQuestion):
   ```
   AskUserQuestion: "What is the scope (In Scope) for this implementation? And what will be excluded (Out of Scope)?"
   ```

2. **Functional Requirements** (Using AskUserQuestion):
   ```
   AskUserQuestion: "Please list the core features to implement. Also specify the priority (High/Medium/Low) for each feature."
   ```

3. **Non-Functional Requirements** (Using AskUserQuestion):
   ```
   AskUserQuestion: "Are there any non-functional requirements? (Performance: response time/throughput, Security: authentication/authorization, Scalability/Availability, etc.)"
   ```

4. **System Design** (Using AskUserQuestion):
   ```
   AskUserQuestion: "How will this integrate with existing systems? Are new data models or APIs needed?"
   ```

5. **Dependencies** (Using AskUserQuestion):
   ```
   AskUserQuestion: "Are there any required internal modules/services or external libraries/services?"
   ```

6. **Risk Factors** (Using AskUserQuestion):
   ```
   AskUserQuestion: "What are the expected technical/business risks and mitigation strategies?"
   ```

7. **Acceptance Criteria** (Using AskUserQuestion):
   ```
   AskUserQuestion: "What criteria determine that this feature is complete? Please provide at least one scenario in Given-When-Then format."
   ```

8. **Test Strategy** (Using AskUserQuestion):
   ```
   AskUserQuestion: "What types of tests are needed? (Unit tests, integration tests, E2E tests, etc.)"
   ```

9. Write the PRD document based on the collected information

### Step 5: Verify Consistency with PRFAQ

During PRD creation, verify consistency with PRFAQ:

- Do the PRD goals align with PRFAQ customer benefits?
- Does the PRD scope include the features promised in PRFAQ?
- Do the PRD success metrics match PRFAQ metrics?

If inconsistencies are found, notify the user and make adjustments.

### Step 6: Save Document

Save the completed PRD:

```
docs/working-backwards/PRD-{feature-slug}-{YYYY-MM-DD}.md
```

The PRD document must include the PRFAQ reference path.

### Step 7: Provide Next Steps

```
✅ PRD document has been created.

📄 File location: docs/working-backwards/PRD-{feature-slug}-{date}.md
📋 Status: Draft
🔗 PRFAQ reference: {PRFAQ file path}

Next steps:
1. Review the PRD content and make modifications if needed.
2. When ready, request validation with `/solapi-working-backwards:prd-validate` command.

Validation must pass before implementation can begin.
```

## Notes

- PRD must be based on an approved PRFAQ.
- Focus on achieving the customer benefits defined in the PRFAQ.
- Focus on "what" to implement rather than technical implementation details.
- "How" to implement is decided during the implementation phase.
