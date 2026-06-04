# Changelog

All notable changes to the **dev-spaces** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.5] - 2026-06-04

### Changed

- CHANGELOG cleanup

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

[1.0.5]: https://github.com/tjungbauer/helm-charts/compare/dev-spaces-1.0.3...dev-spaces-1.0.5
[1.0.3]: https://github.com/tjungbauer/helm-charts/compare/dev-spaces-1.0.2...dev-spaces-1.0.3
[1.0.2]: https://github.com/tjungbauer/helm-charts/compare/dev-spaces-1.0.1...dev-spaces-1.0.2
[1.0.1]: https://github.com/tjungbauer/helm-charts/compare/dev-spaces-1.0.0...dev-spaces-1.0.1
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/dev-spaces-1.0.0/charts/dev-spaces
