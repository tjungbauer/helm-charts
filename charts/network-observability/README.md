

# network-observability

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.12](https://img.shields.io/badge/Version-1.0.12-informational?style=flat-square)

 

  ## Description

  Installs and configures OpenShift Network Observability.

This Helm Chart is installing and configuring the Network Observability Operator.
This operator requires Loki to store the traffic information. The possible values are currently limited, but it is easy to extend if required.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | helper-loki-bucket-secret | ~1.0.0 |
| https://charts.stderr.at/ | helper-objectstore | ~1.0.0 |
| https://charts.stderr.at/ | helper-operator | ~1.0.0 |
| https://charts.stderr.at/ | tpl | ~1.0.0 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (for example in the folder clusters/management-cluster/setup-network-observability)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/network-observability

## Parameters

Verify the subcharts for additional settings:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)
* [helper-lokistack](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-lokistack)
* [helper-objectstore](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-objectstore)
* [helper-helper-loki-bucket-secret](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-helper-loki-bucket-secret)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bucketname | string | `"netobserv-bucket"` |  |
| helper-loki-bucket-secret.bucket.name | string | `"netobserv-bucket"` |  |
| helper-loki-bucket-secret.enabled | bool | `false` |  |
| helper-loki-bucket-secret.namespace | string | `"openshift-netobserv-operator"` |  |
| helper-loki-bucket-secret.secretname | string | `"netobserv-loki-s3"` |  |
| helper-loki-bucket-secret.syncwave | int | `2` |  |
| helper-objectstore.backingstore_name | string | `"netobserv-backingstore"` |  |
| helper-objectstore.backingstore_size | string | `"100Gi"` |  |
| helper-objectstore.baseStorageClass | string | `"gp3-csi"` |  |
| helper-objectstore.bucket.enabled | bool | `false` |  |
| helper-objectstore.bucket.name | string | `"netobserv-bucket"` |  |
| helper-objectstore.bucket.namespace | string | `"openshift-netobserv-operator"` |  |
| helper-objectstore.bucket.storageclass | string | `"netobserv-bucket-storage-class"` |  |
| helper-objectstore.bucket.syncwave | int | `2` |  |
| helper-objectstore.enabled | bool | `false` |  |
| helper-objectstore.storageclass_name | string | `"netobserv-bucket-storage-class"` |  |
| helper-operator.operators.netobserv-operator.enabled | bool | `false` |  |
| helper-operator.operators.netobserv-operator.namespace.create | bool | `false` |  |
| helper-operator.operators.netobserv-operator.namespace.name | string | `"openshift-netobserv-operator"` |  |
| helper-operator.operators.netobserv-operator.operatorgroup.create | bool | `false` |  |
| helper-operator.operators.netobserv-operator.operatorgroup.notownnamespace | bool | `true` |  |
| helper-operator.operators.netobserv-operator.subscription.approval | string | `"Automatic"` |  |
| helper-operator.operators.netobserv-operator.subscription.channel | string | `"stable"` |  |
| helper-operator.operators.netobserv-operator.subscription.operatorName | string | `"netobserv-operator"` |  |
| helper-operator.operators.netobserv-operator.subscription.source | string | `"redhat-operators"` |  |
| helper-operator.operators.netobserv-operator.subscription.sourceNamespace | string | `"openshift-marketplace"` |  |
| helper-operator.operators.netobserv-operator.syncwave | string | `"0"` |  |
| lokisecret | string | `"netobserv-loki-s3"` |  |
| namespace | string | `"openshift-netobserv-operator"` |  |
| netobserv.enabled | bool | false | Enable Network Observability configuration? This will also create the reader/writer rolebanding for multi-tenancy |
| netobserv.lokistack_name | string | netobserv-loki | Name of the LokiStack resource. |
| netobserv.namespace | object | '' | Namespace where Network Observability FlowCollector shall be installed. |
| netobserv.syncwave | int | 10 | Syncwave for the FlowCollector resource. |
| storageclassname | string | `"netobserv-bucket-storage-class"` |  |

## Example values

The following shows the values for the Network Pbservability operator itself. Since there are multiple sub-charts, verify the example values-file for a complete example.

```yaml
---
namespace: &namespace openshift-netobserv-operator

netobserv:
  enabled: true
  namespace:
    name: *namespace
  syncwave: 10
  lokistack_name: netobserv-loki
  ...
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
