[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install & configure Red Hat Advanced Cluster Management

Install and configure the RHACM. This uses two Subchart as dependencies:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): to create the required Operator resources
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): to verify if the Deployments of this Operator are running. 

Once the Operator installation is done a MultiClusterHub object is created.

The full process is: 

1. Create Namespace
2. Create Operatorgroup and Subscription (This installs the Operator)
3. Create ServiceAccount, Role, RoleBinding and Job (This verifies of the Operator is up and running)
4. Create a MultiCluterHub object (This configures RHACM)

**Note** The Observability Module must be deployed as Day-2 operation and is currently not part of this Charts since it has additional dependencies like S3 Storage and increased requirements of CPU and Memory.

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
helm install my-release tjungbauer/rhacm-full-stack
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
| `rhacm.namespace.name` | Namespace where the resource shall be created | `open-cluster-management` |
| `rhacm.multiclusterhub.enabled` | Enable MultiClusterHub | `false` |
| `rhacm.multiclusterhub.syncwave` | Argo CD Syncwave | `3` |
| `rhacm.multiclusterhub.availabilityConfig` | Shall RHACM be installed in single (Basic) mode or high available (High) | `basic` |

## Example

```yaml
---
override-rhacm-operator-version: &rhacmversion release-2.6

# Install Operator RHACM
# Deploys Operator --> Subscription and Operatorgroup
# Syncwave: 0
helper-operator:
  operators:
    advanced-cluster-management:
      enabled: true
      syncwave: '0'
      namespace:
        name: open-cluster-management
        create: true
      subscription:
        channel: *rhacmversion
        approval: Automatic
        operatorName: advanced-cluster-management
        source: redhat-operators
        sourceNamespace: openshift-marketplace
      operatorgroup:
        create: true
        notownnamespace: false

helper-status-checker:
  enabled: true

  # space separate list of deployments which shall be checked for status
  deployments: "multicluster-operators-application multicluster-observability-operator multicluster-operators-channel multicluster-operators-hub-subscription multicluster-operators-standalone-subscription multicluster-operators-subscription-report multiclusterhub-operator submariner-addon"

  wait_time: 60  # wait time in seconds for the check-job to verify when the deployments should be ready

  namespace:
    name: open-cluster-management

  serviceAccount:
    create: true
    name: "status-checker"

rhacm:
  namespace:
    name: open-cluster-management
  multiclusterhub:
    enabled: true
    syncwave: '3'
    #availabilityConfig: High # Might be High or Basic
```
