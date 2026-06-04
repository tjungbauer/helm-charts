# Changelog

All notable changes to the **helper-status-checker** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [4.0.21] - 2026-06-04

### Changed

- chart-root additionalLabels and additionalAnnotations only (removed per-check metadata),random Job name suffix, CHANGELOG

---

## [4.0.20] - 2026-06-04

### Changed

- Hook resources use `tpl.argocdMetadata` via `helper-status-checker.hookAnnotations` (hook, hook-delete-policy, sync-wave, optional sync-options, additional annotations).

### Added

- Chart-root `additionalAnnotations` and `additionalLabels` on all hook resources (ServiceAccount, ClusterRole, ClusterRoleBinding, Jobs).

---

## [4.0.19] - 2026-06-02

### Changed

- `enabled` and `approver` guards use `tpl.isEnabled` (supports bool and string `"true"` / `"false"`).
- `tpl` dependency minimum version raised to `~1.0.31`; refreshed `Chart.lock`.

---

## [4.0.18] - 2026-03-30

### Added

- Configurable `ttlSecondsAfterFinished` on status-check and installplan Jobs (default 600s).

---

## [4.0.17] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [4.0.1] – [4.0.16] - 2024-06-25 – 2026-03-29

### Added

- Multi-operator `checks[]` support (4.0.0).
- `subscriptionName` for installplan approver when Subscription name differs from operator name.
- **`tpl`** subchart dependency; `tpl.sleeptimer` in Job scripts.
- InstallPlan-not-found check and installplan approver output improvements.

### Changed

- ClusterRole/ClusterRoleBinding fixes; default sync-wave 0; hook delete policy on installplan approver Job.

### Fixed

- Wrong ClusterRole for installplan approver.

---

## [4.0.0] - 2024-06-25

### Added

- Initial multi-check release: range of status checks to verify multiple operators.

---

[4.0.22]: https://github.com/tjungbauer/helm-charts/compare/helper-status-checker-4.0.21...helper-status-checker-4.0.22
[4.0.21]: https://github.com/tjungbauer/helm-charts/compare/helper-status-checker-4.0.20...helper-status-checker-4.0.21
[4.0.20]: https://github.com/tjungbauer/helm-charts/compare/helper-status-checker-4.0.19...helper-status-checker-4.0.20
[4.0.19]: https://github.com/tjungbauer/helm-charts/compare/helper-status-checker-4.0.18...helper-status-checker-4.0.19
[4.0.18]: https://github.com/tjungbauer/helm-charts/compare/helper-status-checker-4.0.17...helper-status-checker-4.0.18
[4.0.17]: https://github.com/tjungbauer/helm-charts/compare/helper-status-checker-4.0.16...helper-status-checker-4.0.17
[4.0.0]: https://github.com/tjungbauer/helm-charts/tree/helper-status-checker-4.0.0/charts/helper-status-checker
