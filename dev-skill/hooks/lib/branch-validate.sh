# shellcheck shell=bash
# validate_branch <name> — exit 0 if matches the auditify branch convention,
# non-zero otherwise. Convention from CLAUDE.md:
#   ^(feat|fix|chore|docs|refactor|test)/[a-z][a-z0-9]*-[a-z0-9-]+$

validate_branch() {
  local name="$1"
  [[ "$name" =~ ^(feat|fix|chore|docs|refactor|test)/[a-z][a-z0-9]*-[a-z0-9-]+$ ]]
}
