---
description: Create a transient ops note under notes/ with branch tagging. Usage:/auditify-note-new <slug>
---

Create a transient note (review report, follow-up, design notes — anything that's NOT a load-bearing decision).

Slug from `$ARGUMENTS`.

Steps:

1. Find next note number:
   ```bash
   ls notes/ | grep -E '^[0-9]{4}-' | sort | tail -1
   ```
   Increment.
2. Get current branch:
   ```bash
   git branch --show-current
   ```
3. If branch matches the convention (feat/x-y, fix/x-y, etc.), filename: `notes/NNNN-<branch-with-slash-as-dash>-<slug>.md` for traceability.
   Otherwise: `notes/NNNN-<slug>.md`.
4. Write a minimal skeleton:

   ```markdown
   # NNNN — <title>

   **Branch:** <branch>
   **Date:** YYYY-MM-DD

   ## Context

   ## Findings / Decisions

   ## Next steps
   ```

5. Print the path. Notes can be edited freely as they age out — they're not source of truth, the code is.
