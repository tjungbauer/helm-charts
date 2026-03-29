# Helm chart collection (OpenShift / Kubernetes)

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
[![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

Helm charts used to deploy demos and cluster configuration on **OpenShift** and **Kubernetes**. The main consumer is **[openshift-clusterconfig-gitops](https://github.com/tjungbauer/openshift-clusterconfig-gitops)** (“Cluster Bootstrap”); charts can also be installed on their own.

## Use the published repository

Charts are published to **GitHub Pages** (Chart Releaser). Add the repo and search or install as usual:

```bash
helm repo add tjungbauer https://charts.stderr.at/
helm repo update
helm search repo tempo-tracing --versions
```

Browse packages on **[Artifact Hub](https://artifacthub.io/packages/search?repo=openshift-bootstraps)** or open **`charts/<name>/`** in this repository for sources and default `values.yaml`. (sometimes `values-example.yaml`)

Committed **`Chart.lock`** and vendored **`charts/<name>/charts/*.tgz`** subchart packages pin exact versions for reproducible installs and offline mirrors. **`helm package`** artifacts in the repo root stay ignored (`.gitignore`: `/*.tgz`). After dependency changes, run **`helm dependency update`** and commit the lockfile and those archives (CI checks them with **`helm dependency build`**).

## What’s in the repo

Examples of what these charts automate or configure:

- Red Hat Advanced Cluster Security (RHACS) deployment and initialization
- Red Hat Advanced Cluster Management (RHACM)
- OpenShift Data Foundation
- Tekton / pipeline examples
- Compliance Operator stack
- OpenShift Logging
- …and more under **`charts/`**

Per-chart **README** files document settings (mostly generated from **`values.yaml`** comments via **[helm-docs](https://github.com/norwoodj/helm-docs)**).

## Maintainers and support



For **bugs, questions, and expectations** (GitHub Issues, community / best-effort, **no commercial SLA**), read **[SUPPORT.md](SUPPORT.md)**. Maintainer contact in **`Chart.yaml`** is not a substitute for **vendor support** for the underlying products.

## Contribute

Open **issues** and **pull requests** for fixes or improvements. **Bump `version`** in **`Chart.yaml`** for any chart you change so **chart-testing** picks it up on PRs, and update **`annotations.artifacthub.io/changes`** when you publish a new chart version.

## Linting (local and CI)

Charts are expected to pass **[`helm lint`](https://helm.sh/docs/helm/helm_lint/)** and **[chart-testing](https://github.com/helm/chart-testing/blob/main/doc/ct_lint.md)** (`ct lint`).

From the repo root you can mirror the CI lint steps (Helm repos, dependencies, `ct`) with:

```bash
./scripts/lint-and-test-charts-local.sh --all
```

Use **`--all`** to lint every chart under **`charts/`**; omit it to lint only charts changed vs your default branch (see script header for options).

## CI/CD

Two **GitHub Actions** workflows drive validation and releases:

- **Lint and Test Charts** — runs **chart-testing** on charts that changed compared to the default branch, which requires a **SemVer bump** in **`Chart.yaml`** for the chart to be selected.
- **Release Charts** — **Chart Releaser** builds the Helm repository on **GitHub Pages** (branch **`gh-pages`**), served at **<https://charts.stderr.at/>**.





