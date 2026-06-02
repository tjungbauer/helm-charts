# Changelog

All notable changes to the **collection-operators** Helm chart are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and chart releases follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html) via `Chart.yaml` `version`.

## How this file relates to other metadata

| Location | Purpose |
|----------|---------|
| **`CHANGELOG.md` (this file)** | Human-readable history for maintainers and chart consumers; grouped by version with Added / Changed / Fixed / Security / Removed. |
| **`Chart.yaml` `version`** | SemVer of the **chart package**; bump on every releaseable change. |
| **`Chart.yaml` `annotations.artifacthub.io/changes`** | Short bullets for [Artifact Hub](https://artifacthub.io/) on **each published version only**—keep in sync when you cut a release. |

**Workflow**

1. Add user-visible bullets under **`[Unreleased]`** while developing.
2. On release: rename `[Unreleased]` → `[x.y.z] - YYYY-MM-DD`, bump `Chart.yaml` `version`, and copy the **same bullets** (shortened if needed) into `artifacthub.io/changes` for that version.
3. Do **not** duplicate typo-only or internal refactors here unless operators would care when upgrading.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

## [1.0.45] - 2026-06-02

### Changed

- `helper-operator` dependency minimum version raised to `~1.0.41`; refreshed `Chart.lock`.
- `CHANGELOG.md` and `.helmignore` for release notes and packaging hygiene.

---

## [1.0.44] - 2026-05-31

### Changed

- `helper-operator` dependency version alignment and refreshed lockfile.

---

## [1.0.43] - 2026-03-30

### Changed

- Added `Chart.lock` for reproducible installs and refreshed resolved dependencies.
- Updated maintainer email in `Chart.yaml`.

---

## [1.0.1] – [1.0.42] - 2022-07-25 – 2026-03-29

### Changed

- Repeated **`helper-operator`** dependency bumps to track operator install chart releases.
- Default operator enablement and namespaces updated as demo/management charts split responsibilities.

### Fixed

- Chart signing and README documentation.

---

## [1.0.0] - 2022-07-24

### Added

- Initial chart: demo OpenShift operator collection (Pipelines, Elasticsearch, RHACS, and related operators) via **`helper-operator`** values only—no CRD configuration in this chart.

### Changed

- Refactored from inline Subscription/OperatorGroup templates to **`helper-operator`** subchart (2022-07-25).
- Disabled cluster-logging operator in defaults; logging install moved to dedicated charts (2022-08-11).

---

[1.0.45]: https://github.com/tjungbauer/helm-charts/compare/collection-operators-1.0.44...collection-operators-1.0.45
[1.0.44]: https://github.com/tjungbauer/helm-charts/compare/collection-operators-1.0.43...collection-operators-1.0.44
[1.0.43]: https://github.com/tjungbauer/helm-charts/compare/collection-operators-1.0.42...collection-operators-1.0.43
[1.0.0]: https://github.com/tjungbauer/helm-charts/tree/collection-operators-1.0.0/charts/collection-operators
