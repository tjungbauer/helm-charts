[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Helper Chart to deploy Namespace

This chart is prepared to help with Namespace onboarding. 
It is able to create:

* Namespaces
* Labels
* enable/disable default Network Policy (ingress, monitoring, deny all, apiserver, allow inside a namespace)
* custom network policies
* resource quota
* limit ranges

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
helm install my-release tjungbauer/helper-proj-onboarding
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
| `namespace.name` | Namespace where Sealed Secrets shall be installed | `` |
| `namespace.create` | Create Namespace? | `false` |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

## Example

```yaml
---
namespace:
  name: my_test_application
  enabled: false
```
