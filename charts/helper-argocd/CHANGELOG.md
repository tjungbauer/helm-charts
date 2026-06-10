# Changelog

All notable changes to the **helper-argocd** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [2.0.47] - 2026-06-08

### Added

- tpl.argocdMetadata and per-resource additionalAnnotations and additionalLabels on AppProject, Application, and ApplicationSet

### Changed

- enabled guards use tpl.isEnabled; tpl dependency ~1.0.31; CHANGELOG and .helmignore

---

## [2.0.46] - 2026-06-07

### Changed

- RHACS demo ApplicationSet example points at the external RHACS-Demo-Application repository

---

## [2.0.45] - 2026-05-06

### Fixed

- ApplicationSet `ignoreDifferences` supports an optional `group` field

---

## [2.0.44] - 2026-03-30

### Changed

- Add Chart.lock for reproducible installs and refresh resolved dependencies
- Maintainer email updated in Chart.yaml
- README regenerated via helm-docs pipeline

---

## [2.0.41] - 2025-04-17

### Fixed

- Git generator ApplicationSets use the configured default namespace correctly

---

## [2.0.40] - 2025-04-17

### Added

- Merge generator support for ApplicationSets
- Additional examples for per-namespace configuration in ApplicationSets

---

## [2.0.38] - 2025-01-21

### Fixed

- `argocd_project` can be set correctly on ApplicationSet templates

---

## [2.0.36] - 2024-07-11

### Added

- Multiple sources on Application resources (not only ApplicationSets)

---

## [2.0.35] - 2024-07-11

### Fixed

- AppProject resources accept a configurable namespace (not only `openshift-gitops`)

---

## [2.0.34] - 2024-06-29

### Added

- Dependency on shared `tpl` library chart for standard labels and helpers

---

## [2.0.33] - 2024-04-30

### Added

- Configurable sync retries (limit and backoff) on ApplicationSet sync policies

---

## [2.0.29] - 2024-04-10

### Added

- README examples and documentation improvements

---

## [2.0.21] - 2023-11-10

### Changed

- Application and ApplicationSet syncPolicy templating refactored

---

## [2.0.15] - 2023-11-08

### Added

- Per-Application Argo CD sync-wave annotation

---

## [2.0.14] - 2023-10-31

### Added

- ApplicationSet `ignoreDifferences` support
- Opinionated matrix generator (list + git file generator with `targetCluster`)

---

## [2.0.8] - 2023-09-26

### Added

- ApplicationSet goTemplate option
- Git file generator for ApplicationSets

---

## [2.0.0] - 2023-09-23

### Added

- Release 2.0: multiple sources on ApplicationSets and per-cluster chart version (`chart_version`) for release management across clusters

---

## [1.0.9] - 2023-03-15

### Added

- `omitClustername` option for ApplicationSet naming

---

## [1.0.8] - 2023-01-11

### Added

- `preserveResourcesOnDeletion` on ApplicationSets

---

## [1.0.7] - 2022-12-21

### Added

- Expanded Application resource options

---

## [1.0.4] - 2022-11-04

### Added

- Configurable destination namespace on ApplicationSets

---

## [1.0.1] - 2022-11-04

### Added

- ApplicationSet syncOptions and Helm value file support

---

## [1.0.0] - 2022-08-11

### Added

- Initial chart: Argo CD Applications, ApplicationSets, and AppProjects

---

[2.0.47]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.46...helper-argocd-2.0.47
[2.0.46]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.45...helper-argocd-2.0.46
[2.0.45]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.44...helper-argocd-2.0.45
[2.0.44]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.43...helper-argocd-2.0.44
[2.0.41]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.40...helper-argocd-2.0.41
[2.0.40]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.39...helper-argocd-2.0.40
[2.0.38]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.37...helper-argocd-2.0.38
[2.0.36]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.35...helper-argocd-2.0.36
[2.0.35]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.34...helper-argocd-2.0.35
[2.0.34]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.33...helper-argocd-2.0.34
[2.0.33]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.32...helper-argocd-2.0.33
[2.0.29]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.28...helper-argocd-2.0.29
[2.0.21]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.20...helper-argocd-2.0.21
[2.0.15]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.14...helper-argocd-2.0.15
[2.0.14]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.13...helper-argocd-2.0.14
[2.0.8]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-2.0.7...helper-argocd-2.0.8
[2.0.0]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-1.0.11...helper-argocd-2.0.0
[1.0.9]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-1.0.8...helper-argocd-1.0.9
[1.0.8]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-1.0.7...helper-argocd-1.0.8
[1.0.7]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-1.0.6...helper-argocd-1.0.7
[1.0.4]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-1.0.3...helper-argocd-1.0.4
[1.0.1]: https://github.com/tjungbauer/helm-charts/compare/helper-argocd-1.0.0...helper-argocd-1.0.1
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/helper-argocd-1.0.0/charts/helper-argocd
