

# helper-lokistack

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.3](https://img.shields.io/badge/Version-1.0.3-informational?style=flat-square)

 

  ## Description

  The only purpose of this helper chart is to provide a template for the LokiStack Custom Resource, so it must not be re-defined for multiple services.

This Helm Chart is configuring the LokiStack object. This is for example required for OpenShift Logging and Network Observability.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-lokistack

## Parameters

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| enabled | bool | false | Enable or disable LokiStack configuration |
| global_retention_days | int | `4` | This is for log streams only, not the retention of the object store. Data retention must be configured on the bucket. |
| mode | string | static | Mode defines the mode in which lokistack-gateway component will be configured. Can be either: static (default), dynamic, openshift-logging, openshift-network |
| name | string | `"logging-loki"` | Name of the LokiStack object |
| namespace | string | `"openshift-logging"` | Namespace of the LokiStack object |
| podPlacements | object | `{}` | Control pod placement for LokiStack components. You can define a list of tolerations for the following components: compactor, distributer, gateway, indexGateway, ingester, querier, queryFrontend, ruler |
| storage.schemas[0] | object | v12 | Version for writing and reading logs. Can be v11 or v12 |
| storage.schemas[0].effectiveDate | string | 2022-06-01 | EffectiveDate is the date in UTC that the schema will be applied on. To ensure readibility of logs, this date should be before the current date in UTC. |
| storage.secret.name | string | `"logging-loki-s3"` | Name of a secret in the namespace configured for object storage secrets. |
| storage.secret.type | string | s3 | Type of object storage that should be used |
| storage.size | string | 1x.extra-small | Size defines one of the supported Loki deployment scale out sizes. Can be either:   - 1x.extra-small (Default)   - 1x.small   - 1x.medium |
| storageclassname | string | gp3-csi | Storage class name defines the storage class for ingester/querier PVCs. |
| syncwave | int | 3 | Syncwave for the LokiStack object. |

## Example values

```yaml
---
enabled: true

name: logging-loki
namespace: openshift-logging
syncwave: 3

# This is for log streams only, not the retention of the object store
global_retention_days: 4

# storage settings
storage:

  # Size defines one of the support Loki deployment scale out sizes.
  # Can be either:
  #   - 1x.extra-small (Default)
  #   - 1x.small
  #   - 1x.medium
  # size: 1x.extra-small

  # Secret for object storage authentication. Name of a secret in the same namespace as the LokiStack custom resource.
  secret:

    # Name of a secret in the namespace configured for object storage secrets.
    name: logging-loki-s3

    # Type of object storage that should be used
    # Can bei either:
    #  - swift
    #  - azure
    #  - s3 (default)
    #  - alibabacloud
    #  - gcs
    # type: s3

  # Schemas for reading and writing logs.
  # schemas:
  #  # Version for writing and reading logs.
  #  # Can be v11 or v12
  #  #
  #  # Default: v12
  #  - version: v12
  #    # EffectiveDate is the date in UTC that the schema will be applied on. To ensure readibility of logs, this date should be before the current date in UTC.
  #    # Default: 2022-06-01
  #    effectiveDate: "2022-06-01"

# Storage class name defines the storage class for ingester/querier PVCs.
storageclassname: thin-csi

# Mode defines the mode in which lokistack-gateway component will be configured.
# Can be either:
#   - static (default)
#   - dynamic
#   - openshift-logging
#   - openshift-network
mode: openshift-logging

# Control pod placement for LokiStack components
podPlacements:
  compactor:
    tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
      - effect: NoExecute
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
  distributor:
    tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
      - effect: NoExecute
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
  gateway:
    tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
      - effect: NoExecute
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
  indexGateway:
    tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
      - effect: NoExecute
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
  ingester:
    tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
      - effect: NoExecute
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
  querier:
    tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
      - effect: NoExecute
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
  queryFrontend:
    tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
      - effect: NoExecute
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
  ruler:
    tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
      - effect: NoExecute
        key: node-role.kubernetes.io/infra
        operator: Equal
        value: reserved
```

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release tjungbauer/<chart-name>>
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
