## Always-on rules (just obey — no question, no pause)

- **Commit format**: `[branch-name]: <message>`.
- **One PR can touch both FE and BE** (atomic across stack — preferred per ADR 0001).
- **Quality gates** before "done":
  - BE: `cd auditify-be && uv run ruff check && uv run mypy app/ && uv run pytest`
  - FE: `cd auditify-fe && npm run lint && npm run typecheck`
  - Stack smoke: `curl localhost/` + `curl localhost/api/health` both 200.
- **Decisions log** (`decisions/NNNN-<slug>.md`) is the source of truth.
- **Don't re-flag** items already in `notes/0001-followups.md`.
- **Branch name** should match `^(feat|fix|chore|docs|refactor|test)/[a-z][a-z0-9]*-[a-z0-9-]+$` — if invalid AND user asks to commit, suggest the rename in passing but don't block on it.
- **FE URLs** always `/api/...` relative, never absolute.
- **BE deps** via `uv add`, never `pip install`.

## On-demand reference (skill auto-loads when relevant)

`skills/auditify-dev/reference/` — `DECISIONS_DIGEST.md` · `ASYNC_IO_PATTERNS.md` · `TENANT_RLS_GUIDE.md` · `NEXT16_GOTCHAS.md` · `KNOWN_FOLLOWUPS.md` · `ADR_TEMPLATE.md`

## Manual reload

`/auditify-dev-skills` — reprints this preamble with fresh git state.

[end auditify-dev preamble — fast mode: proceed-with-assumption + deep thinking + 5 hard stops]
