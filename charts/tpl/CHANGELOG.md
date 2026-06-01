# Changelog

All notable changes to the **tpl** Helm library chart are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and chart releases follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html) via `Chart.yaml` `version`.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.31] - 2026-01-06

### Added

- tpl.topologySpreadConstraints, tpl.imagePullSecrets, tpl.env, tpl.envFrom, tpl.openshiftRoute, and tpl.networkPolicy

### Changed

- tpl.jobPodSpec supports imagePullSecrets and topologySpreadConstraints
- tpl.namespace emits OpenShift description and display-name annotations only when set
- tpl.resources documents appendUnit Gi/Mi behavior; values examples use explicit units; limits.nvidia removed in favor of extendedResources map
- tpl.nodeSelector accepts legacy key/value or a multi-label map; tpl.jobPodSpec reuses tpl.nodeSelector

## [1.0.30] - 2026-05-31

### Added

- `tpl.isEnabled` — normalize bool and string `"true"` / `"True"` enable flags.
- `tpl.argocdMetadata` — Argo CD sync-wave, sync-options, hook, and compare annotations.
- `tpl.jobHookMetadata` — convenience wrapper for hook Job annotations.
- `tpl.jobPodSpec` — shared pod spec tail for batch hook Jobs.
- `tpl.affinity` — pod affinity pass-through helper.

### Changed

- `tpl.securityContext` no longer emits `fsGroup` on container `securityContext` (pod-level only via `tpl.podSecurityContext`).
- `tpl.argocdApplication` YAML comment lines converted to Helm comments (no `# ...` noise in rendered manifests).

### Fixed

- `tpl.argocdApplication` renders `$spec.finalizers` instead of the root context in `finalizers`.
- `tpl.podDisruptionBudget` validates `name`, `minAvailable` or `maxUnavailable`, and selector; supports `minAvailable: 0`.

---

## [1.0.29] - 2026-05-31

### Added

- `tpl.ttlSecondsAfterFinished` — configurable Job cleanup after completion (default 600s).

---

## [1.0.28] - 2026-04-15

### Fixed

- `tpl.tolerations` omits `value` when `operator` is `Exists` or when value is empty.

---

## [1.0.27] - 2026-03-29

### Fixed

- Set `Chart.yaml` `type: library` so Helm and Artifact Hub treat **tpl** as a library chart (not installable standalone).

---

## Historical releases (1.0.0–1.0.26)

Early patch releases introduced the shared partials used across the helm-charts monorepo. Highlights by area (exact patch versions not listed per entry):

### Added

- `tpl.labels`, `tpl.name`, `tpl.fullname`, `tpl.chart`, `tpl.selectorLabels` — standard Helm/Kubernetes labels.
- `tpl.tolerations`, `tpl.nodeSelector`, `tpl.resources` (with unit helpers).
- `tpl.serviceAccountName`, `tpl.serviceAccount`.
- `tpl.sleeptimer` — bash wait loop for Job scripts.
- `tpl.bindtoNode`, `tpl.namespaceDescr`, `tpl.namespaceDisplay` — OpenShift namespace annotations.
- `tpl.matchLabels`, `tpl.matchExpressions` — selector blocks for network policies and similar CRs.
- `tpl.additionalAnnotations`, `tpl.additionalLabels` — free-form metadata on any resource.
- `tpl.securityContext`, `tpl.podSecurityContext`.
- `tpl.podDisruptionBudget`.
- `tpl.argocdApplication` — Argo CD `Application` CR template.
- `tpl.namespace` — Namespace manifest helper.

### Fixed

- Newline handling in `tpl.sleeptimer` (multiple patch releases).
- Toleration stanza ordering adjusted for OpenShift monitoring ConfigMap drift.
- `matchLabels` in nodeSelector configuration no longer incorrectly required in all cases.

---

[1.0.31]: https://github.com/tjungbauer/helm-charts/compare/tpl-1.0.30...tpl-1.0.31
[1.0.30]: https://github.com/tjungbauer/helm-charts/compare/tpl-1.0.29...tpl-1.0.30
[1.0.29]: https://github.com/tjungbauer/helm-charts/compare/tpl-1.0.28...tpl-1.0.29
[1.0.28]: https://github.com/tjungbauer/helm-charts/compare/tpl-1.0.27...tpl-1.0.28
[1.0.27]: https://github.com/tjungbauer/helm-charts/tree/tpl-1.0.27/charts/tpl
