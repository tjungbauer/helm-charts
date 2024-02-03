[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install Container Security Operator

This chart will install Quay Container Security Operator. It is just the deployment of the Operator, which does not have any CRDs or further configuration. 
The following Subcharts are used as dependency:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): to create the required Operator resources
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): to verify if the Deployments of this Operator are running. 

The whole process has multiple hooks and waves, which are illustrated in the image: 

![GitOps Flow](docs/img/RHACS-Deployment-Waves.png)

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
helm install my-release tjungbauer/rhacs-full-stack
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
None
