# Async-only I/O — patterns for auditify-be

This is a HARD RULE. FastAPI is async; mixing sync/blocking I/O in `async def` silently kills throughput (the worker thread blocks while the event loop has nothing to do). Source: `auditify-be/CLAUDE.md`.

## Default libraries (use these)

| Need | Use | NOT |
|---|---|---|
| HTTP client | `httpx.AsyncClient` (already in deps) | `requests`, `urllib` |
| File I/O | `aiofiles` | plain `open()` |
| Postgres | `sqlalchemy[asyncio]` + `asyncpg` (wired in `app/db/session.py`) | sync SA / psycopg2 |
| Redis | `redis.asyncio` | sync `redis` |
| OpenAI / LLM | `AsyncOpenAI`, or `litellm` async | sync `OpenAI()` client |
| Subprocess | `asyncio.create_subprocess_exec` | `subprocess.run` |
| Sleep | `await asyncio.sleep(x)` | `time.sleep(x)` |

If a package isn't installed yet, add via uv:

```bash
cd auditify-be
uv add aiofiles
uv add 'openai>=1.0'
```

## When you genuinely have to call blocking code

```python
import asyncio
from PIL import Image    # PIL has no async API — wrap it

async def thumb(path: str) -> bytes:
    return await asyncio.to_thread(_make_thumb_blocking, path)
```

Or `loop.run_in_executor(None, blocking_fn, *args)` for finer control. Codebase is Python 3.12.

## Refuse to write

- ❌ `requests.get(...)` inside an `async def`
- ❌ `time.sleep(x)` (use `await asyncio.sleep(x)`)
- ❌ `open(path).read()` in async (use `aiofiles.open(...)` or `to_thread`)
- ❌ `session.query(...)` (codebase uses `AsyncSession` — `await session.execute(select(...))`)
- ❌ `boto3` / `paramiko` clients in async without `to_thread` wrapping

If a user asks for any of the above, **STOP** and propose the async equivalent.
