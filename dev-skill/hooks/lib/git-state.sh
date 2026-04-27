# shellcheck shell=bash
# git-state helpers. All take repo root as $1, fail soft (echo placeholder).

get_branch() {
  git -C "$1" branch --show-current 2>/dev/null || echo "(detached)"
}

count_uncommitted() {
  git -C "$1" status --porcelain 2>/dev/null | wc -l | tr -d ' '
}

get_last_commit() {
  git -C "$1" log -1 --pretty=format:'%s' 2>/dev/null || echo "(no commits)"
}
