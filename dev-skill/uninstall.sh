#!/usr/bin/env bash
# auditify-dev — uninstaller. Symmetric with install.sh.

set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
SETTINGS="$CLAUDE_DIR/settings.json"
HOOK_PATH="$CLAUDE_DIR/hooks/auditify-dev/session-start.sh"

echo "→ auditify-dev uninstaller"

# 1. Remove symlinks
rm -f "$CLAUDE_DIR/skills/auditify-dev" 2>/dev/null || true
rm -rf "$CLAUDE_DIR/hooks/auditify-dev" 2>/dev/null || true
for link in "$CLAUDE_DIR/commands/"auditify-*.md; do
  [ -L "$link" ] && rm -f "$link"
done
echo "  ✔ symlinks removed"

# 2. Remove hook entry from settings.json
if [ -f "$SETTINGS" ] && command -v jq >/dev/null; then
  HOOK_CMD="bash \"$HOOK_PATH\""
  cp "$SETTINGS" "$SETTINGS.bak.$(date +%Y%m%d-%H%M%S)"
  jq --arg cmd "$HOOK_CMD" '
    if (.hooks.SessionStart // []) == [] then .
    else .hooks.SessionStart |= map(
           .hooks |= map(select(.command != $cmd))
         ) | .hooks.SessionStart |= map(select((.hooks // []) != []))
    end
  ' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
  echo "  ✔ SessionStart hook removed from settings.json"
fi

echo "✔ auditify-dev uninstalled"
