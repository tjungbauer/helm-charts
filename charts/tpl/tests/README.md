# tpl library tests

The shared **tpl** chart is a Helm **library** (`type: library`). It does not render manifests on its own, so unit tests use a small **harness** application chart that depends on `tpl` and renders selected `include "tpl.*"` helpers.

## Layout

```
charts/tpl/tests/
├── README.md                 # this file
└── harness/                  # application chart (not published)
    ├── Chart.yaml            # depends on tpl via file://../..
    ├── values.yaml
    ├── templates/            # thin wrappers around tpl defines
    └── tests/                # helm-unittest suites (*_test.yaml)
```

The harness and tests are excluded from the published **tpl** package via `.helmignore` (`tests/`).

## Prerequisites

- Helm 3
- [helm-unittest](https://github.com/helm-unittest/helm-unittest) plugin (v0.8.x)

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest --version v0.8.2 --verify=false
```

If Helm reports **two plugins claim the name "unittest"** (`helm-unittest` and `helm-unittest.git`), remove the duplicate directory (keep `helm-unittest`):

```bash
rm -rf "${HELM_PLUGINS:-$HOME/Library/helm/plugins}/helm-unittest.git"
```

## Run tests locally

From the repository root:

```bash
./scripts/run-tpl-unittest.sh
```

Or manually:

```bash
helm dependency build charts/tpl/tests/harness
helm unittest charts/tpl/tests/harness
```

Run a single suite:

```bash
helm unittest -f 'tests/isEnabled_test.yaml' charts/tpl/tests/harness
```

## What is covered

| Suite | tpl define | Focus |
|-------|------------|--------|
| `isEnabled_test.yaml` | `tpl.isEnabled` | bool/string true/false, unset |
| `tolerations_test.yaml` | `tpl.tolerations` | Equal vs Exists, multiple entries |
| `argocdMetadata_test.yaml` | `tpl.argocdMetadata` | resource vs hook, sync-options, extra |
| `podDisruptionBudget_test.yaml` | `tpl.podDisruptionBudget` | min/max, validation failures |
| `argocdApplication_finalizers_test.yaml` | `tpl.argocdApplication` | finalizers present/absent |
| `resources_test.yaml` | `tpl.resources` / `tpl.appendUnit` | explicit Gi/Mi, bare integer → Gi, cpu passthrough, extendedResources |
| `nodeSelector_test.yaml` | `tpl.nodeSelector` | legacy key/value, multi-label map, unset |
| `jobPodSpec_nodeSelector_test.yaml` | `tpl.jobPodSpec` | multi-label nodeSelector via shared helper |

## CI

When `charts/tpl` is among changed charts, the **Lint and Test Charts** workflow runs the same script after chart-testing lint.

## Adding tests

1. Add or extend a harness template under `harness/templates/` that `include`s the tpl define.
2. Add `harness/tests/<name>_test.yaml` with `suite`, `templates`, `tests`, and `asserts`.
3. If `tpl/Chart.yaml` `version` changes, update the `dependencies[].version` in `harness/Chart.yaml` to match, then `helm dependency build`.

After changing tpl templates, run `./scripts/run-tpl-unittest.sh` before opening a PR.
