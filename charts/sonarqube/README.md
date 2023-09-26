[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install SonarQube

SonarQube is a solution that allows (source) code analysis and quality checks. The community version installed here is part of the Secure Supply Chain example.
It depends on the [chart](https://SonarSource.github.io/helm-chart-sonarqube) provided by Sonar and was extended with a Job to set the administrator password. 
To do so a sealed secret is used that was created like this:

```bash
echo -n 'PASSWORD-HERE' | oc create secret generic credentials --dry-run=client --from-file=adminpass=/dev/stdin -o yaml -n sonarqube \
| kubeseal --controller-namespace=sealed-secrets --controller-name=sealed-secrets --format yaml
```

However, you can download this chart and change it to use a different option for the secret, or set the option **set_admin_password** to false, so it will be ignored. 

For detail information check: [SonarQube](https://www.sonarsource.com/products/sonarqube/)

And for an example on how to use it during a pipeline run check: [Analyse Source Code](https://blog.stderr.at/securesupplychain/2023-06-18-securesupplychain-step3/)

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
| `ep` | Anchor to define the endpoint | `` |
| `endpoint` | as defined by the anchor to update or set the administrator password | `` |
| `set_admin_password` | Set the admin password or not | `false` |

All other settings are bypassed to SonarQube Helm Chart. 

## Example

```yaml
ep: &endpoint sonarqube.apps.ocp.aws.ispworld.at

namespace:
  name: sonarqube
  create: true

endpoint: *endpoint

# Sonarqube Settings
sonarqube:
  OpenShift:
    enabled: true
    createSCC: true
  persistence:
    enabled: true
  networkPolicy:
    enabled: false
  ingress:
    enabled: true
    hosts:
      - name: *endpoint
        path: /
  plugins:
    install:
      - https://github.com/checkstyle/sonar-checkstyle/releases/download/10.9.3/checkstyle-sonar-plugin-10.9.3.jar
      - https://github.com/dependency-check/dependency-check-sonar-plugin/releases/download/3.1.0/sonar-dependency-check-plugin-3.1.0.jar
      - https://github.com/sbaudoin/sonar-yaml/releases/download/v1.7.0/sonar-yaml-plugin-1.7.0.jar
      - https://github.com/sbaudoin/sonar-shellcheck/releases/download/v2.5.0/sonar-shellcheck-plugin-2.5.0.jar
```