# Changelog

All notable changes to the **quay-registry-setup** Helm chart are documented in this file.

---

## [1.0.22] - 2026-06-16

- Fixed oidc_auth_secret wrong usage of value

## [2.0.21] - 2026-06-08

### Changed

- tpl.isEnabled guards; additionalLabels and additionalAnnotations via tpl.argocdMetadata; bump tpl to ~1.0.31; CHANGELOG.md

---

## [2.0.20] - 2026-06-08

### Changed

- Refresh tpl dependency to 1.0.29 (Chart.lock and vendored subchart)

---

## Earlier releases

See `Chart.yaml` `artifacthub.io/changes` for history before CHANGELOG.md was introduced.

[2.0.21]: https://github.com/tjungbauer/helm-charts/compare/quay-registry-setup-2.0.20...quay-registry-setup-2.0.21
[2.0.20]: https://github.com/tjungbauer/helm-charts/tree/quay-registry-setup-2.0.20/charts/quay-registry-setup

---

## [2.0.22] - 2026-06-16

### Fixed

- Fixed oidc_auth_secret wrong usage of value

---

[1.0.22]: https://github.com/tjungbauer/helm-charts/compare/quay-registry-setup-2.0.21...quay-registry-setup-1.0.22
[2.0.21]: https://github.com/tjungbauer/helm-charts/compare/quay-registry-setup-2.0.20...quay-registry-setup-2.0.21
[2.0.20]: https://github.com/tjungbauer/helm-charts/compare/quay-registry-setup-2.0.22...quay-registry-setup-2.0.20
[2.0.22]: https://github.com/tjungbauer/helm-charts/tree/quay-registry-setup-2.0.22/charts/quay-registry-setup
