# Changelog

All notable changes to the **generic-cluster-config** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.67] - 2026-06-07

### Added

- CHANGELOG.md and .helmignore

### Changed

- tpl.isEnabled guards across templates, tpl ~1.0.31, Chart.lock refresh

---

## [1.0.66] - 2026-05-31

### Added

- Configurable `ttlSecondsAfterFinished` on the etcd-encryption check Job (default 600s).

---

## [1.0.65] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.1] – [1.0.64] - 2022-07-28 – 2026-03-29

### Added

- Allowed registries, etcd encryption checks, monitoring stack configuration, and user-workload monitoring.
- Dependency on shared **`tpl`** library chart; APIServer custom serving certificate and audit profile configuration.
- Samples operator, external Alertmanager and external labels, `remoteWrite`, metrics server, Google OpenID, cluster proxy, and trusted CA bundle support.
- Node exporter features and resources; README and helm-docs values comments.

### Changed

- Monitoring ConfigMaps refactored for stable field order so Argo CD detects real changes; continued template cleanup using **`tpl`** helpers.

### Fixed

- User-defined monitoring ConfigMap cleanup and toleration ordering.
- Proxy and trusted CA template issues; Artifact Hub metadata fixes.

---

## [1.0.0] - 2022-07-28

### Added

- Initial chart: generic OpenShift cluster configuration (OAuth, etcd encryption, monitoring, console, security, and related cluster settings) from values.

---

[1.0.67]: https://github.com/tjungbauer/helm-charts/compare/generic-cluster-config-1.0.66...generic-cluster-config-1.0.67
[1.0.66]: https://github.com/tjungbauer/helm-charts/compare/generic-cluster-config-1.0.65...generic-cluster-config-1.0.66
[1.0.65]: https://github.com/tjungbauer/helm-charts/compare/generic-cluster-config-1.0.64...generic-cluster-config-1.0.65
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/generic-cluster-config-1.0.0/charts/generic-cluster-config
