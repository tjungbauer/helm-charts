# Changelog

All notable changes to the **network-observability** Helm chart are documented in this file.

---

## [2.0.6] - 2026-06-11

### Changed

- tpl.isEnabled guards, tpl.argocdMetadata and additionalLabels/additionalAnnotations on FlowCollector, Namespace, and RBAC; bump tpl to ~1.0.31; CHANGELOG.md

---

## [2.0.5] - 2026-06-11

### Fixed

- Indentation in FlowCollector template nodeSelector section (PR #83)

---

## [2.0.4] - 2026-03-30

### Changed

- Add Chart.lock for reproducible installs, refresh resolved dependencies, maintainer email

---

## Earlier releases

See `Chart.yaml` `artifacthub.io/changes` for history before CHANGELOG.md was introduced.

[2.0.6]: https://github.com/tjungbauer/helm-charts/compare/network-observability-2.0.5...network-observability-2.0.6
[2.0.5]: https://github.com/tjungbauer/helm-charts/compare/network-observability-2.0.4...network-observability-2.0.5
[2.0.4]: https://github.com/tjungbauer/helm-charts/tree/network-observability-2.0.4/charts/network-observability
