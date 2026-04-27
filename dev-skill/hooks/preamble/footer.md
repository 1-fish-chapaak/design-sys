## Always-on rules (no clarification needed — just obey)

- **Commit format**: `[branch-name]: <message>`. No exceptions.
- **One PR can touch both FE and BE** (atomic across stack — preferred per ADR 0001).
- **Quality gates** before declaring "done":
  - BE: `cd auditify-be && uv run ruff check && uv run mypy app/ && uv run pytest`
  - FE: `cd auditify-fe && npm run lint && npm run typecheck`
  - Stack smoke: `curl localhost/` returns Next HTML, `curl localhost/api/health` returns 200.
- **Decisions log** (`decisions/NNNN-<slug>.md`) is the source of truth. **Notes** (`notes/NNNN-<slug>.md`) are transient.
- **Don't re-flag** items already in `notes/0001-followups.md`. Read it before reporting issues with infra/tests/docs.
- Daily commands: `./scripts/dev.sh` (start), `./scripts/infra-down.sh` (stop infra), `./scripts/load-dump.sh` (seed).

## On-demand reference (skill auto-loads when relevant)

`skills/auditify-dev/reference/` —
`DECISIONS_DIGEST.md` · `ASYNC_IO_PATTERNS.md` · `TENANT_RLS_GUIDE.md` · `NEXT16_GOTCHAS.md` · `KNOWN_FOLLOWUPS.md` · `ADR_TEMPLATE.md`

## Manual reload

`/auditify-dev-skills` — reprints this preamble with fresh git state.

[end auditify-dev preamble]
