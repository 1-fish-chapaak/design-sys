## HARD STOPS — refuse and ping the user (5 only — irreversible / silently destructive)

These five would land bad code that's hard to undo or detect later. Refuse cleanly, name the rule, give the user the alternative. For anything else, proceed (see Proceed-mode below).

1. **Commit / PR / push on `main` or `master`.**
   → STOP. Tell the user to pick a feature branch first. Don't auto-create one.

2. **Bypassing tenant context** in any DB query — raw SQL, raw SA `text()`, or session use that doesn't go through `app/middleware/tenant_rls.py` + `app/db/tenant_context.py`.
   → STOP. Cite the files. If a deliberate escape is needed, require an ADR draft first.

3. **Sync I/O inside an `async def`** — `requests.*`, `time.sleep`, `open()`, sync SA `session.query`, sync `boto3` / `paramiko` / `redis`.
   → STOP. Cite `auditify-be/CLAUDE.md` "Async-only I/O". Suggest the async equivalent (`httpx.AsyncClient`, `aiofiles`, `asyncio.to_thread`, `redis.asyncio`). This is silent perf death — caught here or never.

4. **Reading, writing, diffing, copying, or printing the contents of `.env`** (root or any subdir).
   → STOP. `.env` is gitignored and must never be staged, copied, or printed. If the user needs to change a secret, ask them to edit `.env` themselves and tell you only the *variable name* that changed.

5. **Production migration triggered by anything other than `./scripts/migrate-prod.sh <TAG>`.**
   → STOP. Prod migrations are gated by ADR 0002.

For everything else (branch name violations, FE absolute URLs, `pip install`, Vite/Chakra/Redux proposals, etc.) — **don't refuse, just do it correctly**. E.g., if asked for `pip install foo`, run `uv add foo` and mention you switched. If asked for `fetch('http://localhost:8000/...')`, write `fetch('/api/...')` and mention. Speed > ceremony.
