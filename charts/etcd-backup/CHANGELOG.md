# Changelog

All notable changes to the **etcd-backup** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.14] - 2026-06-10

### Changed

- POD_ManualBackupCheck.yaml pins ose-cli to v4.15, imagePullPolicy, and automountServiceAccountToken false

---

## [1.0.13] - 2026-06-07

### Added

- CHANGELOG.md for release notes

### Changed

- enabled, namespace, pv, pvc, and key-pruner guards use tpl.isEnabled

### Fixed

- POD_ManualBackupCheck.yaml defines CPU, memory, and ephemeral-storage requests

---

## [1.0.12] - 2026-03-30

### Changed

- Document why privileged SCC and control-plane access are required for etcd backup.

---

## [1.0.11] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.0] - 2023-09-25

### Added

- Initial chart: etcd backup CronJob with PVC storage.
- Key-pruner CronJob for old encryption-config secrets in `openshift-kube-apiserver`.
- **`tpl`** subchart dependency.

---

[1.0.14]: https://github.com/tjungbauer/helm-charts/compare/etcd-backup-1.0.13...etcd-backup-1.0.14
[1.0.13]: https://github.com/tjungbauer/helm-charts/compare/etcd-backup-1.0.12...etcd-backup-1.0.13
[1.0.12]: https://github.com/tjungbauer/helm-charts/compare/etcd-backup-1.0.11...etcd-backup-1.0.12
[1.0.11]: https://github.com/tjungbauer/helm-charts/compare/etcd-backup-1.0.0...etcd-backup-1.0.11
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/etcd-backup-1.0.0/charts/etcd-backup
