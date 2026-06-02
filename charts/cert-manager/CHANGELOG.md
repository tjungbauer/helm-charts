# Changelog

All notable changes to the **cert-manager** Helm chart are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and chart releases follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html) via `Chart.yaml` `version`.

## How this file relates to other metadata

| Location | Purpose |
|----------|---------|
| **`CHANGELOG.md` (this file)** | Human-readable history for maintainers and chart consumers; grouped by version with Added / Changed / Fixed / Security / Removed. |
| **`Chart.yaml` `version`** | SemVer of the **chart package**; bump on every releaseable change. |
| **`Chart.yaml` `annotations.artifacthub.io/changes`** | Short bullets for [Artifact Hub](https://artifacthub.io/) on **each published version only**—keep in sync when you cut a release. |
| **`values.schema.json`** | JSON Schema for `values.yaml`; used by `helm lint` and editors with schema support. |

**Workflow**

1. Add user-visible bullets under **`[Unreleased]`** while developing.
2. On release: rename `[Unreleased]` → `[x.y.z] - YYYY-MM-DD`, bump `Chart.yaml` `version`, and copy the **same bullets** (shortened if needed) into `artifacthub.io/changes` for that version.
3. Update **`values.schema.json`** when you add, rename, or constrain values keys.
4. Do **not** duplicate typo-only or internal refactors here unless operators would care when upgrading.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [2.0.6] - 2026-06-02

### Fixed

- `values.schema.json` allows Helm-injected `global` values so `helm lint` / `helm template` succeed when this chart is used as a dependency (umbrella charts).

---

## [2.0.5] - 2026-06-01

### Changed

- `certManager.enable_patch`, `certManager.overrideArgs.enabled`, `issuer[].enabled`, ACME `skipTLSVerify`, and certificate enable guards use `tpl.isEnabled` (supports bool and string `"true"` / `"false"`).
- `tpl` dependency minimum version raised to `~1.0.31`.
- `CHANGELOG.md`, `values.schema.json`, and `.helmignore` for chart values validation, release notes, and packaging hygiene.

### Added

- Documented ACME `skipTLSVerify` in `values.yaml`.

### Fixed

- Certificate template directory renamed from `issueing-Certificate` to `issuing-Certificate`.

---

## [2.0.4] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.
- `tpl` dependency minimum version raised to `~1.0.27`.

---

## [2.0.3] - 2026-02-18

### Added

- Optional `namespace` on issuers when `type` is `Issuer` (ignored for `ClusterIssuer`).

---

## [2.0.2] - 2025-07-07

### Changed

- `tpl` dependency minimum version raised to `~1.0.22`.

---

## [2.0.1] - 2025-07-03

### Changed

- Chart version bump (release workflow validation).

---

## [2.0.0] - 2025-05-27

### Added

- `certManager.unsupportedConfigOverrides` for OpenShift Cert Manager operator overrides.
- Configurable `certManager.logLevel` and `certManager.operatorLogLevel`.

### Changed

- `certManager.overrideArgs` is now an object with `enabled` and `args` (override args apply only when enabled).

---

## [1.0.6] - 2025-02-03

### Added

- ACME issuer values for `privKeyRef`, `server`, `skipTLSVerify`, and `preferredChain` in templates and examples.

---

## [1.0.5] - 2024-07-01

### Fixed

- Certificate `duration` and `renewBefore` defaults use full Go duration form (`2160h0m0s`, `360h0m0s`).

---

## [1.0.4] - 2024-07-01

### Fixed

- Quote `dnsNames` entries in the Certificate template.

---

## [1.0.3] - 2024-07-01

### Added

- `Certificate` resources via `certificates` values (order certificates from the chart).

---

## [1.0.2] - 2024-06-25

### Added

- Dependency on shared **`tpl`** library chart.

### Changed

- Standard labels use `tpl.labels` instead of local `_helpers.tpl`.

---

## [1.0.1] - 2024-06-14

### Changed

- Chart version republish (no functional chart changes vs 1.0.0).

---

## [1.0.0] - 2024-06-14

### Added

- Initial chart: OpenShift `CertManager` operator patch, `ClusterIssuer` / `Issuer` resources (ACME, self-signed, CA, Vault, Venafi).
- Argo CD sync-wave annotations on rendered resources.

---

[2.0.6]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-2.0.5...cert-manager-2.0.6
[2.0.5]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-2.0.4...cert-manager-2.0.5
[2.0.4]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-2.0.3...cert-manager-2.0.4
[2.0.3]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-2.0.2...cert-manager-2.0.3
[2.0.2]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-2.0.1...cert-manager-2.0.2
[2.0.1]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-2.0.0...cert-manager-2.0.1
[2.0.0]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-1.0.6...cert-manager-2.0.0
[1.0.6]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-1.0.5...cert-manager-1.0.6
[1.0.5]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-1.0.4...cert-manager-1.0.5
[1.0.4]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-1.0.3...cert-manager-1.0.4
[1.0.3]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-1.0.2...cert-manager-1.0.3
[1.0.2]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-1.0.1...cert-manager-1.0.2
[1.0.1]: https://github.com/tjungbauer/helm-charts/compare/cert-manager-1.0.0...cert-manager-1.0.1
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/cert-manager-1.0.0/charts/cert-manager
