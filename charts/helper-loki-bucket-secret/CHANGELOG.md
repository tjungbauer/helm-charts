# Changelog

All notable changes to the **helper-loki-bucket-secret** Helm chart are documented in this file.

---

## [1.0.15] - 2026-06-11

### Added

- chart-root additionalLabels and additionalAnnotations on hook Job, ServiceAccount, and ClusterRoleBinding; CHANGELOG.md

---

## [1.0.14] - 2026-06-11

### Changed

- Refresh tpl dependency to 1.0.29 (Chart.lock and vendored subchart)

---

## [1.0.13] - 2026-06-11

### Added

- Configurable ttlSecondsAfterFinished on bucket-secret Job (default 600s)

---

## [1.0.12] - 2026-06-11

### Changed

- Add Chart.lock for reproducible installs, refresh resolved dependencies, maintainer email

---

## Earlier releases

See `Chart.yaml` `artifacthub.io/changes` for history before CHANGELOG.md was introduced.

[1.0.15]: https://github.com/tjungbauer/helm-charts/compare/helper-loki-bucket-secret-1.0.14...helper-loki-bucket-secret-1.0.15
[1.0.14]: https://github.com/tjungbauer/helm-charts/compare/helper-loki-bucket-secret-1.0.13...helper-loki-bucket-secret-1.0.14
[1.0.13]: https://github.com/tjungbauer/helm-charts/compare/helper-loki-bucket-secret-1.0.12...helper-loki-bucket-secret-1.0.13
[1.0.12]: https://github.com/tjungbauer/helm-charts/tree/helper-loki-bucket-secret-1.0.12/charts/helper-loki-bucket-secret
