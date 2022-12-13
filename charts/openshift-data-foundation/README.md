[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install Operator OpenShift Data Foundation

This simply installs OpenShift Data Foundation (ODF) Operator and validates the status of the installation. 
It uses the Subchart: 

* helper-operator: to create the required Operator resources
* helper-status-checker: to verify of the Deployments of this Operator are running. 

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
helm install my-release tjungbauer/openshift-data-foundation
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Example

```yaml
---
helper-operator:
  operators:
    odf-operator:
      enabled: true
      syncwave: '0'
      namespace:
        name: openshift-storage
        create: true
      subscription:
        channel: stable-4.10
        approval: Automatic
        operatorName: odf-operator
        source: redhat-operators
        sourceNamespace: openshift-marketplace
      operatorgroup:
        create: true

helper-status-checker:
  enabled: true

  # space separate list of deployments which shall be checked for status
  deployments: "ocs-operator odf-console odf-operator-controller-manager ocs-metrics-exporter noobaa-operator csi-addons-controller-manager"

  wait_time: 60  # wait time in seconds for the check-job to verify when the deployments should be ready

  namespace:
    name: openshift-storage

  serviceAccount:
    create: true
    name: "status-checker"
```
