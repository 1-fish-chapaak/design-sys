---
name: auditify-dev
description: Dev rules and references for auditify-app — the B2B SaaS monorepo with Next.js 16 frontend (auditify-fe) and FastAPI + uv multi-tenant backend (auditify-be). Activate for any work in or about auditify-app, multi-tenant query work, tenant_rls, async I/O patterns in FastAPI, alembic migrations, ADR / decisions/ folder, branch naming convention, single-env-at-root, nginx /api proxy convention, Next 16 breaking changes, or anything mentioning "auditify". Provides the canonical hard rules, a digest of every ADR, and deep-dive reference docs (async I/O, tenant RLS, Next 16 gotchas, known follow-ups, ADR template) so design and code decisions land on-spec the first time.
---

# auditify-dev — Dev Skill

You are working in or about `auditify-app/`. The full operating rules are in the repo's `CLAUDE.md` (which `@`-imports `auditify-fe/AGENTS.md` and `auditify-be/CLAUDE.md`) and the `decisions/` ADRs.

If the SessionStart hook already injected the preamble, you have the hard-stop and clarification rules in context. Otherwise see `commands/auditify-dev-skills` for a manual reload.

## When to read which reference

| Situation | Read |
|---|---|
| Need the WHY behind a load-bearing choice | `reference/DECISIONS_DIGEST.md` (one-paragraph summary per ADR with file pointers) |
| Writing or reviewing FastAPI route / service code | `reference/ASYNC_IO_PATTERNS.md` |
| Writing or reviewing any DB query | `reference/TENANT_RLS_GUIDE.md` |
| Writing Next.js 16 code | `reference/NEXT16_GOTCHAS.md` (also: read `auditify-fe/node_modules/next/dist/docs/` for the area you're touching) |
| Tempted to flag an infra / test / docs issue | `reference/KNOWN_FOLLOWUPS.md` first — don't re-flag known items |
| About to add a new ADR | `reference/ADR_TEMPLATE.md` |

## How to act on the rules

- The HARD STOPS in the preamble are not negotiable. Refuse and ping the user.
- The CLARIFY FIRST list means: ask 1–3 pointed questions, do not assume.
- Always-on rules (commit format, quality gates, /api URL) just obey — no question needed.
- The skill complements but does not replace the repo's `CLAUDE.md` files. If they conflict, the repo wins (it's checked-in source of truth).

## Don't do

- Don't dump every reference file into context preemptively. Pull what you need.
- Don't re-derive what's in `decisions/` — read the ADR and cite it.
- Don't propose changes that would violate a HARD STOP. Refuse.
