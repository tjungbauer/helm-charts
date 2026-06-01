# Changelog

All notable changes to the **dev-spaces** Helm chart are documented in this file.

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

## [1.0.3] - 2026-06-01

- using tpl.isEnabled now chart-wide.

## [1.0.2] - 2026-06-01

### Changed

- Namespace creation uses `tpl.isEnabled` for the `namespace.create` guard (supports bool and string `"true"` / `"false"`).
- `CHANGELOG.md` and `values.schema.json` for chart values validation and release notes.

---

## [1.0.1] - 2026-05-01

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.0] - 2026-04-01

### Added

- Initial chart: optional Namespace and `CheCluster` (`org.eclipse.che/v2`) for Red Hat OpenShift Dev Spaces.
- Values-driven configuration for components, dev environments, networking, auth, and Git services.
- Template-time validation for log levels, image pull policy, deployment/PVC strategies, timeouts, namespace templates, and storage quantities.

---

[1.0.2]: https://github.com/tjungbauer/helm-charts/compare/dev-spaces-1.0.1...dev-spaces-1.0.2
[1.0.1]: https://github.com/tjungbauer/helm-charts/compare/dev-spaces-1.0.0...dev-spaces-1.0.1
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/dev-spaces-1.0.0/charts/dev-spaces
