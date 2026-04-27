---
description: Wipe the local Postgres volume and restart the dev stack from scratch. Destructive — confirms first.
---

Wipe the local DB and rebuild from scratch. **Destructive** — pause and confirm with the user before running anything.

Steps:

1. **Confirm with the user before proceeding.** Show them the actual command that will run (`docker compose -f compose.infra.yml down -v`) and the consequence (named volume `pgdata` is destroyed; dump must be reloaded).

2. Once confirmed:
   ```bash
   ./scripts/infra-down.sh
   docker compose -f compose.infra.yml down -v
   ```

3. Restart:
   ```bash
   ./scripts/dev.sh
   ```
   (Background it so verification can run after.)

4. If `~/Downloads/auditify_dump.sql` exists, `./scripts/dev.sh` auto-reloads it on first run. Verify with:
   ```bash
   curl -s localhost/api/health
   ```

5. Confirm login still works (admin@auditify.app / ChangeMe123!) by reporting that the seeded user is queryable.
