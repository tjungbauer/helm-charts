# Changelog

All notable changes to the **ingresscontroller** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.19] - 2026-06-10

### Added

- CHANGELOG.md and .helmignore

### Changed

- tpl.argocdMetadata on IngressController CR with syncwave, additionalAnnotations, and additionalLabels

---

## [1.0.18] - 2026-03-30

### Changed

- Add Chart.lock for reproducible installs, refresh resolved dependencies, maintainer email

---

## Earlier releases

Feature history before CHANGELOG.md (from git history and chart releases):

| Version era | Notable changes |
|-------------|-----------------|
| Early 1.0.x | Initial IngressController Helm chart |
| | README and chart documentation |
| | **tpl** subchart dependency for labels, tolerations, and helpers |
| | `defaultCertificate` for custom ingress TLS secrets |
| | `annotations` on IngressController (for example HTTP/2 via `ingress.operator.openshift.io/default-enable-http2`) |
| | `domain`, `endpointPublishingStrategy`, `namespaceSelector`, `tlsSecurityProfile` |
| | `routeAdmission` (namespace ownership, wildcard policy) |

See `Chart.yaml` `artifacthub.io/changes` for Artifact Hub release notes (some early entries may predate per-version tagging).

[1.0.19]: https://github.com/tjungbauer/helm-charts/compare/ingresscontroller-1.0.18...ingresscontroller-1.0.19
[1.0.18]: https://github.com/tjungbauer/helm-charts/tree/ingresscontroller-1.0.18/charts/ingresscontroller
