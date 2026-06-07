#!/usr/bin/env bash
# Regression tests for scripts/list-charts-to-test.sh
#
# Uses real git SHAs from this repository. Does not modify the working tree.
# Run from repo root: ./scripts/test-chart-detection.sh

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "error: run from inside the helm-charts git repository" >&2
  exit 1
}
cd "$ROOT"

SCRIPT="$ROOT/scripts/list-charts-to-test.sh"
[[ -x "$SCRIPT" ]] || {
  echo "error: missing $SCRIPT" >&2
  exit 1
}

pass=0
fail=0

assert_contains() {
  local name="$1"
  local haystack="$2"
  local needle="$3"

  if echo "$haystack" | grep -qx "$needle"; then
    echo "PASS: $name"
    pass=$((pass + 1))
  else
    echo "FAIL: $name — expected '$needle' in:"
    echo "$haystack" | sed 's/^/  /'
    fail=$((fail + 1))
  fi
  return 0
}

assert_empty() {
  local name="$1"
  local haystack="$2"

  if [[ -z "${haystack//[$'\t\r\n ']/}" ]]; then
    echo "PASS: $name"
    pass=$((pass + 1))
  else
    echo "FAIL: $name — expected empty, got:"
    echo "$haystack" | sed 's/^/  /'
    fail=$((fail + 1))
  fi
  return 0
}

assert_min_lines() {
  local name="$1"
  local haystack="$2"
  local min="$3"
  local count
  count=$(echo "$haystack" | awk 'NF' | wc -l | tr -d ' ')

  if [[ "$count" -ge "$min" ]]; then
    echo "PASS: $name ($count lines >= $min)"
    pass=$((pass + 1))
  else
    echo "FAIL: $name — expected >= $min lines, got $count"
    fail=$((fail + 1))
  fi
  return 0
}

echo "Chart detection regression tests"
echo "Repository: $ROOT"
echo

HEAD_SHA=$(git rev-parse HEAD)
PARENT_SHA=$(git rev-parse HEAD~1)
RELEASE_SHA="$HEAD_SHA"
DOCS_SHA=$(git rev-parse HEAD~1 2>/dev/null || echo "")
TPL_RELEASE_PARENT=$(git rev-parse "${RELEASE_SHA}^" 2>/dev/null || echo "")

# --- push to main: github.event.before -> github.event.after ---
out=$(CT_BASE_REF="$PARENT_SHA" CT_HEAD_REF="$RELEASE_SHA" CT_TARGET_BRANCH=main "$SCRIPT" --native --target-branch main)
assert_contains "push main (before/after SHAs)" "$out" "charts/tpl"

# --- workflow_run / detached HEAD: HEAD~1 fallback (no CT_BASE_REF) ---
wt=$(mktemp -d)
git worktree add --detach "$wt" "$RELEASE_SHA"
cp "$SCRIPT" "$wt/scripts/list-charts-to-test.sh"
chmod +x "$wt/scripts/list-charts-to-test.sh"
out=$(CT_TARGET_BRANCH=main "$wt/scripts/list-charts-to-test.sh" --native --target-branch main)
assert_contains "detached HEAD at release commit (HEAD~1 fallback)" "$out" "charts/tpl"
git worktree remove --force "$wt"

# --- docs commit: last commit may only touch README files under charts/ ---
if [[ -n "$DOCS_SHA" && "$DOCS_SHA" != "$RELEASE_SHA" ]]; then
  docs_parent=$(git rev-parse "${DOCS_SHA}^")
  out=$(CT_BASE_REF="$docs_parent" CT_HEAD_REF="$DOCS_SHA" CT_TARGET_BRANCH=main "$SCRIPT" --native --target-branch main)
  assert_min_lines "docs commit detects charts with README changes" "$out" 1
fi

# --- ct list-changed on main: empty (known limitation) ---
wt=$(mktemp -d)
git worktree add --detach "$wt" "$RELEASE_SHA"
out=$(CT_TARGET_BRANCH=main ct list-changed --target-branch main 2>/dev/null || true)
git worktree remove --force "$wt"
assert_empty "ct list-changed on main tip (known limitation)" "$out"

# --- tpl expansion ---
out=$(CT_BASE_REF="$PARENT_SHA" CT_HEAD_REF="$RELEASE_SHA" "$SCRIPT" --target-branch main)
assert_contains "tpl expansion includes tpl" "$out" "charts/tpl"
assert_min_lines "tpl expansion includes dependents" "$out" 30

# --- commit range with no chart changes ---
if git rev-parse HEAD~10 >/dev/null 2>&1; then
  for i in $(seq 2 10); do
    OLD=$(git rev-parse "HEAD~$((i+1))")
    MID=$(git rev-parse "HEAD~$i")
    chart_files=$(git diff --name-only "$OLD" "$MID" | grep -c '^charts/' || true)
    if [[ "$chart_files" -eq 0 ]]; then
      out=$(CT_BASE_REF="$OLD" CT_HEAD_REF="$MID" "$SCRIPT" --native --target-branch main)
      assert_empty "commit range with no chart changes (HEAD~$((i+1))..HEAD~$i)" "$out"
      break
    fi
  done
fi

echo
echo "Results: $pass passed, $fail failed"
[[ "$fail" -eq 0 ]]
