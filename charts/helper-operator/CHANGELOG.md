# Changelog

All notable changes to the **helper-operator** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.45] - 2026-06-04

### Changed

- CHANGELOG cleanup

---

## [1.0.44] - 2026-06-02

### Changed

- Operator, namespace, operatorgroup, console-plugin, and `config.trustedCA.enabled` guards use `tpl.isEnabled` (supports bool and string `"true"` / `"false"`).
- `tpl` dependency minimum version raised to `~1.0.31`; refreshed `Chart.lock`.

### Added

- `CHANGELOG.md` and `.helmignore` (excludes `README.md.gotmpl` from packaged chart).

---

## [1.0.43] - 2026-05-31

### Changed

- Refreshed `tpl` dependency to `~1.0.29`; updated `Chart.lock` and vendored subchart.

---

## [1.0.42] - 2026-05-30

### Added

- Configurable `ttlSecondsAfterFinished` on console-plugin Job (default 600s).

---

## [1.0.41] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

### Added

- Configurable custom OperatorGroup name via `operatorgroup.name`.

---

## [1.0.1] – [1.0.40] - 2023-09-25 – 2026-03-29

### Added

- Console-plugin enablement Job with RBAC (ServiceAccount, ClusterRole, ClusterRoleBinding).
- Subscription `config` block: tolerations, nodeSelector, env, resources, trusted CA bundle.
- **`tpl`** subchart dependency and shared label/annotation helpers.
- Option to disable common labels on Namespace (`namespace.disable_common_labels`).

### Changed

- Repeated chart version bumps and README/helm-docs updates across the 1.0.x line.

### Fixed

- Console-plugin Job idempotency (check existing plugins before patch).
- Namespace template `disable_common_labels` value reference.

---

## [1.0.0] - 2023-09-25

### Added

- Initial helper subchart: Namespace, Subscription, and OperatorGroup templates driven by `operators` values map.

---

[1.0.45]: https://github.com/tjungbauer/helm-charts/compare/helper-operator-1.0.44...helper-operator-1.0.45
[1.0.44]: https://github.com/tjungbauer/helm-charts/compare/helper-operator-1.0.43...helper-operator-1.0.44
[1.0.43]: https://github.com/tjungbauer/helm-charts/compare/helper-operator-1.0.41...helper-operator-1.0.43
[1.0.42]: https://github.com/tjungbauer/helm-charts/compare/helper-operator-1.0.41...helper-operator-1.0.42
[1.0.41]: https://github.com/tjungbauer/helm-charts/compare/helper-operator-1.0.40...helper-operator-1.0.41
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/helper-operator-1.0.0/charts/helper-operator
