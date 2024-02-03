[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Collection of Operators

This chart can be used to install Operators in OpenShift. Such charts were initially grouped into the purpose of the Operator ... here some default Operators that are used for a typical environment. 
However, you can install any Operator with this chart. 

It is best used with a GitOps approach such as Argo CD does. For example: https://github.com/tjungbauer/openshift-clusterconfig-gitops

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
helm install my-release tjungbauer/collection-operators
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Dependencies 

The chart is used as a wrapper and therefore depends on the Subchart `helper-operator`, that does the actual deployment: https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator

## Parameters
The following table lists the configurable parameters of the chart and their default values. They are bypassed to the Subchart `helper-operator`:

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `helper-operator.override-rhacm-operator-version` | Sets the release version (channel) for RH ACM | `release-2.5` |
| `helper-operator.namespaces` | A list of specific namespaces that should be created | `single-sign-on` and `helper-operator.openshift-cert-manager-operator` |
| `helper-operator.UNIQUE-IDENTIFIER`| This is a unique identifier that will be used to create the Argo CD Application | `` |
| `helper-operator.UNIQUE-IDENTIFIER.enabled` | enabled yes/no | `false` |
| `helper-operator.UNIQUE-IDENTIFIER.syncwave` | Sets the Syncwave for Argo CD | 0 |
| `helper-operator.UNIQUE-IDENTIFIER.namespace` | The Namespace the Operator should be installed in | ` ` |
| `helper-operator.UNIQUE-IDENTIFIER.namespace.create` | Create the namespace true/false | `false` |
| `helper-operator.UNIQUE-IDENTIFIER.subscription` | Definition of the Operator Subscription | `` |
| `helper-operator.UNIQUE-IDENTIFIER.subscription.channel` | Subscription channel | `stable` |
| `helper-operator.UNIQUE-IDENTIFIER.subscription.approval` | Operator Subscription update behavior  | `Automatic` |
| `helper-operator.UNIQUE-IDENTIFIER.subscription.operatorName` | Operator name | `` |
| `helper-operator.UNIQUE-IDENTIFIER.subscription.source` | Operator source | `redhat-operators `|
| `helper-operator.UNIQUE-IDENTIFIER.subscription.sourceNamespace` | Operator Sourcenamespace  | `openshift-marketplace` |
| `helper-operator.UNIQUE-IDENTIFIER.operatorgroup.create` |  Create an Operatorgroup object  | `false` |
| `helper-operator.UNIQUE-IDENTIFIER.operatorgroup.notownnamespace` | Monitor own Namespace. For some Operators no `targetNamespaces` must be defined | `false` |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

## Example

Installing the Operator "Open Cluster Management" (that is Red Hat Advanced Cluster Management)

TIP: Get the values for the subscription specification via `oc get packagemanifest advanced-cluster-management -o yaml`

```yaml
---
helper-operator:
  override-rhacm-operator-version: &rhacmversion release-2.5


  operators:
    rhacm-operator:
      enabled: true
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
```
