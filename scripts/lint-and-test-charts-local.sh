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
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  local exit_code="${1:-0}"
  sed -n '1,20p' "$0" | tail -n +2
  exit "$exit_code"
  return 0
}

while [[ $# -gt 0 ]]; do
  opt="$1"
  case "$opt" in
    --all) LINT_ALL=true ;;
    --target-branch)
      branch="${2:?--target-branch requires an argument}"
      TARGET_BRANCH="$branch"
      shift
      ;;
    --with-install) WITH_INSTALL=true ;;
    -h | --help) usage 0 ;;
    *)
      echo "unknown option: $opt" >&2
      usage 1
      ;;
  esac
  shift
done

need_cmd() {
  local cmd="$1"
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "error: required command '$cmd' not found in PATH" >&2
    exit 1
  }
  return 0
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
  helm repo add sealed-secrets https://bitnami.github.io/sealed-secrets 2>/dev/null || true
  helm repo update
  return 0
}

dep_update_if_needed() {
  local chart="$1"
  if [[ -f "${chart}/Chart.yaml" ]] && grep -q '^dependencies:' "${chart}/Chart.yaml"; then
    echo "helm dependency update ${chart}"
    helm dependency update "${chart}"
  fi
  return 0
}

verify_dependency_build() {
  local charts="$1"
  while IFS= read -r chart; do
    [[ -z "${chart// }" ]] && continue
    case "$chart" in
      charts/test-chart) continue ;;
      *) ;;
    esac
    if [[ -f "${chart}/Chart.yaml" ]] && grep -q '^dependencies:' "${chart}/Chart.yaml"; then
      echo "helm dependency build ${chart}"
      helm dependency build "${chart}"
    fi
  done <<< "$charts"
  if ! git diff --exit-code; then
    echo "error: tracked files changed after helm dependency build — run helm dependency build locally and commit Chart.lock and/or charts/*/charts/*.tgz" >&2
    git diff
    exit 1
  fi
  return 0
}

tpl_dependents_csv() {
  local native="$1"
  local charts="$2"
  local chart csv=""

  if ! echo "$native" | grep -qx 'charts/tpl'; then
    return 0
  fi

  while IFS= read -r chart; do
    [[ -z "${chart// }" ]] && continue
    if ! echo "$native" | grep -qx "$chart"; then
      csv="${csv:+$csv,}${chart}"
    fi
  done <<< "$charts"

  if [[ -n "$csv" ]]; then
    printf '%s' "$csv"
  fi
  return 0
}

run_lint_changed_on_main() {
  local charts native charts_csv
  charts="$("$SCRIPT_DIR/list-charts-to-test.sh" --target-branch "$TARGET_BRANCH")"
  native="$("$SCRIPT_DIR/list-charts-to-test.sh" --native --target-branch "$TARGET_BRANCH")"

  if [[ -z "${charts//[$'\t\r\n ']/}" ]]; then
    echo "No charts changed vs ${TARGET_BRANCH} (local git only) — nothing to lint."
    echo "Tip: commit on a branch, or run with --all to lint every chart."
    return 0
  fi

  echo "Changed charts (native):"
  echo "$native"
  echo "Charts to test (including tpl dependents when applicable):"
  echo "$charts"

  helm_ensure_repos
  verify_dependency_build "$charts"

  while IFS= read -r chart; do
    [[ -z "${chart// }" ]] && continue
    dep_update_if_needed "$chart"
  done <<< "$charts"

  charts_csv=$(echo "$charts" | paste -sd, -)
  ct lint --debug --charts "$charts_csv" --check-version-increment=false
  return 0
}

run_lint_changed() {
  local current_branch native_from_ct
  current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
  native_from_ct="$(ct list-changed --target-branch "$TARGET_BRANCH" 2>/dev/null || true)"

  if [[ -n "${native_from_ct//[$'\t\r\n ']/}" ]]; then
    run_lint_changed_on_pr_branch
  elif [[ "$current_branch" == "$TARGET_BRANCH" ]]; then
    run_lint_changed_on_main
  else
    run_lint_changed_on_pr_branch
  fi
  return 0
}

run_lint_changed_on_pr_branch() {
  local charts native tpl_dependents
  charts="$("$SCRIPT_DIR/list-charts-to-test.sh" --target-branch "$TARGET_BRANCH")"
  native="$("$SCRIPT_DIR/list-charts-to-test.sh" --native --target-branch "$TARGET_BRANCH")"

  if [[ -z "${charts//[$'\t\r\n ']/}" ]]; then
    echo "No charts changed vs ${TARGET_BRANCH} (local git only) — nothing to lint."
    echo "Tip: commit on a branch, or run with --all to lint every chart."
    return 0
  fi

  echo "Changed charts (native):"
  echo "$native"
  echo "Charts to test (including tpl dependents when applicable):"
  echo "$charts"

  helm_ensure_repos
  verify_dependency_build "$charts"

  while IFS= read -r chart; do
    [[ -z "${chart// }" ]] && continue
    dep_update_if_needed "$chart"
  done <<< "$charts"

  ct lint --debug --target-branch "$TARGET_BRANCH"

  tpl_dependents="$(tpl_dependents_csv "$native" "$charts")"
  if [[ -n "$tpl_dependents" ]]; then
    echo "Linting tpl dependents (no version increment check): $tpl_dependents"
    ct lint --debug --charts "$tpl_dependents" --check-version-increment=false
  fi
  return 0
}

run_lint_all() {
  local d
  for d in charts/*/; do
    [[ -d "$d" ]] || continue
    case "$(basename "$d")" in
      test-chart) continue ;;
      *) ;;
    esac
    dep_update_if_needed "${d%/}"
  done
  ct lint --debug --all
  return 0
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
    return 0
  }
  if [[ "$create" -eq 1 ]]; then
    trap cleanup EXIT
  fi

  if $LINT_ALL; then
    ct install --all
  else
    local charts charts_csv
    charts="$("$SCRIPT_DIR/list-charts-to-test.sh" --target-branch "$TARGET_BRANCH")"
    charts_csv=$(echo "$charts" | paste -sd, -)
    ct install --charts "$charts_csv"
  fi

  trap - EXIT 2>/dev/null || true
  cleanup
  return 0
}

if $LINT_ALL; then
  echo "Lint mode: --all (entire charts/)"
  helm_ensure_repos
  run_lint_all
else
  echo "Lint mode: changed charts vs ${TARGET_BRANCH}"
  run_lint_changed
fi

if $WITH_INSTALL; then
  echo "Running ct install (kind) …"
  helm_ensure_repos
  run_install_kind
else
  echo "Skipping kind / ct install (use --with-install to enable, as on pull_request in CI)."
fi

echo "OK"
