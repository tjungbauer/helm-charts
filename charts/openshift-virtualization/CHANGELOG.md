# Changelog

All notable changes to the **openshift-virtualization** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.3] - 2026-06-10

### Added

- CHANGELOG.md and .helmignore

### Changed

- tpl dependency minimum version raised to ~1.0.31 and Chart.lock refreshed

---

## [1.0.2] - 2026-03-30

### Changed

- Add Chart.lock for reproducible installs, refresh resolved dependencies, maintainer email

---

## [1.0.1] - 2026-03-27

### Added

- `enableCommonBootImageImport`, `deployVmConsoleProxy`, and `enableApplicationAwareQuota` as direct `spec` fields (no longer under `featureGates`)

---

## [1.0.0] - 2025-08-08

### Added

- Initial release: HyperConverged and HostPathProvisioner configuration for OpenShift Virtualization (CNV)
- **tpl** subchart dependency for labels and annotations helpers
- `additionalLabels` and `additionalAnnotations` on HyperConverged and HostPathProvisioner resources

---

[1.0.3]: https://github.com/tjungbauer/helm-charts/compare/openshift-virtualization-1.0.2...openshift-virtualization-1.0.3
[1.0.2]: https://github.com/tjungbauer/helm-charts/compare/openshift-virtualization-1.0.1...openshift-virtualization-1.0.2
[1.0.1]: https://github.com/tjungbauer/helm-charts/compare/openshift-virtualization-1.0.0...openshift-virtualization-1.0.1
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/openshift-virtualization-1.0.0/charts/openshift-virtualization
