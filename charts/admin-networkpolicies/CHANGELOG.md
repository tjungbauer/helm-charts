# Changelog

All notable changes to the **admin-networkpolicies** Helm chart are documented in this file.

---

## [1.0.11] - 2026-06-11

### Changed

- per-policy additionalLabels and additionalAnnotations on AdminNetworkPolicy and BaselineAdminNetworkPolicy via tpl.argocdMetadata

---

## [1.0.10] - 2026-06-04

### Changed

- CHANGELOG cleanup

---

## [1.0.9] - 2026-06-02

### Fixed

- `values.schema.json` allows Helm-injected `global` values so `helm lint` / `helm template` succeed when this chart is used as a dependency.

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

[1.0.11]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.10...admin-networkpolicies-1.0.11
[1.0.10]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.9...admin-networkpolicies-1.0.10
[1.0.9]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.8...admin-networkpolicies-1.0.9
[1.0.8]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.7...admin-networkpolicies-1.0.8
[1.0.7]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.6...admin-networkpolicies-1.0.7
[1.0.6]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.5...admin-networkpolicies-1.0.6
[1.0.5]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.4...admin-networkpolicies-1.0.5
[1.0.4]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.3...admin-networkpolicies-1.0.4
[1.0.3]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.2...admin-networkpolicies-1.0.3
[1.0.2]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.1...admin-networkpolicies-1.0.2
[1.0.1]: https://github.com/tjungbauer/helm-charts/compare/admin-networkpolicies-1.0.0...admin-networkpolicies-1.0.1
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/admin-networkpolicies-1.0.0/charts/adminnetworkpolicies
