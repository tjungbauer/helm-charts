# Changelog

All notable changes to the **sonarqube** Helm chart are documented in this file.

---

## [1.0.31] - 2026-06-11

### Changed

- enabled guards use tpl.isEnabled; bump tpl to ~1.0.31; CHANGELOG.md

---

## [1.0.30] - 2026-06-11

### Changed

- `set_admin_password` defaults to `false`; configurable `ttlSecondsAfterFinished` on admin-password Job via `tpl.ttlSecondsAfterFinished`

---

## [1.0.29] - 2026-03-30

### Changed

- Add Chart.lock for reproducible installs, refresh resolved dependencies, maintainer email

---

## Earlier releases

See `Chart.yaml` `artifacthub.io/changes` for history before CHANGELOG.md was introduced.

[1.0.31]: https://github.com/tjungbauer/helm-charts/compare/sonarqube-1.0.30...sonarqube-1.0.31
[1.0.30]: https://github.com/tjungbauer/helm-charts/compare/sonarqube-1.0.29...sonarqube-1.0.30
[1.0.29]: https://github.com/tjungbauer/helm-charts/tree/sonarqube-1.0.29/charts/sonarqube
