# Changelog

All notable changes to the **tempo-tracing** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.8] - 2026-06-10

### Added

- tpl.argocdMetadata on TempoStack, Namespace, ServiceAccount, and tenant ClusterRole resources

### Changed

- enabled guards use tpl.isEnabled across templates and validation helpers

---

## [1.0.7] - 2026-06-10

### Changed

- Add Chart.lock for reproducible installs, refresh resolved dependencies, maintainer dev@stdin.at

---

## Earlier releases

See `Chart.yaml` `artifacthub.io/changes` for history before CHANGELOG.md was introduced.

[1.0.8]: https://github.com/tjungbauer/helm-charts/compare/tempo-tracing-1.0.7...tempo-tracing-1.0.8
[1.0.7]: https://github.com/tjungbauer/helm-charts/tree/tempo-tracing-1.0.7/charts/tempo-tracing
