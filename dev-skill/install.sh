#!/usr/bin/env bash
# auditify-dev — one-time installer
# Idempotent: safe to re-run after updates.
#
# What this does:
#   1. Symlinks plugin contents into ~/.claude/{skills,commands,hooks}/
#   2. Adds a SessionStart hook entry to ~/.claude/settings.json (idempotent)
#
# Result: every new Claude Code session inside an auditify-app/ checkout
# auto-loads the dev rules. Outside the repo, the hook is a silent no-op.

set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SETTINGS="$CLAUDE_DIR/settings.json"
HOOK_PATH="$CLAUDE_DIR/hooks/auditify-dev/session-start.sh"

echo "→ auditify-dev installer"
echo "  source: $SRC_DIR"
echo "  target: $CLAUDE_DIR"

# 0. preflight
command -v jq >/dev/null 2>&1 || { echo "✗ jq required (brew install jq)"; exit 1; }
[ -d "$CLAUDE_DIR" ] || { echo "✗ $CLAUDE_DIR not found — is Claude Code installed?"; exit 1; }
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"

# 1. skill: symlink ~/.claude/skills/auditify-dev → SRC/skills/auditify-dev
mkdir -p "$CLAUDE_DIR/skills"
SKILL_LINK="$CLAUDE_DIR/skills/auditify-dev"
if [ -L "$SKILL_LINK" ] || [ -e "$SKILL_LINK" ]; then rm -rf "$SKILL_LINK"; fi
ln -s "$SRC_DIR/skills/auditify-dev" "$SKILL_LINK"
echo "  ✔ skill linked"

# 2. commands: symlink each as auditify-<name>.md (namespaced to avoid collisions)
mkdir -p "$CLAUDE_DIR/commands"
for cmd in "$SRC_DIR/commands"/*.md; do
  name=$(basename "$cmd" .md)
  link="$CLAUDE_DIR/commands/auditify-${name}.md"
  if [ -L "$link" ] || [ -e "$link" ]; then rm -f "$link"; fi
  ln -s "$cmd" "$link"
done
echo "  ✔ commands linked (auditify-*)"

# 3. hooks: symlink hook tree
mkdir -p "$CLAUDE_DIR/hooks"
HOOK_LINK="$CLAUDE_DIR/hooks/auditify-dev"
if [ -L "$HOOK_LINK" ] || [ -e "$HOOK_LINK" ]; then rm -rf "$HOOK_LINK"; fi
ln -s "$SRC_DIR/hooks" "$HOOK_LINK"
chmod +x "$SRC_DIR/hooks/session-start.sh"
echo "  ✔ hook linked"

# 4. settings.json: add SessionStart hook entry (idempotent via dedup on command string)
HOOK_CMD="bash \"$HOOK_PATH\""
cp "$SETTINGS" "$SETTINGS.bak.$(date +%Y%m%d-%H%M%S)"

jq --arg cmd "$HOOK_CMD" '
  .hooks //= {}
  | .hooks.SessionStart //= []
  | if (.hooks.SessionStart | map(.hooks // []) | flatten | map(.command) | any(. == $cmd))
    then .
    else .hooks.SessionStart += [{"hooks": [{"type": "command", "command": $cmd}]}]
    end
' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
echo "  ✔ SessionStart hook registered in settings.json"

cat <<EOF

═══════════════════════════════════════════════
✔ auditify-dev installed

  • Open a NEW Claude Code session inside auditify-app/ — rules auto-load.
  • Outside the repo: hook is a silent no-op.
  • Manual reload mid-session: /auditify-dev-skills
  • Other commands: /auditify-branch-check, /auditify-preflight,
                    /auditify-adr-new, /auditify-dev, …

  Uninstall: $SRC_DIR/uninstall.sh
═══════════════════════════════════════════════
EOF
