[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Helper SubChart to verify Operator Status version 2.0

This chart is used the check the installation status of an Operator. Whenever a new Operator gets installed, this Chart can be called to verify if the status of the Operator is ready.
It is best used as a Subchart. For example, https://github.com/tjungbauer/helm-charts/tree/main/charts/rhacm-full-stack

It will create a Service Account (incl. a ClusterRole and a ClusterRoleBinding) and a Job that will try to check the status of the Operator. If the Operator is not available after some time, the Job will fail. 

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
helm install my-release tjungbauer/helper-status-checker
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
The following table lists the configurable parameters of the chart and their default values. In this example it is called as a Subchart

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `helper-status-checker.enabled` | Enable the Status Checker | `false` |
| `helper-status-checker.sleeptimer` | Wait time in seconds for the check-job to verify when the deployments should be ready | `20` |
| `helper-status-checker.maxretries` | Number of retries for each check | `20` |
| `helper-status-checker.namespace.name` | The Namespace where the Checker shall operate | `` |
| `helper-status-checker.serviceaccount.create` | Create a ServiceAccount | `false` |
| `helper-status-checker.serviceaccount.name` | Name of the ServiceAccount that shall be created | `` |
| `helper-status-checker.syncwave` | Argo CD Syncwave | `1` |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

## Example

Installing Red Hat Advanced Cluster Management and verifying if a list of Deployments is ready:

```yaml
---
helper-status-checker:
  enabled: true

  sleeptimer: 20  # wait time in seconds for the check-job to verify when the deployments should be ready
  maxretries: 20  # number of retries for each check

  operatorName: my-operator # use currentCSV from packagemanifest.spec.curretncsv but WITHOUT the version number

  namespace:
    name: open-cluster-management

  serviceAccount:
    create: true
    name: "status-checker"
```