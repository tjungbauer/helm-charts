

# sealed-secrets

  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.15](https://img.shields.io/badge/Version-1.0.15-informational?style=flat-square)

 

  ## Description

  A Helm chart to deploy sealed-secrets - depends on Bitnami's helm chart

# Install Sealed Secrets

Install Sealed Secrets to secure your sensitive data. This chart here is used as a wrapper to allow additional settings if required and uses as a Subchart the Bitnami Chart:

* [Bitnami Sealed Secret](https://bitnami-labs.github.io/sealed-secrets)

You can also call this directly. This Chart was only created to wrap it into processes required for labs. However, it is mainly used to actively create the required Namespace first, since there were issues where the option in the source Helm Chart did not work.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://bitnami-labs.github.io/sealed-secrets | sealed-secrets | 2.14.2 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/sealed-secrets

## Parameters

NOTE: Only the parameters of the Subcharts that I ususally set are described here.
Verify the full documentation of the Subchart at [Bitnami Sealed Secret](https://bitnami-labs.github.io/sealed-secrets)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| namespace.create | bool | false | Create Namespace or not |
| namespace.name | string | `"sealed-secrets"` | Namespace where Sealed Secrets shall be installed  |
| sealed-secrets.commandArgs | list | `["--update-status=true"]` | Additional command arguments |
| sealed-secrets.containerSecurityContext | object | `{"enabled":false}` | Dont touch the security context values, deployment will fail in OpenShift otherwise. |
| sealed-secrets.enabled | bool | false | Enable or disable deployment of Sealed Secrets |
| sealed-secrets.fullnameOverride | string | `"sealed-secrets"` | Overwrite the Full-name |
| sealed-secrets.nameOverride | string | `"sealed-secrets"` | Overwrite the name |
| sealed-secrets.namespace | string | `"sealed-secrets"` | Target Namespace |
| sealed-secrets.podSecurityContext | object | `{"enabled":false}` | Dont touch the security context values, deployment will fail in OpenShift otherwise. |

## Example

```yaml
---
sealed-secrets:
  # Disabled by default
  enabled: false
  nameOverride: sealed-secrets
  fullnameOverride: sealed-secrets
  namespace: sealed-secrets
  # Dont touch the security context values, deployment will fail in OpenShift otherwise.
  podSecurityContext:
    enabled: false
  containerSecurityContext:
    enabled: false
  commandArgs:
    - "--update-status=true"

namespace:
  name: sealed-secrets
  create: true
```

## Example Usage

Once the operator has been installed the command line tool **kubeseal** must be installed

Either use `brew install kubeseal` or download your appropriate release from: https://github.com/bitnami-labs/sealed-secrets/releases

### Simple tests

* Create a new project `oc new-project myproject`

* Create a secret:

  ```
  echo -n bar | oc create secret generic mysecret --dry-run=client --from-file=foo=/dev/stdin -o yaml > mysecret.json`
  ```

  UNENCRYPTED secreted stored as mysecret.json --> not good practice, but good for testing :)

  Seal the secret:
 
  ```
  kubeseal --controller-name=sealed-secrets --controller-namespace=sealed-secrets < mysecret.json > mysealedsecret.json`
  ```

  Sealed secret is stored at mysealedsecret.json. It is safe to store this on Github

* Installed the sealed secret `oc create -f mysealedsecret.json`

  Verify the existence:

  ```
  ❯ oc get SealedSecret
  NAME       AGE
  mysecret   4s
  ```

  ```
  ❯ oc get secrets mysecret
  NAME       TYPE     DATA   AGE
  mysecret   Opaque   1      13s
  ```

### Updating or appending new values

```
echo -n "my new password" \
    | oc create secret generic dummy --dry-run=client --from-file=password=/dev/stdin -o json \
    | kubeseal --controller-namespace=sealed-secrets --controller-name=sealed-secrets --format yaml --merge-into mysealedsecret.json
```

```
❯ oc apply -f mysealedsecret.json
sealedsecret.bitnami.com/mysecret configured
```

```
❯ oc get secrets mysecret
NAME       TYPE     DATA   AGE
mysecret   Opaque   2      3m32s
```

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release tjungbauer/<chart-name>>
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
