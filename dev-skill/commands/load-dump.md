---
description: Load a SQL dump into the local auditify db. Defaults to ~/Downloads/auditify_dump.sql. Usage:/auditify-load-dump [path]
---

Seed the local db from a SQL dump. From `$ARGUMENTS` (optional — defaults to `~/Downloads/auditify_dump.sql`).

Steps:

1. Determine dump path:
   - If `$ARGUMENTS` is set, use it
   - Else use `$HOME/Downloads/auditify_dump.sql`

2. Confirm the file exists. If not, tell the user to ping `#auditify-dev` for the file (per `notes/0005-team-onboarding.md`).

3. Confirm infra is up:
   ```bash
   docker compose -f compose.infra.yml ps db
   ```
   If db is not running, run `./scripts/infra-up.sh` first.

4. Load the dump:
   ```bash
   ./scripts/load-dump.sh <path>
   ```

5. After load, verify a known seeded user exists:
   ```bash
   docker compose -f compose.infra.yml exec -T db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT email FROM users WHERE email='admin@auditify.app';"
   ```

6. Remind: login is `admin@auditify.app` / `ChangeMe123!` per onboarding doc.
