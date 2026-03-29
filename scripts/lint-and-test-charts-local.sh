#!/usr/bin/env bash
# Run the same checks as .github/workflows/lint_and_test_charts.yml locally.
#
# Prerequisites:
#   - helm (v3)
#   - ct (chart-testing): https://github.com/helm/chart-testing
#       macOS: brew install chart-testing
#   - For --with-install: kind, kubectl, Docker
#
# Usage:
#   ./scripts/lint-and-test-charts-local.sh              # charts changed vs target branch (local git only; no fetch)
#   ./scripts/lint-and-test-charts-local.sh --all        # every chart under charts/ (best pre-push)
#   ./scripts/lint-and-test-charts-local.sh --target-branch main
#   ./scripts/lint-and-test-charts-local.sh --with-install
#
# Optional env:
#   CT_TARGET_BRANCH   default branch to diff against (default: main)
#   HELM_CACHE_HOME    writable Helm cache (useful in restricted sandboxes)

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "error: run this script from inside the helm-charts git repository" >&2
  exit 1
}
cd "$ROOT"

TARGET_BRANCH="${CT_TARGET_BRANCH:-main}"
LINT_ALL=false
WITH_INSTALL=false

usage() {
  sed -n '1,20p' "$0" | tail -n +2
  exit "${1:-0}"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all) LINT_ALL=true ;;
    --target-branch)
      TARGET_BRANCH="${2:?--target-branch requires an argument}"
      shift
      ;;
    --with-install) WITH_INSTALL=true ;;
    -h | --help) usage 0 ;;
    *)
      echo "unknown option: $1" >&2
      usage 1
      ;;
  esac
  shift
done

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "error: required command '$1' not found in PATH" >&2
    exit 1
  }
}

need_cmd git
need_cmd helm
need_cmd ct

helm_ensure_repos() {
  # Base set (workflow). `ct lint` runs `helm dependency build`, which requires every
  # dependency repository URL from Chart.lock to appear in `helm repo list` (exact URL).
  helm repo add stable https://charts.helm.sh/stable 2>/dev/null || true
  helm repo add incubator https://charts.helm.sh/incubator 2>/dev/null || true
  helm repo add bitnami https://charts.bitnami.com/bitnami 2>/dev/null || true
  # Charts in this repo (see Chart.yaml repository: fields)
  helm repo add tjungbauer https://charts.stderr.at/ 2>/dev/null || true
  helm repo add sonarsource https://SonarSource.github.io/helm-chart-sonarqube 2>/dev/null || true
  helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets 2>/dev/null || true
  helm repo update
}

dep_update_if_needed() {
  local chart="$1"
  if [[ -f "${chart}/Chart.yaml" ]] && grep -q '^dependencies:' "${chart}/Chart.yaml"; then
    echo "helm dependency update ${chart}"
    helm dependency update "${chart}"
  fi
}

run_lint_changed() {
  local changed
  changed="$(ct list-changed --target-branch "$TARGET_BRANCH")" || true
  if [[ -z "${changed//[$'\t\r\n ']/}" ]]; then
    echo "No charts changed vs ${TARGET_BRANCH} (local git only) — nothing to lint."
    echo "Tip: commit on a branch, or run with --all to lint every chart."
    return 0
  fi
  echo "Changed charts:"
  echo "$changed"
  while IFS= read -r chart; do
    [[ -z "${chart// }" ]] && continue
    dep_update_if_needed "$chart"
  done <<< "$changed"
  ct lint --debug --target-branch "$TARGET_BRANCH"
}

run_lint_all() {
  local d
  for d in charts/*/; do
    [[ -d "$d" ]] || continue
    case "$(basename "$d")" in
      test-chart) continue ;;
    esac
    dep_update_if_needed "${d%/}"
  done
  ct lint --debug --all
}

run_install_kind() {
  need_cmd kind
  need_cmd kubectl
  local cluster="${KIND_CLUSTER_NAME:-ct-local}"
  local create=0
  if ! kind get clusters 2>/dev/null | grep -qx "$cluster"; then
    echo "creating kind cluster: $cluster"
    kind create cluster --name "$cluster" --wait 5m
    create=1
  else
    echo "using existing kind cluster: $cluster"
  fi
  kubectl cluster-info --context "kind-${cluster}"

  cleanup() {
    if [[ "$create" -eq 1 ]]; then
      echo "deleting kind cluster: $cluster"
      kind delete cluster --name "$cluster" 2>/dev/null || true
    fi
  }
  if [[ "$create" -eq 1 ]]; then
    trap cleanup EXIT
  fi

  if $LINT_ALL; then
    ct install --all
  else
    ct install --target-branch "$TARGET_BRANCH"
  fi

  trap - EXIT 2>/dev/null || true
  cleanup
}

helm_ensure_repos

if $LINT_ALL; then
  echo "Lint mode: --all (entire charts/)"
  run_lint_all
else
  echo "Lint mode: changed charts vs ${TARGET_BRANCH}"
  run_lint_changed
fi

if $WITH_INSTALL; then
  echo "Running ct install (kind) …"
  run_install_kind
else
  echo "Skipping kind / ct install (use --with-install to enable, as on pull_request in CI)."
fi

echo "OK"
