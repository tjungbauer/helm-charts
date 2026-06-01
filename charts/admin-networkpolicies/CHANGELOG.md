# Changelog

All notable changes to the **admin-networkpolicies** Helm chart are documented in this file.

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

## [1.0.8] - 2026-06-01

### Changed

- ANP, BANP, and per-rule `enabled` guards use `tpl.isEnabled` (supports bool and string `"true"` / `"false"`).
- `tpl` dependency minimum version raised to `~1.0.31`.
- `CHANGELOG.md` and `values.schema.json` for chart values validation and release notes.

---

## [1.0.7] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.6] - 2025-07-07

### Changed

- `tpl` dependency minimum version raised to `~1.0.22`.

---

## [1.0.5] - 2025-07-03

### Changed

- Chart version bump (release workflow validation).

---

## [1.0.4] - 2025-06-06

### Fixed

- Port range rendering: use `portStart` / `portEnd` with `portRange` instead of `portEndNumber` on `portNumber`.

---

## [1.0.3] - 2025-06-06

### Added

- Optional `portEndNumber` on port rules (superseded in 1.0.4 by `portStart` / `portEnd`).

---

## [1.0.2] - 2024-11-07

### Added

- `README.md`, `README.md.gotmpl`, and helm-docs comments in `values.yaml`.
- Expanded `values.yaml` examples for ANP and BANP (ingress, egress, subject, peers).

### Changed

- Template and helper fixes for subject selection and rule rendering.
- Blog post link added to `Chart.yaml` sources.

### Fixed

- Ingress rule name typo (`ass-from-restricted-tenants` → `pass-from-restricted-tenants`).

---

## [1.0.1] - 2024-11-05

### Changed

- Chart directory renamed from `adminnetworkpolicies` to `admin-networkpolicies`.

---

## [1.0.0] - 2024-11-05

### Added

- Initial chart: `AdminNetworkPolicy` and `BaselineAdminNetworkPolicy` (`policy.networking.k8s.io/v1alpha1`) from values.
- Values-driven ingress/egress rules with namespace, pod, node, network, and domain peer types.
- Argo CD sync-wave annotations on rendered policies.

---

[1.0.8]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.7...admin-networkpolicies-1.0.8
[1.0.7]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.6...admin-networkpolicies-1.0.7
[1.0.6]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.5...admin-networkpolicies-1.0.6
[1.0.5]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.4...admin-networkpolicies-1.0.5
[1.0.4]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.3...admin-networkpolicies-1.0.4
[1.0.3]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.2...admin-networkpolicies-1.0.3
[1.0.2]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.1...admin-networkpolicies-1.0.2
[1.0.1]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.0...admin-networkpolicies-1.0.1
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/admin-networkpolicies-1.0.0/charts/adminnetworkpolicies
