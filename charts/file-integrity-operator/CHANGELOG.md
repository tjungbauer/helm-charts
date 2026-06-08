# Changelog

All notable changes to the **file-integrity-operator** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.15] - 2026-06-02

### Added

- tpl.argocdMetadata and per-resource additionalAnnotations and additionalLabels on FileIntegrity CRs and control plane AIDE ConfigMap

### Changed

- enabled guards use tpl.isEnabled

### Fixed

- FileIntegrity spec.tolerations rendered at spec level instead of under spec.config

---

## [1.0.14] - 2026-06-08

### Changed

- Add Chart.lock for reproducible installs, refresh resolved dependencies, maintainer email

---

## Earlier releases

See `Chart.yaml` `artifacthub.io/changes` for history before CHANGELOG.md was introduced.

[1.0.15]: https://github.com/tjungbauer/helm-charts/compare/file-integrity-operator-1.0.14...file-integrity-operator-1.0.15
[1.0.14]: https://github.com/tjungbauer/helm-charts/compare/file-integrity-operator-1.0.13...file-integrity-operator-1.0.14
