#!/usr/bin/env bash
# List Helm charts to lint/test in CI and locally.
#
# Outputs one chart path per line (e.g. charts/rhacs-setup).
#
# Usage:
#   scripts/list-charts-to-test.sh [--native] [--target-branch BRANCH]
#
# Default: ct list-changed plus tpl dependents when charts/tpl changed.
# --native: only charts reported by ct list-changed.

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
      sed -n '1,12p' "$0" | tail -n +2
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

native=$(ct list-changed --target-branch "$TARGET_BRANCH" || true)
charts="$native"

if ! $NATIVE_ONLY && echo "$native" | grep -qx 'charts/tpl'; then
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
fi

echo "$charts" | awk 'NF' | sort -u
