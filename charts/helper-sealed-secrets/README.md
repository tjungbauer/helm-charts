

# helper-sealed-secrets

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)

 

  ## Description

  A helper Chart to render SealedSecret objects from values, so that a Chart can be reused on clusters with different sealing keys.

This Helm Chart renders [SealedSecret](https://github.com/bitnami-labs/sealed-secrets) objects from values.

A SealedSecret can only be decrypted by the cluster it was sealed for. If the object is part of a Chart, this Chart
only works on one cluster. With this helper, a Chart only adds a dependency and every cluster provides its own
encrypted values. A cluster without values renders no object.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.31 |

This chart has no dependencies to other charts, but the Sealed Secrets controller must be deployed on the cluster.

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <dev@stdin.at> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-sealed-secrets

## Parameters

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| secrets | object | {} | SealedSecret objects to render, the key is the name of the Secret. Nothing is rendered if this is empty. A map is used so that value files can add a Secret without replacing the others.  Every entry supports:   enabled:               set to false to skip this Secret (default: true)   namespace:             namespace of the Secret (required)   encryptedData:         the values encrypted with kubeseal (required)   type:                  type of the Secret, for example Opaque   syncwave:              Syncwave for Argo CD (default: 0)   additionalAnnotations: additional annotations   additionalLabels:      additional labels |

## Example

Add the dependency to the Chart:

```yaml
dependencies:
  - name: helper-sealed-secrets
    version: ~1.0.0
    repository: https://charts.stderr.at/
```

Add the Secrets to the values of the cluster:

```yaml
helper-sealed-secrets:
  secrets:
    prod-route53-credentials-secret:
      namespace: cert-manager
      syncwave: 1
      encryptedData:
        access-key-id: AgCfy6kc...
        secret-access-key: AgArsykG...
```

Name and namespace must match the values used with kubeseal:

```bash
echo -n '<value>' | kubeseal --raw --namespace cert-manager --name prod-route53-credentials-secret
```
