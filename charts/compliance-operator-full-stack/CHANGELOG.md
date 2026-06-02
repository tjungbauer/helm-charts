# Changelog

All notable changes to the **compliance-operator-full-stack** Helm chart are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and chart releases follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html) via `Chart.yaml` `version`.

## How this file relates to other metadata

| Location | Purpose |
|----------|---------|
| **`CHANGELOG.md` (this file)** | Human-readable history for maintainers and chart consumers; grouped by version with Added / Changed / Fixed / Security / Removed. |
| **`Chart.yaml` `version`** | SemVer of the **chart package**; bump on every releaseable change. |
| **`Chart.yaml` `annotations.artifacthub.io/changes`** | Short bullets for [Artifact Hub](https://artifacthub.io/) on **each published version only**—keep in sync when you cut a release. |
| **`values.schema.json`** | JSON Schema for `values.yaml`; used by `helm lint` and editors with schema support. |

**Workflow**

1. Add user-visible bullets under **`[Unreleased]`** while developing.
2. On release: rename `[Unreleased]` → `[x.y.z] - YYYY-MM-DD`, bump `Chart.yaml` `version`, and copy the **same bullets** (shortened if needed) into `artifacthub.io/changes` for that version.
3. Update **`values.schema.json`** when you add, rename, or constrain values keys.
4. Do **not** duplicate typo-only or internal refactors here unless operators would care when upgrading.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

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

[1.0.35]: https://github.com/tjungbauer/helm-charts/compare/compliance-operator-full-stack-1.0.34...compliance-operator-full-stack-1.0.35
[1.0.34]: https://github.com/tjungbauer/helm-charts/compare/compliance-operator-full-stack-1.0.33...compliance-operator-full-stack-1.0.34
[1.0.33]: https://github.com/tjungbauer/helm-charts/compare/compliance-operator-full-stack-1.0.32...compliance-operator-full-stack-1.0.33
[1.0.2]: https://github.com/tjungbauer/helm-charts/tree/compliance-operator-full-stack-1.0.2/charts/compliance-operator-full-stack
