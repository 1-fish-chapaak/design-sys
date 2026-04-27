# Tenant RLS guide — auditify-be

Multi-tenant B2B SaaS. **Every query path must go through tenant context.** Bypassing it is a HARD STOP — refuse without an ADR-documented escape.

## Source files (read before writing query code)

- `app/middleware/tenant_rls.py` — request-scoped middleware that extracts tenant from auth and sets per-request tenant id
- `app/db/tenant_context.py` — sets the Postgres session variable (`SET LOCAL app.current_tenant = ...`) that RLS policies read
- `app/db/session.py` — `AsyncSession` factory; tenant context is bound here per request
- `alembic/versions/*` — RLS policies are created/altered via migrations

## Known gap (as of scaffolding review, see `notes/0001-followups.md` F-BE-1)

`TenantContextMiddleware` is **defined but not registered** in `app/main.py`. The class exists, but `app.add_middleware(TenantContextMiddleware)` isn't called yet because `dispatch()` is still a pass-through. Wire it up before any non-trivial tenant-scoped endpoint lands.

The marker test: `tests/test_smoke.py::test_tenant_rls_middleware_registered` is currently `skip`-marked (visible as a gap in `pytest -v`). Don't change that to `xfail` — skips show, xfails hide.

## When adding a new endpoint

1. Confirm tenant scope (default = yes). Platform-level endpoints (no tenant) are rare and require explicit confirmation.
2. Router goes under `app/api/routes/<resource>.py`.
3. Schema under `app/schemas/<resource>.py`.
4. Model under `app/models/<resource>.py` (one file per entity — do not collapse to flat `models.py`).
5. Inside the route, use the `AsyncSession` dep — don't open a session manually. The middleware (once wired) will have set tenant context.
6. **Never** write `text("SELECT ... FROM table")` without verifying tenant scope.

## When you genuinely need to bypass tenant scope

(e.g. background job iterating across tenants, admin tooling)

1. Draft an ADR: `decisions/NNNN-bypass-tenant-<slug>.md` with Status / Context / Decision / Alternatives / Consequences.
2. Use a separate session factory or explicit context override — don't disable RLS globally.
3. Code-review must call out the bypass explicitly in PR description.
