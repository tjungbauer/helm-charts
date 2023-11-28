[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)


# Helper Chart to create ACM Policies

The chart creates all required objects for ACM Policies, namely: 

* Policy
* PolicySet
* Placement and Binding

NOTE: Only ConfigurationPolicies are currently supported!

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
helm install my-release tjungbauer/helm-policy-generator
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
Please verify the example value-files and their inline documentation. I usually create 2 files: one for policyDefaults and one for the policy-template.

## Examples

see files/folders:

* values.yaml
* ./examples