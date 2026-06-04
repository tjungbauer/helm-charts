# Changelog

All notable changes to the **compliance-operator-full-stack** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.38] - 2026-06-04

### Changed

- CHANGELOG cleanup

---

## [1.0.37] - 2026-06-02

### Fixed

- `values.schema.json` allows `compliance.namespace.descr` and `compliance.namespace.syncwave` (used by GitOps values such as `setup-compliance-operator`).

---

## [1.0.36] - 2026-06-02

### Fixed

- `values.schema.json` allows Helm-injected `global` values so `helm lint` / `helm template` succeed when this chart is used as a dependency.

---

## [1.0.35] - 2026-06-02

### Added

- `values.schema.json` for chart values validation.
- Configurable extra metadata on compliance resources:
  - `compliance.scansettingbinding.additionalAnnotations` / `additionalLabels`
  - `compliance.scansettingbinding.tailored.additionalAnnotations` / `additionalLabels`
- Optional `compliance.scansettingbinding.syncOptions` pass-through for Argo CD sync options.

### Changed

- `ScanSettingBinding` and `TailoredProfile` templates now use `tpl.isEnabled` for boolean/string enable flags.
- Argo CD annotations now use `tpl.argocdMetadata` in compliance templates.
- `tpl` dependency minimum version raised to `~1.0.31`.
- Refreshed `Chart.lock` and vendored dependencies (`helper-operator` 1.0.41, `helper-status-checker` 4.0.17, `tpl` 1.0.31).
- `values.yaml` reorganized so `compliance` settings are grouped at the top.

### Fixed

- TailoredProfile templating scope issues inside `range` loops (`$.Values` root context handling).

---

## [1.0.34] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.33] - 2025-08-21

### Added

- `setValues` support for TailoredProfiles.

### Fixed

- TailoredProfile templating bug fixes.

---

## [1.0.2] - 2022-07-24

### Added

- Initial chart release.

---

[1.0.38]: https://github.com/tjungbauer/helm-charts/compare/compliance-operator-full-stack-1.0.37...compliance-operator-full-stack-1.0.38
[1.0.37]: https://github.com/tjungbauer/helm-charts/compare/compliance-operator-full-stack-1.0.36...compliance-operator-full-stack-1.0.37
[1.0.36]: https://github.com/tjungbauer/helm-charts/compare/compliance-operator-full-stack-1.0.35...compliance-operator-full-stack-1.0.36
[1.0.35]: https://github.com/tjungbauer/helm-charts/compare/compliance-operator-full-stack-1.0.34...compliance-operator-full-stack-1.0.35
[1.0.34]: https://github.com/tjungbauer/helm-charts/compare/compliance-operator-full-stack-1.0.33...compliance-operator-full-stack-1.0.34
[1.0.33]: https://github.com/tjungbauer/helm-charts/compare/compliance-operator-full-stack-1.0.32...compliance-operator-full-stack-1.0.33
[1.0.2]: https://github.com/tjungbauer/helm-charts/tree/compliance-operator-full-stack-1.0.2/charts/compliance-operator-full-stack
