[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Helper Chart to install Operators

This chart can be used to install Operators in OpenShift. 
It is best used with a GitOps approach such as Argo CD does. For example: https://github.com/tjungbauer/openshift-cluster-bootstrap

NOTE: It is usually used as Subchart for other Charts. For example by: https://github.com/tjungbauer/helm-charts/tree/main/charts/collection-management-operators

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
helm install my-release tjungbauer/helper-operators
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
The following table lists the configurable parameters of the chart and their default values.

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `namespaces` | A list of specific namespaces that should be created | `single-sign-on` and openshift-cert-manager-operator` |
| `console_plugins` | A list of Console Plugins that shall be enabled | `none` |
| `UNIQUE-IDENTIFIER`| This is a unique identifier that will be used to create the Argo CD Application | `` |
| `UNIQUE-IDENTIFIER.enabled` | enabled yes/no | `false` |
| `UNIQUE-IDENTIFIER.syncwave` | Sets the Syncwave for Argo CD | 0 |
| `UNIQUE-IDENTIFIER.namespace.name` | The Namespace the Operator should be installed in | ` ` |
| `UNIQUE-IDENTIFIER.namespace.descr` | Description of the namespace | ` ` |
| `UNIQUE-IDENTIFIER.namespace.displayname` | Display name of the namespace | ` ` |
| `UNIQUE-IDENTIFIER.namespace.create` | Create the namespace true/false | `false` |
| `UNIQUE-IDENTIFIER.subscription` | Definition of the Operator Subscription | `` |
| `UNIQUE-IDENTIFIER.subscription.channel` | Subscription channel | `stable` |
| `UNIQUE-IDENTIFIER.subscription.approval` | Operator Subscription update behavior  | `Automatic` |
| `UNIQUE-IDENTIFIER.subscription.operatorName` | Operator name | `` |
| `UNIQUE-IDENTIFIER.subscription.source` | Operator source | `redhat-operators `|
| `UNIQUE-IDENTIFIER.subscription.sourceNamespace` | Operator Sourcenamespace  | `openshift-marketplace` |
| `UNIQUE-IDENTIFIER.subscription.config.resources.requests.memory` | Optional: resource requests - memory (e.g. 64Mi) |  |
| `UNIQUE-IDENTIFIER.subscription.config.resources.requests.cpu` | Optional: resource requests - cpu (e.g. 250m) |  |
| `UNIQUE-IDENTIFIER.subscription.config.resources.limits.memory` | Optional: resource limits - memory (e.g. 128Mi) |  |
| `UNIQUE-IDENTIFIER.subscription.config.resources.requests.memory` | Optional: resource requests - cpu (e.g. 500m) |  |
| `UNIQUE-IDENTIFIER.operatorgroup.create` |  Create an Operatorgroup object  | `false` |
| `UNIQUE-IDENTIFIER.operatorgroup.notownnamespace` | Monitor own Namespace. For some Operators no `targetNamespaces` must be defined | `false` |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

## Example

Installing the Operator "Open Cluster Management" (that is Red Hat Advanced Cluster Management)

TIP: Get the values for the subscription specification via `oc get packagemanifest advanced-cluster-management -o yaml`

```yaml
---
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
        config:
          resources:
            requests:
              memory: 64Mi
              cpu: 250m
            limits:
              memory: 128Mi
              cpu: 500m
      operatorgroup:
        create: true
        notownnamespace: false
```
