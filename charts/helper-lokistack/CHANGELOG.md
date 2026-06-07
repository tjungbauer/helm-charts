# Changelog

All notable changes to the **helper-lokistack** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.24] - 2026-06-07

### Changed

- LokiStack uses tpl.argocdMetadata for Argo CD annotations (sync-wave, sync-options) and tpl.additionalLabels for additional labels, added CHANGELOG.md

---

## [1.0.23] - 2026-06-07

### Fixed

- Indentation in `LokiStack` template and `podPlacements` section (PR #82, @spre4dy).

---

## [1.0.22] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.1] – [1.0.21] - 2024-03-08 – 2026-03-29

### Added

- Dependency on shared **`tpl`** library chart; tolerations rendered via `tpl.tolerations`.
- Retention limits (global and per-tenant), admin groups, storage schemas, TLS CA configmap keys, `podPlacements` (nodeSelector and tolerations per LokiStack component), and network policy `ruleSet` (`None` / `RestrictIngressEgress`).
- README and helm-docs values comments.

### Changed

- Storage size field refactored from `.size` to `.storage.size`.
- Default log schema version updated.

### Fixed

- README documentation fixes.

---

## [1.0.0] - 2024-03-08

### Added

- Initial chart: Helm template for the LokiStack custom resource (`loki.grafana.com/v1`) for use as a GitOps subchart.

---

[1.0.24]: https://github.com/tjungbauer/helm-charts/compare/helper-lokistack-1.0.23...helper-lokistack-1.0.24
[1.0.23]: https://github.com/tjungbauer/helm-charts/compare/helper-lokistack-1.0.22...helper-lokistack-1.0.23
[1.0.22]: https://github.com/tjungbauer/helm-charts/compare/helper-lokistack-1.0.21...helper-lokistack-1.0.22
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/helper-lokistack-1.0.0/charts/helper-lokistack
