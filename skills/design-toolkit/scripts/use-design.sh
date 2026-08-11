#!/usr/bin/env bash
set -euo pipefail

LIBRARY_DIR="${DESIGN_TOOLKIT_LIBRARY_DIR:-${HOME}/.design-toolkit/design-library}"

usage() {
  cat <<'USAGE'
Usage:
  use-design.sh --list
  use-design.sh --path <design-name>
  use-design.sh <design-name> [target-repo] [--force]

Examples:
  use-design.sh --list
  use-design.sh --path linear.app
  use-design.sh apple .
  use-design.sh linear ~/project --force
USAGE
}

require_library() {
  if [[ ! -d "$LIBRARY_DIR" ]]; then
    echo "Design library is not installed: $LIBRARY_DIR" >&2
    echo "Run the my-design-toolkit installer during environment setup." >&2
    exit 2
  fi
}

list_designs() {
  require_library
  for dir in "$LIBRARY_DIR"/*; do
    [[ -d "$dir" && -f "$dir/DESIGN.md" ]] || continue
    basename "$dir"
  done | sort
}

resolve_design() {
  local requested="$1"
  local exact="$LIBRARY_DIR/$requested/DESIGN.md"
  if [[ -f "$exact" ]]; then
    printf '%s\n' "$exact"
    return 0
  fi

  local requested_lower
  requested_lower="$(printf '%s' "$requested" | tr '[:upper:]' '[:lower:]')"

  local candidate name name_lower
  for candidate in "$LIBRARY_DIR"/*; do
    [[ -d "$candidate" && -f "$candidate/DESIGN.md" ]] || continue
    name="$(basename "$candidate")"
    name_lower="$(printf '%s' "$name" | tr '[:upper:]' '[:lower:]')"
    if [[ "$name_lower" == "$requested_lower" ]]; then
      printf '%s\n' "$candidate/DESIGN.md"
      return 0
    fi
  done

  local matches=""
  for candidate in "$LIBRARY_DIR"/*; do
    [[ -d "$candidate" && -f "$candidate/DESIGN.md" ]] || continue
    name="$(basename "$candidate")"
    name_lower="$(printf '%s' "$name" | tr '[:upper:]' '[:lower:]')"
    if [[ "$name_lower" == *"$requested_lower"* ]]; then
      matches="${matches}${name}"$'\n'
    fi
  done

  local match_count
  match_count="$(printf '%s' "$matches" | sed '/^$/d' | wc -l | tr -d ' ')"
  if [[ "$match_count" == "1" ]]; then
    name="$(printf '%s' "$matches" | sed '/^$/d' | head -n 1)"
    printf '%s\n' "$LIBRARY_DIR/$name/DESIGN.md"
    return 0
  fi

  echo "Unknown or ambiguous design: $requested" >&2
  if [[ -n "$matches" ]]; then
    echo "Possible matches:" >&2
    printf '%s' "$matches" | sed '/^$/d' | sed 's/^/  - /' >&2
  else
    echo "Run --list to see available designs." >&2
  fi
  return 3
}

require_library

if [[ "${1:-}" == "--list" ]]; then
  list_designs
  exit 0
fi

if [[ "${1:-}" == "--path" ]]; then
  [[ $# -eq 2 ]] || { usage; exit 1; }
  resolve_design "$2"
  exit 0
fi

[[ $# -ge 1 && $# -le 3 ]] || { usage; exit 1; }

design="$1"
shift

target="."
force="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      force="true"
      ;;
    *)
      if [[ "$target" != "." ]]; then
        usage
        exit 1
      fi
      target="$1"
      ;;
  esac
  shift
done

source_path="$(resolve_design "$design")"
mkdir -p "$target"
destination="$target/DESIGN.md"

if [[ -f "$destination" && "$force" != "true" ]]; then
  echo "Refusing to overwrite existing file: $destination" >&2
  echo "Re-run with --force only if replacement is intentional." >&2
  exit 4
fi

cp "$source_path" "$destination"
echo "Applied design '$(basename "$(dirname "$source_path")")' -> $destination"
