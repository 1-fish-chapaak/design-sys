# shellcheck shell=bash
# detect_auditify_root <cwd> — echoes repo root if cwd is inside an
# auditify-app checkout, empty otherwise. Walks up parents looking for
# the repo's signature: compose.infra.yml + auditify-be/ + auditify-fe/.

detect_auditify_root() {
  local dir="${1:-$PWD}"
  while [ "$dir" != "/" ] && [ -n "$dir" ]; do
    if [ -f "$dir/compose.infra.yml" ] \
       && [ -d "$dir/auditify-be" ] \
       && [ -d "$dir/auditify-fe" ] \
       && [ -d "$dir/decisions" ]; then
      printf '%s' "$dir"
      return 0
    fi
    dir="$(dirname "$dir")"
  done
  return 1
}
