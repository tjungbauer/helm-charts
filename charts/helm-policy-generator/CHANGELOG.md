# Changelog

All notable changes to the **helm-policy-generator** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.19] - 2026-06-02

### Added

- tpl.argocdMetadata and per-resource additionalAnnotations and additionalLabels on Namespace, PolicySet, Policy, Placement, and PlacementBinding

### Changed

- enabled guards use tpl.isEnabled

---

## [1.0.18] - 2026-06-08

### Changed

- Add Chart.lock for reproducible installs, refresh resolved dependencies, maintainer email

---

## Earlier releases

See `Chart.yaml` `artifacthub.io/changes` for history before CHANGELOG.md was introduced.

[1.0.19]: https://github.com/tjungbauer/helm-charts/compare/helm-policy-generator-1.0.18...helm-policy-generator-1.0.19
[1.0.18]: https://github.com/tjungbauer/helm-charts/compare/helm-policy-generator-1.0.17...helm-policy-generator-1.0.18
