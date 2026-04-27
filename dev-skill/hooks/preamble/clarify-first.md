## CLARIFY FIRST — pause and ask before proceeding

Before doing any of these, ask 1–3 pointed questions. **Do not assume an interpretation and start coding.** If the user's intent is ambiguous on any axis below, surface it.

| Trigger | Required clarification |
|---|---|
| Vague scope ("improve", "clean up", "refactor", "make better", no acceptance criterion) | Pick: (a) minimum change to satisfy a specific behavior, (b) localized refactor of <file>, (c) cross-cutting change. Also: what's the success signal? |
| **New dependency** (`uv add`, `npm install <pkg>`) | Confirm: (1) is this part of existing scope or a new architectural choice? (2) If new — should I draft `decisions/NNNN-adopt-<pkg>.md` first? |
| **New abstraction** — new helper module, wrapper used in <2 call sites, new util folder | "Minimum change is N lines in `<file>`. You're asking for an abstraction. Confirm: do you want the abstraction now (and why — anticipated reuse?), or the minimum change?" |
| **Deploy / auth / migration / tenant-flow / encryption change** | This is ADR-worthy per CLAUDE.md trigger list. Draft ADR before / with the change? |
| **Schema change** (`alembic revision`) | Confirm: (1) reversible? (2) PR description will note schema-break for the team? (3) suggested slug. |
| **Delete or rename** of any file with >0 grep hits elsewhere | List the references found. Confirm proceed. |
| **Cross-stack change** (touches both `auditify-fe/` and `auditify-be/`) | Confirm: single atomic commit/PR (recommended per ADR 0001) or split? |
| **Edits to `compose.*.yml`, `nginx/`, `scripts/`, `.pre-commit-config.yaml`** | Are you fixing a known follow-up (cite F-INFRA-N from `notes/0001-followups.md`) or doing something new (then likely ADR-worthy)? |
| **New endpoint** | Confirm: tenant-scoped (default) or platform-level (rare)? Schema under `app/schemas/<resource>.py`? Router under `app/api/routes/<resource>.py`? Model under `app/models/<resource>.py`? |
| **Next 16 specifics** (server actions, caching directives, layouts, RSC boundaries) | Next 16 has breaking changes from training data. Confirm I should fetch `node_modules/next/dist/docs/<area>/` before writing code. |
| **Frontend state mgmt that isn't hooks/RSC** | Cite `auditify-fe/AGENTS.md` "no Redux/Zustand without team agreement". Confirm team agreement, otherwise refuse and propose hooks/RSC alternative. |
| **Adding email / SMS / SMTP** | `app/core/email.py` exists — extend it. Confirm not adding a new SMTP path. |
| **Test-only changes that mark something `xfail` or `skip`** | Skips are visible as gaps; xfails hide. Cite F-TEST notes. Confirm skip vs xfail intent and that it shows up as a tracked follow-up. |
