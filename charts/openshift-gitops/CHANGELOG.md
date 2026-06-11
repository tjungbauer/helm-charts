# Changelog

All notable changes to the **openshift-gitops** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.1.14] - 2026-06-11

### Changed

- enabled guards use tpl.isEnabled across Argo CD instance templates
- tpl library chart dependency bumped to ~1.0.31

---

## [1.1.13] - 2026-06-10

### Added

- CHANGELOG.md for release notes

---

## [1.1.12] - 2026-05-28

### Fixed

- Disabled the `gitops_application` instance by default (`enabled: false`) so new installs do not create an Argo CD instance unless explicitly configured.

---

## [1.1.11] - 2026-05-28

### Added

- Configurable `controller.processors` for the Argo CD instance (defaults to `{}`).

---

## [1.1.10] - 2026-05-28

### Changed

- Rebuilt the Config Management Plugin (CMP) tooling image; published at `quay.io/tjungbau/gitops-tools:latest`.

---

## [1.1.9] - 2026-05-28

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.1.8] - 2026-05-28

### Added

- Environment variables for the Argo CD **controller** (for example `ARGOCD_CONTROLLER_SHARDING_ALGORITHM=round-robin`).

---

## [1.1.7] - 2026-05-28

### Fixed

- Resource limits and requests for CPU are quoted correctly in templates (avoids YAML/type issues).

---

## [1.1.6] - 2026-05-28

### Fixed

- Default `resourceExclusions` for OpenShift GitOps operator **1.18.0+**.
- LokiStack custom health check Lua script.

---

## [1.1.0] - 2026-05-28

### Added

- Global Argo CD **AppProject** support.
- Repo-server **custom CA** ConfigMap reference.
- Repo-server **sidecar** container (for example post-render scripts).
- **Node selector**, **Keycloak SSO**, optional **OIDC** block, repo-server **env**, **extraConfig**, namespace **labels/annotations**, and controller **sharding** settings.
- Optional **cluster-admin** `ClusterRoleBinding` for the application controller (opt-in via `clusterAdmin: enabled`; default remains `disabled`).
- Dependency on shared **`tpl`** library chart.

### Changed

- Chart cleanup, expanded `values.yaml` / README coverage, configurable sync waves on the Argo CD CR.
- Argo CD CRD API version updates (`v1beta1`).

### Fixed

- Default values and health-check typos.

---

## Earlier releases

See `Chart.yaml` `artifacthub.io/changes` for history before CHANGELOG.md was introduced.

[1.1.14]: https://github.com/tjungbauer/helm-charts/compare/openshift-gitops-1.1.13...openshift-gitops-1.1.14
[1.1.13]: https://github.com/tjungbauer/helm-charts/compare/openshift-gitops-1.1.12...openshift-gitops-1.1.13
[1.1.12]: https://github.com/tjungbauer/helm-charts/compare/openshift-gitops-1.1.11...openshift-gitops-1.1.12
[1.1.11]: https://github.com/tjungbauer/helm-charts/compare/openshift-gitops-1.1.10...openshift-gitops-1.1.11
[1.1.10]: https://github.com/tjungbauer/helm-charts/compare/openshift-gitops-1.1.9...openshift-gitops-1.1.10
[1.1.9]: https://github.com/tjungbauer/helm-charts/compare/openshift-gitops-1.1.8...openshift-gitops-1.1.9
[1.1.8]: https://github.com/tjungbauer/helm-charts/compare/openshift-gitops-1.1.7...openshift-gitops-1.1.8
[1.1.7]: https://github.com/tjungbauer/helm-charts/compare/openshift-gitops-1.1.6...openshift-gitops-1.1.7
[1.1.6]: https://github.com/tjungbauer/helm-charts/compare/openshift-gitops-1.1.0...openshift-gitops-1.1.6
[1.1.0]: https://github.com/tjungbauer/helm-charts/releases/tag/openshift-gitops-1.1.0
