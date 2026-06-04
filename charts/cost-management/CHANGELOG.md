# Changelog

All notable changes to the **cost-management** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.17] - 2026-06-04

### Changed

- CHANGELOG cleanup

---

## [1.0.16] - 2026-06-02

### Changed

- `costmgmt.enabled` and `costmgmt.airgapped` guards use `tpl.isEnabled` (supports bool and string `"true"` / `"false"`).
- Argo CD metadata on `CostManagementMetricsConfig` uses `tpl.argocdMetadata` (`syncwave`, `syncOptions`, `additionalAnnotations`).
- Custom labels via `tpl.additionalLabels` and `costmgmt.additionalLabels`.
- `tpl` dependency minimum version raised to `~1.0.31`; refreshed `Chart.lock` and packaged subcharts.

### Added

- `costmgmt.syncwave`, `additionalAnnotations`, and `additionalLabels` in `values.yaml`; `syncOptions` configurable on `costmgmt` (default unchanged).
- `CHANGELOG.md` and `.helmignore` entry for `README.md.gotmpl`.

---

## [1.0.15] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.14] - 2025-07-07

### Changed

- Chart version bump and helm-docs refresh (release workflow validation).

---

## [1.0.13] - 2025-07-03

### Changed

- Chart version bump and helm-docs refresh (release workflow validation).

---

## [1.0.12] - 2025-06-30

### Added

- Source configuration parameters on `CostManagementMetricsConfig` (`source.check_cycle`, `create_source`, `name`, `sources_path`).

### Fixed

- `auth_secret` is rendered only when set (avoids empty `secret_name`).

---

## [1.0.11] - 2025-06-30

### Added

- Source configuration parameters on `CostManagementMetricsConfig` (initial values and template support).

---

## [1.0.10] - 2024-06-25

### Changed

- Switched templates to the shared **`tpl`** library (`tpl.labels`, standard chart labels).

### Added

- **`tpl`** subchart dependency.

---

## [1.0.9] - 2024-04-18

### Changed

- Dependency and chart version alignment with the helm-charts release workflow.

---

## [1.0.7] - 2024-04-10

### Changed

- Updated **`helper-status-checker`** dependency to v4.

---

## [1.0.1] – [1.0.6] - 2024-02-05 – 2024-03-12

### Added

- `README.md`, `README.md.gotmpl`, and helm-docs comments in `values.yaml`.
- Expanded `values.yaml` parameters for `CostManagementMetricsConfig` (packaging, upload, prometheus, authentication).

### Changed

- Chart metadata and version bumps across the 1.0.x line.
- Typo fixes in documentation and values comments.

---

## [1.0.0] - 2024-01-22

### Added

- Initial chart: installs the cost-management metrics operator via **`helper-operator`** and renders `CostManagementMetricsConfig` (`costmanagement-metrics-cfg.openshift.io/v1beta1`).
- Optional **`helper-status-checker`** subchart for post-install validation.
- Argo CD sync-wave annotation on the metrics config CR.

---

[1.0.17]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.16...cost-management-1.0.17
[1.0.16]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.15...cost-management-1.0.16
[1.0.15]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.14...cost-management-1.0.15
[1.0.14]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.13...cost-management-1.0.14
[1.0.13]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.12...cost-management-1.0.13
[1.0.12]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.11...cost-management-1.0.12
[1.0.11]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.10...cost-management-1.0.11
[1.0.10]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.9...cost-management-1.0.10
[1.0.9]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.7...cost-management-1.0.9
[1.0.7]: https://github.com/tjungbauer/helm-charts/compare/cost-management-1.0.6...cost-management-1.0.7
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/cost-management-1.0.0/charts/cost-management
