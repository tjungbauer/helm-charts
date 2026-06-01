#!/usr/bin/env bash
# List Helm charts to lint/test in CI and locally.
#
# Outputs one chart path per line (e.g. charts/rhacs-setup).
#
# Usage:
#   scripts/list-charts-to-test.sh [--native] [--target-branch BRANCH]
#
# Default: changed charts plus tpl dependents when charts/tpl changed.
# --native: only directly changed charts (no tpl expansion).
#
# Change detection (first match wins):
#   1. ct list-changed — works on PR / feature branches
#   2. git diff CT_BASE_REF..CT_HEAD_REF — push on main (github.event.before/after)
#   3. git diff HEAD~1..HEAD — detached HEAD (workflow_run) or main after merge
#
# Environment (CI):
#   CT_TARGET_BRANCH   default branch name (default: main)
#   CT_BASE_REF        base git ref (push: github.event.before; workflow_run: set in workflow)
#   CT_HEAD_REF        head git ref (default: HEAD)

set -euo pipefail

TARGET_BRANCH="${CT_TARGET_BRANCH:-main}"
NATIVE_ONLY=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --native) NATIVE_ONLY=true ;;
    --target-branch)
      TARGET_BRANCH="${2:?--target-branch requires an argument}"
      shift
      ;;
    -h | --help)
      sed -n '1,22p' "$0" | tail -n +2
      exit 0
      ;;
    *)
      echo "unknown option: $1" >&2
      exit 1
      ;;
  esac
  shift
done

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "error: run from inside the helm-charts git repository" >&2
  exit 1
}
cd "$ROOT"

command -v ct >/dev/null 2>&1 || {
  echo "error: ct (chart-testing) required" >&2
  exit 1
}

charts_from_git_diff() {
  local base="$1"
  local head="$2"

  if [[ "$base" == 0000000* ]]; then
    base="origin/${TARGET_BRANCH}"
    git fetch origin "${TARGET_BRANCH}" --depth=1 2>/dev/null || true
  fi

  git diff --name-only "$base" "$head" \
    | grep '^charts/' \
    | cut -d/ -f1-2 \
    | sort -u \
    | while IFS= read -r chart; do
        [[ -z "${chart// }" ]] && continue
        [[ -f "$chart/Chart.yaml" ]] || continue
        case "$chart" in
          charts/test-chart) continue ;;
        esac
        echo "$chart"
      done
}

list_native_charts() {
  local native ct_base ct_head

  native=$(ct list-changed --target-branch "$TARGET_BRANCH" 2>/dev/null || true)
  if [[ -n "$(echo "$native" | awk 'NF')" ]]; then
    echo "$native" | awk 'NF' | sort -u
    return 0
  fi

  ct_base="${CT_BASE_REF:-}"
  ct_head="${CT_HEAD_REF:-HEAD}"

  if [[ -n "$ct_base" ]]; then
    charts_from_git_diff "$ct_base" "$ct_head"
    return 0
  fi

  # workflow_run checks out a detached HEAD; push on main also needs this when env is unset
  if git rev-parse HEAD~1 >/dev/null 2>&1; then
    charts_from_git_diff "HEAD~1" "$ct_head"
  fi
}

expand_tpl_dependents() {
  local charts="$1"

  if ! echo "$charts" | grep -qx 'charts/tpl'; then
    echo "$charts" | awk 'NF' | sort -u
    return 0
  fi

  for chart_yaml in charts/*/Chart.yaml; do
    [[ -f "$chart_yaml" ]] || continue
    dir=$(dirname "$chart_yaml")
    case "$dir" in
      charts/test-chart) continue ;;
    esac
    if grep -qE '^\s+- name: tpl\s*$' "$chart_yaml"; then
      charts=$(printf '%s\n%s' "$charts" "$dir")
    fi
  done

  echo "$charts" | awk 'NF' | sort -u
}

native=$(list_native_charts)
charts="$native"

if ! $NATIVE_ONLY; then
  charts=$(expand_tpl_dependents "$native")
fi

echo "$charts" | awk 'NF' | sort -u
