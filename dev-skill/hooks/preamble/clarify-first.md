## PROCEED MODE — default behaviour (faster than asking)

Default: pick the most likely interpretation, **state your assumption in one line at the top of your response**, and proceed. Do NOT pause for confirmation. The dev catches it in review or stops you mid-stream if wrong. Asking is friction — devs accept the recommendation 90% of the time anyway.

Examples of proceed-mode in action:
- Vague "improve the X component" → assume the highest-impact obvious change (e.g., extract a duplicated render block; add proper a11y attrs); state "Assuming you want X — say so if you wanted Y" and ship.
- New endpoint, no spec → follow the existing route's shape (router under `app/api/routes/<resource>.py`, schema under `app/schemas/`, model under `app/models/`); state assumptions about tenant scope, auth, response shape; ship.
- New util that's needed in 1 place → put it inline in the caller, not a new module. If reused later, extract then.
- Cross-stack change → write both halves in one commit (ADR 0001 prefers atomic), name the FE/BE files at the top.
- Unfamiliar Next 16 area → write a reasonable guess from training data, **then** read `node_modules/next/dist/docs/<area>/` to verify, fix if wrong. Don't pause to ask permission to read docs.

## STILL ASK FIRST — only when irreversible

Three cases where mistakes are expensive enough to warrant a pause:

1. **Schema change** — `alembic revision`, model field added/removed/renamed. Confirm: reversible? PR description note for the team? Suggested slug. Mistake here = production data ambiguity.

2. **Delete / rename of load-bearing files** — `CLAUDE.md`, `scripts/dev.sh`/`deploy.sh`/`migrate-prod.sh`, `compose.*.yml`, `nginx/*.conf`, `.pre-commit-config.yaml`, anything in `decisions/`. Confirm with the path list and a one-line reason.

3. **Adopting a new framework-level dependency** — anything that introduces a new architectural layer (state mgmt lib, ORM, auth provider, queue system). For small utility libs (a date helper, a UUID lib), just `uv add` / `npm install` and mention.

That's it. For every other "should I do X or Y" — pick X, state why, proceed.

## Thinking depth

Use **deep / extended thinking on any non-trivial decision**. "Non-trivial" = any change that touches more than the immediately edited symbol's signature, any architectural choice, anything in the irreversible list above. Trivial edits (rename, single-line fix, comment add) — just do them. Deep thinking trades a few seconds of latency for fewer rework loops, which is the actual speed win.
