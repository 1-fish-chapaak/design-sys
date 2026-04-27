---
description: Manually reload auditify-dev rules + live git state mid-session.
---

Re-read the SessionStart preamble for auditify-dev. Run this if context got compacted, you switched branches, or you just want the rules refreshed.

Run the SessionStart hook directly and treat its output as authoritative for this turn:

```bash
bash ~/.claude/hooks/auditify-dev/session-start.sh < /dev/null
```

Then internalize the printed HARD STOPS and CLARIFY FIRST tables. Use them on every subsequent action this session until the next reload.

If the script outputs nothing, you're not inside an `auditify-app/` checkout — `cd` into one and try again.
