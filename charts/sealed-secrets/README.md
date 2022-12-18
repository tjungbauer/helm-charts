[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install Sealed Secrets

Install Sealed Secrets to secure your sensitive data. This uses as Subchart the Bitnami Chart: 

* [Bitnami Sealed Secret](https://bitnami-labs.github.io/sealed-secrets)

You can also call this directly. This Chart was only created to wrap it into processes required for labs. However, it is mainly used to actively create the required Namespace first, since there were issues where the option in the source Helm Chart did not work. 

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
helm install my-release tjungbauer/sealed-secrets
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `namespace.name` | Namespace where Sealed Secrets shall be installed | `` |
| `namespace.create` | Create Namespace? | `false` |


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