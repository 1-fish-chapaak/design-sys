## HARD STOPS — refuse and ping the user

If the user's request would trigger any of these, **do not proceed**.
Stop, name the rule, and ask the user to confirm intent or pick an alternative. Never silently work around the rule.

1. **Branch name doesn't match `^(feat|fix|chore|docs|refactor|test)/[a-z][a-z0-9]*-[a-z0-9-]+$`** AND user wants to commit / open a PR / push.
   → STOP. Suggest a rename. **Do not auto-rename** — branch renames have side-effects (PR re-link, CI re-trigger).

2. **On `main` / `master`** AND user wants to commit.
   → STOP. Refuse to commit on main. Make them pick a branch type + name.

3. **Sync I/O inside an `async def`** — `requests.*`, `time.sleep`, `open()`, sync SQLAlchemy session, sync `boto3` / `paramiko`, sync `redis`.
   → STOP. Cite ADR / `auditify-be/CLAUDE.md` "Async-only I/O". Suggest the async equivalent (`httpx.AsyncClient`, `aiofiles`, `asyncio.to_thread`, `redis.asyncio`).

4. **Raw SQL or SQLAlchemy query that bypasses tenant context.**
   → STOP. Cite `app/middleware/tenant_rls.py` + `app/db/tenant_context.py`. If a deliberate escape is needed, require an ADR draft first under `decisions/NNNN-bypass-<slug>.md`.

5. **FE proposals that violate hard rules**: Vite, CRA, pages-router, Chakra, MUI, styled-components, Redux, Zustand (without team agreement).
   → STOP. Cite `auditify-fe/AGENTS.md`.

6. **`pip install`** or hand-editing `pyproject.toml` deps in `auditify-be/`.
   → STOP. Use `uv add <pkg>` only.

7. **Reading, writing, diffing, copying, or printing the contents of `.env`** (root or any subdir).
   → STOP. `.env` is gitignored and must never be staged, copied, or printed. If the user needs to change a secret, ask them to edit `.env` themselves and tell you only the *variable name* that changed.

8. **Production migration** triggered by anything other than `./scripts/migrate-prod.sh <TAG>`.
   → STOP. Prod migrations are gated. ADR 0002.

9. **FE code calling `http://localhost:8000/...` or any absolute backend URL.**
   → STOP. Use `/api/...` relative URLs. nginx proxies it. Cite ADR 0003 + `auditify-fe/AGENTS.md`.

10. **Renaming or deleting any `.git*`, `compose.*.yml`, `nginx/`, `scripts/dev.sh`, `scripts/deploy.sh`, `scripts/migrate-prod.sh` without an explicit ADR-worthy justification.**
    → STOP. These are load-bearing infra files. Confirm intent and require an ADR.
