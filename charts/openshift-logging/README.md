[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install Operator OpenShift Logging

This simply installs OpenShift Logging Operator and validates the status of the installation. 
It uses the Subchart: 

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): to create the required Operator resources
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): to verify if the Deployments of this Operator are running. 

It is best used with a GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-cluster-bootstrap

## TL;DR 

```console
helm repo add --force-update tjungbauer https://charts.stderr.at
helm repo update
```

## Prerequisites

* Kubernetes 1.12+
* Helm 3

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release tjungbauer/openshift-logging
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
The following table lists the configurable parameters of the chart and their default values. Only variables of this specific Helm Chart are listed. For the values of the Subchart read the appropriate README of the Subcharts.

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `elasticsearch` | Enable Elasticsearch Operator | `` |
| `lokistack` | Enable (new) Lokistack | `` |
| `vector` | Enable Vector with Logistack | `` |
| `loggingConfig.enabled` | Configure Cluster Logging | `` |
| `loggingConfig.syncwave` | Syncwave when ClusterLogging shall be created | `` |
| `loggingConfig.es.nodes` | *Only ES* number of ES nodes | `` |
| `loggingConfig.es.storageclass` | *Only ES* storage class for ES | `` |
| `loggingConfig.es.storagesize` | *Only ES* size of ES storage | `` |
| `loggingConfig.es.limits.mem` | *Only ES* Set memory limit. Good for Labs. | `` |
| `loggingConfig.es.requests.mem` | *Only ES* Set memory requests. Good for Labs. | `` |
| `loggingConfig.es.redundancyPolicy` | *Only ES* ES Redundancy Policy. i.e. ZeroRedundancy | `` |
| `loggingConfig.retentionPolicy.application` | Retention Policy for applications | `1d` |
| `loggingConfig.retentionPolicy.infra` | Retention Policy for infra logs | `1d` |
| `loggingConfig.retentionPolicy.audit` | Retention Policy for audit logs | `1d` |

## Example

```yaml
elasticsearch: &es false
lokistack: &loki false
# Vector is not enabled by default. Enable it with this parameter.
vector: true

loggingConfig:
  enabled: true
  syncwave: '3'
```