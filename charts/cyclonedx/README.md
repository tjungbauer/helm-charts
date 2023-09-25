[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install CycloneDX

CycloneDX provides advanced, supply chain capabilities for cyber risk reduction. We are using the Software Bill of Material (SBOM) parts. 
SBOM is a complete and accurate inventory of all first-party and third-party components is essential for risk identification.

This chart will install CycloneDX BOM Repo server, that enables you to store SBOM inventories on your cluster.

For detail information check: [CycloneDX SBOM](https://cyclonedx.org/capabilities/sbom/)

And for an example on how to use it during a pipeline run check: [Generating a SBOM](https://blog.stderr.at/securesupplychain/2023-06-22-securesupplychain-step7/)

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
helm install my-release tjungbauer/openshift-logging
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
| `namespace.create` | Create a Namespace or not (bool)| `false` |
| `namespace.name` | Name of the Namespace | `` |

## Example

```yaml
namespace:
  create: true
  name: cyclonedx
```