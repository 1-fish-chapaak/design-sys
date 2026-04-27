---
description: List open follow-ups from notes/0001-followups.md, grouped by priority. Use before reporting a new infra/test/docs issue.
---

List the open follow-up items so we don't re-flag known issues.

Steps:

1. Confirm `notes/0001-followups.md` exists.

2. Parse it and group by priority bucket. The file uses these markers:
   - `## 🔴 Correctness` → blocker bucket
   - `## 🟡 Hardening` → soon bucket
   - Each item starts with `### F-<area>-<n>:`

   ```bash
   awk '/^## /{bucket=$0} /^### F-/{print bucket "\t" $0}' notes/0001-followups.md
   ```

3. Print a compact table:
   ```
   Priority   ID         Title                                       File
   ---------  ---------  -----------------------------------------  -------
   🔴 BLOCK   F-INFRA-1  SSE block breaks streaming                 nginx/default.conf:36
   🔴 BLOCK   F-BE-1     TenantContextMiddleware not registered     auditify-be/app/main.py
   🟡 SOON    F-INFRA-3  client_max_body_size 5120M permissive      nginx/default.conf
   ...
   ```

4. Remind the user: when a fix lands, the entry is **deleted from `notes/0001-followups.md` in the same commit**. New findings get appended.
