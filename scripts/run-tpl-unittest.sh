#!/usr/bin/env bash
# Run helm-unittest for the tpl library chart via the local harness chart.
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "error: run from inside the helm-charts git repository" >&2
  exit 1
}
cd "$ROOT"

HARNESS="charts/tpl/tests/harness"
HELM_PLUGINS="${HELM_PLUGINS:-${HOME}/Library/helm/plugins}"

ensure_helm_unittest() {
  if [[ -d "${HELM_PLUGINS}/helm-unittest" && -d "${HELM_PLUGINS}/helm-unittest.git" ]]; then
    echo "error: duplicate helm-unittest plugins (Helm cannot load either)." >&2
    echo "Remove the leftover install, then re-run this script:" >&2
    echo "  rm -rf \"${HELM_PLUGINS}/helm-unittest.git\"" >&2
    exit 1
  fi

  if helm unittest --help >/dev/null 2>&1; then
    return 0
  fi

  if helm plugin list 2>/dev/null | grep -qE '^unittest[[:space:]]'; then
    echo "error: unittest plugin is listed but 'helm unittest' is not available." >&2
    exit 1
  fi

  echo "Installing helm-unittest plugin..."
  helm plugin install https://github.com/helm-unittest/helm-unittest --version v0.8.2 --verify=false
}

ensure_helm_unittest

echo "Building harness dependencies (tpl from file://../..)..."
if ! helm dependency build "$HARNESS" 2>/dev/null; then
  helm dependency update "$HARNESS"
fi

echo "Running helm-unittest on $HARNESS ..."
helm unittest "$HARNESS"
