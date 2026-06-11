# Changelog

All notable changes to the **helper-odf-bucket-secret** Helm chart are documented in this file.

---

## [1.0.6] - 2026-06-11

### Added

- chart-root additionalLabels and additionalAnnotations on hook Job, ServiceAccount, and ClusterRoleBinding; CHANGELOG.md

---

## [1.0.5] - 2026-06-11

### Changed

- Refresh tpl dependency to 1.0.29 (Chart.lock and vendored subchart)

---

## [1.0.4] - 2026-06-11

### Added

- Configurable ttlSecondsAfterFinished on bucket-secret Job (default 600s)

---

## [1.0.3] - 2026-06-11

### Changed

- Add Chart.lock for reproducible installs, refresh resolved dependencies, maintainer email

---

## Earlier releases

See `Chart.yaml` `artifacthub.io/changes` for history before CHANGELOG.md was introduced.

[1.0.6]: https://github.com/tjungbauer/helm-charts/compare/helper-odf-bucket-secret-1.0.5...helper-odf-bucket-secret-1.0.6
[1.0.5]: https://github.com/tjungbauer/helm-charts/compare/helper-odf-bucket-secret-1.0.4...helper-odf-bucket-secret-1.0.5
[1.0.4]: https://github.com/tjungbauer/helm-charts/compare/helper-odf-bucket-secret-1.0.3...helper-odf-bucket-secret-1.0.4
[1.0.3]: https://github.com/tjungbauer/helm-charts/tree/helper-odf-bucket-secret-1.0.3/charts/helper-odf-bucket-secret
