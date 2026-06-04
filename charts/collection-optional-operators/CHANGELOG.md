# Changelog

All notable changes to the **collection-optional-operators** Helm chart are documented in this file.

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

### Changed

- `helper-operator` dependency minimum version raised to `~1.0.41`; refreshed `Chart.lock`.
- `CHANGELOG.md` and `.helmignore` for release notes and packaging hygiene.

---

## [1.0.36] - 2026-05-31

### Changed

- `helper-operator` dependency version alignment and refreshed lockfile.

---

## [1.0.35] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.1] – [1.0.34] - 2022-07-25 – 2026-03-29

### Changed

- Repeated **`helper-operator`** dependency bumps to track operator install chart releases.
- Default optional operators (CodeReady Workspaces, resource-locker, NetObserv, and related) updated over time.

### Fixed

- Chart signing and README documentation.

---

## [1.0.0] - 2022-07-24

### Added

- Initial chart: optional OpenShift operators (for example CodeReady Workspaces) via **`helper-operator`** values only—no CRD configuration in this chart.

### Changed

- Refactored from inline Subscription/OperatorGroup templates to **`helper-operator`** subchart (2022-07-25).

---

[1.0.38]: https://github.com/tjungbauer/helm-charts/compare/collection-optional-operators-1.0.37...collection-optional-operators-1.0.38
[1.0.37]: https://github.com/tjungbauer/helm-charts/compare/collection-optional-operators-1.0.36...collection-optional-operators-1.0.37
[1.0.36]: https://github.com/tjungbauer/helm-charts/compare/collection-optional-operators-1.0.35...collection-optional-operators-1.0.36
[1.0.35]: https://github.com/tjungbauer/helm-charts/compare/collection-optional-operators-1.0.34...collection-optional-operators-1.0.35
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/collection-optional-operators-1.0.0/charts/collection-optional-operators
