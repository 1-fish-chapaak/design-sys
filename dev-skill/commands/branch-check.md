---
description: Validate the current git branch against the auditify-app naming convention. Refuse commit/PR/push if invalid.
---

Run this before any commit, PR, or push.

Steps:

1. Get the current branch:
   ```bash
   git -C "$(git rev-parse --show-toplevel)" branch --show-current
   ```

2. Validate against the convention `^(feat|fix|chore|docs|refactor|test)/[a-z][a-z0-9]*-[a-z0-9-]+$`. The helper `~/.claude/hooks/auditify-dev/lib/branch-validate.sh` exposes `validate_branch <name>`:
   ```bash
   source ~/.claude/hooks/auditify-dev/lib/branch-validate.sh
   if validate_branch "$(git branch --show-current)"; then echo "valid"; else echo "INVALID"; fi
   ```

3. **If invalid** — STOP. Do not proceed with commit/PR/push. Tell the user the exact problem and propose a rename like:
   > "Current branch `<X>` doesn't match the convention `<type>/<your-name>-<short-desc>`. Suggested rename: `<type>/<your-name>-<short-desc>`. Confirm the new name — I won't auto-rename (renames have side-effects on PR re-link / CI re-trigger)."

4. **If on `main` or `master`** — refuse outright. The user must move to a feature branch first.

5. **If valid** — echo "valid" and proceed.
