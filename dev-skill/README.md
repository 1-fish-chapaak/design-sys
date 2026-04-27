# auditify-dev

Claude Code dev skill for [auditify-app](https://github.com/tech-irame/auditify-app). Install once. Every Claude session inside the repo auto-loads the team's hard rules and clarification gates. Outside the repo: silent.

## Install

```bash
git clone https://github.com/tech-irame/auditify-dev ~/code/auditify-dev
cd ~/code/auditify-dev
./install.sh
```

Requires `jq` (`brew install jq`).

Restart any open Claude Code sessions. New sessions inside `auditify-app/` will print an `[auditify-dev — activated]` block on first turn.

## What it does

- **SessionStart hook** (cwd-gated): when Claude Code starts in an `auditify-app/` checkout, injects the rule preamble + live git state.
- **Skill** (`auditify-dev`): auto-triggers on auditify-related queries; ships reference docs (decisions digest, async I/O patterns, tenant RLS, Next 16 gotchas, follow-ups, ADR template).
- **Slash commands**: `/auditify-dev-skills` (manual reload), `/auditify-branch-check`, `/auditify-preflight`, `/auditify-adr-new <slug>`, `/auditify-note-new <slug>`, `/auditify-dev`, `/auditify-load-dump`, `/auditify-reset-db`, `/auditify-followups`.

## Update

```bash
cd ~/code/auditify-dev && git pull && ./install.sh
```

`install.sh` is idempotent.

## Uninstall

```bash
~/code/auditify-dev/uninstall.sh
```
