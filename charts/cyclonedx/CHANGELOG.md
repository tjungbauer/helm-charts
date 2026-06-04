# Changelog

All notable changes to the **cyclonedx** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.12] - 2026-06-04

### Changed

- CHANGELOG cleanup

---

## [1.0.11] - 2026-06-02

### Changed

- `namespace.create` guard uses `tpl.isEnabled` (supports bool and string `"true"` / `"false"`).
- Argo CD metadata on Namespace, Deployment, Service, and Route uses `tpl.argocdMetadata` (`syncwave`, `syncOptions`, `additionalAnnotations`).
- Custom labels via `tpl.additionalLabels` and root `additionalLabels`.
- `tpl` dependency minimum version raised to `~1.0.31`; refreshed `Chart.lock`.

### Added

- Root values `syncwave`, `syncOptions`, `additionalAnnotations`, and `additionalLabels` for all rendered resources.
- `CHANGELOG.md` and `.helmignore` (excludes `README.md.gotmpl` from packaged chart).

---

## [1.0.10] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.9] - 2025-07-07

### Changed

- Chart version bump and helm-docs refresh (release workflow validation).

---

## [1.0.8] - 2025-07-03

### Changed

- Chart version bump and helm-docs refresh (release workflow validation).

---

## [1.0.7] - 2024-06-25

### Changed

- Switched templates to the shared **`tpl`** library (`tpl.labels` on rendered resources).

### Added

- **`tpl`** subchart dependency.

---

## [1.0.1] – [1.0.6] - 2024-01-21 – 2024-04-18

### Added

- `README.md`, `README.md.gotmpl`, and helm-docs comments in `values.yaml`.

### Changed

- Chart metadata and version bumps across the 1.0.x line.
- README typo fixes.

---

## [1.0.0] - 2023-09-25

### Added

- Initial chart: CycloneDX BOM repository server (Deployment, Service, OpenShift Route) with optional Namespace creation.

---

[1.0.12]: https://github.com/tjungbauer/helm-charts/compare/cyclonedx-1.0.11...cyclonedx-1.0.12
[1.0.11]: https://github.com/tjungbauer/helm-charts/compare/cyclonedx-1.0.10...cyclonedx-1.0.11
[1.0.10]: https://github.com/tjungbauer/helm-charts/compare/cyclonedx-1.0.9...cyclonedx-1.0.10
[1.0.9]: https://github.com/tjungbauer/helm-charts/compare/cyclonedx-1.0.8...cyclonedx-1.0.9
[1.0.8]: https://github.com/tjungbauer/helm-charts/compare/cyclonedx-1.0.7...cyclonedx-1.0.8
[1.0.7]: https://github.com/tjungbauer/helm-charts/compare/cyclonedx-1.0.6...cyclonedx-1.0.7
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/cyclonedx-1.0.0/charts/cyclonedx
