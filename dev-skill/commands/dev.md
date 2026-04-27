---
description: Start the auditify-app stack (./scripts/dev.sh) and verify it came up cleanly.
---

Start the dev stack and report whether it came up.

Steps:

1. Confirm we're in an `auditify-app/` checkout (`compose.infra.yml` + `auditify-be/` + `auditify-fe/`).

2. Verify prereqs are present:
   ```bash
   command -v docker && command -v uv && command -v npm
   ```
   Bail with a clear message if any are missing.

3. Start in the background and tail logs (the script blocks tailing — start it in background so the verification step can run):
   ```bash
   ./scripts/dev.sh
   ```
   (Use `run_in_background` for this Bash call.)

4. Wait ~10 seconds, then verify:
   ```bash
   curl -s -o /dev/null -w "GET / -> %{http_code}\n" localhost/
   curl -s -o /dev/null -w "GET /api/health -> %{http_code}\n" localhost/api/health
   curl -s -o /dev/null -w "GET :3000 -> %{http_code}\n" localhost:3000
   curl -s -o /dev/null -w "GET :8000/health -> %{http_code}\n" localhost:8000/health
   ```
   All should be 200.

5. If any are not 200, show last 50 lines of `logs/be.log` and `logs/fe.log` and report what failed. Don't try to fix automatically — ask the user.

6. Remind the user: `Ctrl-C` (or kill the background bash) stops BE+FE; infra stays up. `./scripts/infra-down.sh` to stop infra.
