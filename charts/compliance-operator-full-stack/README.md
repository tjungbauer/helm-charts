[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install & configure Compliance Operator

Install and configure the compliance operator. This uses two Subchart as dependencies:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): to create the required Operator resources
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): to verify if the Deployments of this Operator are running. 

Once the Operator installation is done a ScanSettingBinding object is created, using defined Profiles.

The full process is: 

1. Create Namespace
2. Create Operatorgroup and Subscription (This installs the Operator)
3. Create ServiceAccount, Role, RoleBinding and Job (This verifies of the Operator is up and running)
4. Create a ScanSettingBinding object (This configures the Compliance Operator and initiates an immediate scan)

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
helm install my-release tjungbauer/compliance-operator-full-stack
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
The following table lists the configurable parameters of the chart and their default values. Only variables of this specific Helm Chart are listed. For the values of the Subchart read to according to README of the Subcharts. 

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `compliance.scansettingbinding.enabled` | Shall a ScanSettingBinding Object be created | `false` |
| `compliance.scansettingbinding.syncwave` | Argo CD Syncwave | `0` |
| `compliance.scansettingbinding.profiles` | Compliance profiles to use (defined as list), for example `ocp4-cis-node` | `` |
| `compliance.scansettingbinding.scansetting` | ScanSetting to use, for example 'default' | `` |

## Example

```yaml
---
helper-operator:
  operators:
    compliance-operator:
      enabled: true
      syncwave: '0'
      namespace:
        name: openshift-compliance
        create: true
      subscription:
        channel: release-0.1
        approval: Automatic
        operatorName: compliance-operator
        source: redhat-operators
        sourceNamespace: openshift-marketplace
      operatorgroup:
        create: true
        notownnamespace: true

helper-status-checker:
  enabled: true

  # space separate list of deployments which shall be checked for status
  deployments: "compliance-operator ocp4-openshift-compliance-pp rhcos4-openshift-compliance-pp"

  wait_time: 60  # wait time in seconds for the check-job to verify when the deployments should be ready

  namespace:
    name: openshift-compliance

  serviceAccount:
    create: true
    name: "sa-compliance"

compliance:
  namespace:
    name: openshift-compliance
    syncwave: '0'
    descr: 'Red Hat Compliance'
  scansettingbinding:
    enabled: true
    syncwave: '3'
    profiles:
      - name: ocp4-cis-node
      - name: ocp4-cis
    scansetting: default
```
