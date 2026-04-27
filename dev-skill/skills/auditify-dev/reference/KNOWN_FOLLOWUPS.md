# Known follow-ups — don't re-flag these

Source of truth: `notes/0001-followups.md` in the repo. Read it before reporting any infra / test / doc issue. If your finding matches one already listed, cite the F-ID instead of re-opening it.

## Snapshot of categories (refresh by reading `notes/0001-followups.md`)

### 🔴 Correctness — fix before any production traffic
- **F-INFRA-1**: nginx SSE block has `chunked_transfer_encoding off` — silently swallows events
- **F-INFRA-2**: nginx SSE location missing forwarded headers
- **F-BE-1**: `TenantContextMiddleware` defined but not registered in `app/main.py`
- **F-INFRA-8**: FE Dockerfile runner stage missing `next` CLI — breaks full-Docker dev (mitigated by ADR 0006)
- **F-INFRA-9**: BE container `.venv` shadowed by host volume mount (mitigated by ADR 0006)
- **F-CI-1**: GitHub Actions workflow not committed — needs `gh auth refresh -s workflow`

### 🟡 Hardening — fix soon
- **F-INFRA-3**: nginx `client_max_body_size 5120M` is permissive — drop to 100M
- **F-INFRA-4**: Missing security headers (X-Frame-Options, X-Content-Type-Options, Referrer-Policy)
- **F-INFRA-5 / F-INFRA-7**: FE healthcheck hits full SSR — add `/healthz` static route
- **F-INFRA-6**: prestart missing redis dependency
- **F-TEST-1**: alembic test only proves config, not migration state — switch to `alembic check`
- **F-TEST-2**: No end-to-end test using conftest `client` fixture
- **F-DOCS-1**: No ADR for `/api` proxy URL convention
- **F-DOCS-2**: No ADR for single `.env` at root
- **F-DOCS-3**: `auditify-fe/CLAUDE.md` is silent `@AGENTS.md` import — fragile

## How to work this list

1. Pick highest-priority bucket you have time for in your sprint.
2. When a fix lands, **delete the entry from `notes/0001-followups.md` in the same commit**.
3. New review findings get appended to the file, not lost.
