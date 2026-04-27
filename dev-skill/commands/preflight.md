---
description: Run all auditify-app quality gates (BE + FE) and report a punch list. Use before declaring "done".
---

Run every quality gate the repo expects before a PR is shippable, and report a single punch list of what passed / failed.

From the repo root:

1. **Pre-commit on all files**
   ```bash
   pre-commit run --all-files
   ```

2. **Backend (BE) gates** — `cd auditify-be`:
   ```bash
   uv run ruff check
   uv run mypy app/
   uv run pytest
   ```

3. **Frontend (FE) gates** — `cd auditify-fe`:
   ```bash
   npm run lint
   npm run typecheck
   ```

4. **Stack smoke** (only if `./scripts/dev.sh` is running):
   ```bash
   curl -s -o /dev/null -w "%{http_code}\n" localhost/
   curl -s -o /dev/null -w "%{http_code}\n" localhost/api/health
   ```
   Both should be 200.

Report a table:

| Gate | Status | Notes |
|---|---|---|
| pre-commit | pass / fail | first failing hook |
| ruff | pass / fail | offending file:line |
| mypy | pass / fail | first error |
| pytest | pass / fail | failing test names |
| npm lint | pass / fail | first issue |
| npm typecheck | pass / fail | first error |
| smoke / | 200 / N | — |
| smoke /api/health | 200 / N | — |

Don't fix anything yet — just report. Wait for the user to say which to fix first.
