[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Demonstrator Service Side Apply

A Chart to test Service Side Apply. It adds annotations to existing Node Objects. The idea is to use it as a wrapper for all kinds of SSA actions. Simply add additional templates.

It is best used with a GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops

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
helm install my-release tjungbauer/helper-service-side-apply
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

# Parameters
The following table lists the configurable parameters of the chart and their default values. As an example, Node Labels are added:

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `nodes.name` | Name of the Node object that shall be modified | `` |
| `nodes.enabled` | Shall changes be done | `false` |
| `nodes.ignore_argocd_labels` | Ignores default GitOps labels | `false` |
| `nodes.custom_labels` | A list of customer labels key=value pairs | `` |

## Example

```yaml
nodes:
  - name: node1
    enabled: true
    ignore_argocd_labels: true
    custom_labels:
      environment: 'Production'
      gpu: 'true'
  - name: node2
    enabled: true
    ignore_argocd_labels: true
    custom_labels:
      environment: 'Test'
      gpu: 'true'
```
