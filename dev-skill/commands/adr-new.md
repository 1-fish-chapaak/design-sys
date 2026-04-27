---
description: Create a new ADR under decisions/ with the next sequential number and the standard template. Usage:/auditify-adr-new <slug>
---

Create a new ADR. Slug from `$ARGUMENTS` (kebab-case, e.g. `adopt-redis-streams`).

Steps:

1. Confirm we're in an `auditify-app/` checkout (look for `decisions/`).
2. Find the next ADR number:
   ```bash
   ls decisions/ | grep -E '^[0-9]{4}-' | sort | tail -1
   ```
   Increment the leading 4-digit number by 1. Don't recycle numbers.
3. Filename: `decisions/NNNN-<slug>.md`.
4. Write the file using this template (substitute `<...>` placeholders, leave the section headings as-is):

   ```markdown
   # ADR NNNN: <decision in one line>

   **Status:** Accepted (YYYY-MM-DD)
   **Context:** <what triggered this — prior state, constraint, incident>

   ## Decision

   <what we decided. Be specific. Name files/services/versions.>

   ## Considered alternatives

   1. **<Alternative A>** — <why rejected, one sentence>
   2. **<Alternative B>** — <why rejected>

   ## Consequences

   - <positive consequence>
   - <negative consequence / trade-off accepted>
   - <thing to revisit and when>
   ```

5. Print the path of the created file and ask the user to fill in the placeholders. **Do not invent the Decision content** — that's the user's call.

6. Remind: once Accepted, don't rewrite. Supersede with a new ADR if the decision changes.
