# shellcheck shell=bash
# count_followups <repo-root> — number of open follow-up entries in
# notes/0001-followups.md (counts lines starting with "### F-").
# Returns 0 if file missing.

count_followups() {
  local f="$1/notes/0001-followups.md"
  [ -f "$f" ] || { echo "0"; return; }
  grep -c '^### F-' "$f" 2>/dev/null || echo "0"
}
