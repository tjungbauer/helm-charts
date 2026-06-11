# Changelog

All notable changes to the **rhacs-setup** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.48] - 2026-06-11

### Fixed

- fixing indentation issues (#83 chrissmanynames)

---

## [1.0.47] - 2026-06-07

### Added

- CHANGELOG.md

### Changed

- tpl.argocdMetadata and per-component additionalAnnotations and additionalLabels on namespace, Central, SecuredCluster, Jobs, and RBAC
- enabled guards use tpl.isEnabled; tpl dependency ~1.0.31

### Fixed

- rename declarative-config template (was declerative-config.yaml)

---

## [1.0.46] - 2026-06-04

### Changed

- Refreshed `tpl` dependency to `~1.0.29`; updated `Chart.lock` and vendored subchart.

---

## [1.0.45] - 2026-05-31

### Added

- Configurable `ttlSecondsAfterFinished` on setup Jobs (default 600s).

---

## [1.0.44] - 2026-05-13

### Fixed

- Guard `SecuredCluster` `spec.customize.deploymentDefaults` so missing or empty values do not nil-deref or emit empty blocks.

---

## [1.0.43] - 2026-05-10

### Added

- `SecuredCluster` `spec.customize.deploymentDefaults` for default placement on infra nodes (contribution: @mcapala).

---

## [1.0.1] – [1.0.42] - 2023-10-18 – 2026-03-29

### Added

- Dependency on shared **`tpl`** library chart; nodeSelector for RHACS components; Scanner and Scanner V4 configuration; declarative configuration ConfigMaps including OAuth providers; README and example values.

### Changed

- Updated to helper-status-checker v4 integration patterns where applicable.

### Fixed

- YAML syntax for declarative configurations; documented `centralEndpoint` setting.

---

## [1.0.0] - 2023-10-18

### Added

- Initial chart: deploy RHACS operator, Central, SecuredCluster, init-bundle and OAuth setup Jobs, and cluster configuration via API calls.

---

[1.0.48]: https://github.com/tjungbauer/helm-charts/compare/rhacs-setup-1.0.47...rhacs-setup-1.0.48
[1.0.47]: https://github.com/tjungbauer/helm-charts/compare/rhacs-setup-1.0.46...rhacs-setup-1.0.47
[1.0.46]: https://github.com/tjungbauer/helm-charts/compare/rhacs-setup-1.0.45...rhacs-setup-1.0.46
[1.0.45]: https://github.com/tjungbauer/helm-charts/compare/rhacs-setup-1.0.44...rhacs-setup-1.0.45
[1.0.44]: https://github.com/tjungbauer/helm-charts/compare/rhacs-setup-1.0.43...rhacs-setup-1.0.44
[1.0.43]: https://github.com/tjungbauer/helm-charts/compare/rhacs-setup-1.0.42...rhacs-setup-1.0.43
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/rhacs-setup-1.0.0/charts/rhacs-setup
