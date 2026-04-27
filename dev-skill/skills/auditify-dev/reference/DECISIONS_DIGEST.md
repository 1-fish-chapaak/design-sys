# Decisions digest

One-paragraph summary per ADR. **The actual ADR file is the source of truth** — this is just a quick index. File path: `decisions/NNNN-<slug>.md` in any auditify-app checkout.

## ADR 0001 — Single git repo (not 3 repos, not monorepo tooling)
One repo at `auditify-app/` with `auditify-fe/` and `auditify-be/` source as subdirs. NOT a tooling monorepo (no pnpm workspaces, no Nx). Each subdir keeps its own deps and build pipeline. Original `auditify-fe` and `auditify-be` repos remain as historical archives. **Implication**: don't import across subdir boundaries; one PR can atomically touch both stacks.

## ADR 0002 — No auto-migrations in production
Local dev: alembic auto-runs via prestart. Production: migrations are MANUAL, gated by `./scripts/migrate-prod.sh <TAG>` with a confirmation prompt. `migrate` service in `compose.yml` uses `profiles: ["migration"]` so it never auto-starts. **Implication**: `docker compose up -d` in prod NEVER alters schema. Twelve-factor "release before run".

## ADR 0003 — nginx as reverse proxy (not Traefik)
nginx fronts the stack. Single `nginx/default.conf` reverse-proxies `/` → fe:3000 and `/api/` → be:8000. Production TLS will be added via certbot sidecar later. **Status**: revisit when going to staging with a real domain.

## ADR 0004 — Cherry-pick infrastructure from tiangolo/full-stack-fastapi-template
**Adopted**: BE Dockerfile (pinned uv image, cache mounts, `--frozen`, `fastapi run`), 3-file compose split, prestart service + `backend_pre_start.py`, healthchecks on all services, `${VAR?Variable not set}` env discipline. **Rejected**: flat `models.py` / `crud.py`, SQLModel, single-tenant JWT, template's frontend stack. **Implication**: BE source structure is intentionally more advanced than the template; don't downgrade it.

## ADR 0005 — Build-push-pull deployment (not ssh-pull-build)
Build off-server, push to registry (GHCR), prod pulls. Deploy: `docker compose pull && up -d --no-deps fe be nginx`. Migrate is a separate, gated step. Rollback: change TAG env var, `up -d`. **Implication**: prod server holds zero source code or build tooling. Same image promotes from staging to prod.

## ADR 0006 — Dev mode runs FE/BE on host (only infra in Docker)
Daily local dev: infra (db + redis + nginx) in Docker via `compose.infra.yml`. FE (`next dev`) and BE (`uvicorn --reload`) on the host. nginx in Docker still routes `/` and `/api/` to `host.docker.internal:3000` / `:8000` so URL surface matches prod. Single command: `./scripts/dev.sh`. **Trade-off accepted**: devs need uv + Node 20 on host. **Why**: native hot reload is fastest, fix-and-rebuild loop in containers was costing time. **Revisit**: if onboarding friction grows, fix F-INFRA-8 / F-INFRA-9 and switch to full-Docker dev.
