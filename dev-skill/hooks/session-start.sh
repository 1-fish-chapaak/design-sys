#!/usr/bin/env bash
# SessionStart hook for auditify-dev.
# Reads cwd from stdin JSON (or $PWD fallback). If cwd is inside an
# auditify-app/ checkout, emits the rule preamble + live git state.
# Otherwise: silent exit 0.

set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$PLUGIN_DIR/lib"
PREAMBLE_DIR="$PLUGIN_DIR/preamble"

# Try to read cwd from stdin JSON. Fall back to $PWD if anything fails.
INPUT="$(cat 2>/dev/null || true)"
CWD=""
if [ -n "$INPUT" ] && command -v python3 >/dev/null 2>&1; then
  CWD=$(printf '%s' "$INPUT" | python3 -c 'import json,sys
try: print(json.load(sys.stdin).get("cwd",""))
except Exception: pass' 2>/dev/null || true)
fi
[ -z "$CWD" ] && CWD="$PWD"

# shellcheck source=lib/detect-cwd.sh
source "$LIB_DIR/detect-cwd.sh"
REPO_ROOT="$(detect_auditify_root "$CWD" || true)"

if [ -z "$REPO_ROOT" ]; then
  exit 0   # silent — not in auditify-app
fi

# shellcheck source=lib/git-state.sh
source "$LIB_DIR/git-state.sh"
# shellcheck source=lib/branch-validate.sh
source "$LIB_DIR/branch-validate.sh"
# shellcheck source=lib/followups-count.sh
source "$LIB_DIR/followups-count.sh"

BRANCH="$(get_branch "$REPO_ROOT")"
if validate_branch "$BRANCH"; then BRANCH_TAG="valid"; else BRANCH_TAG="INVALID"; fi
case "$BRANCH" in main|master) ON_MAIN="YES" ;; *) ON_MAIN="no" ;; esac
UNCOMMITTED="$(count_uncommitted "$REPO_ROOT")"
LAST_COMMIT="$(get_last_commit "$REPO_ROOT")"
FOLLOWUPS="$(count_followups "$REPO_ROOT")"

cat <<EOF
[auditify-dev — activated for $REPO_ROOT]

## Live state
- Branch: \`$BRANCH\` [$BRANCH_TAG]
- On main/master: $ON_MAIN
- Uncommitted: $UNCOMMITTED files
- Last commit: $LAST_COMMIT
- Open follow-ups in notes/0001-followups.md: $FOLLOWUPS

EOF

cat "$PREAMBLE_DIR/hard-stops.md"
echo
cat "$PREAMBLE_DIR/clarify-first.md"
echo
cat "$PREAMBLE_DIR/footer.md"
