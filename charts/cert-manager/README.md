

# cert-manager

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.2](https://img.shields.io/badge/Version-1.0.2-informational?style=flat-square)

 

  ## Description

  Install and configure the Cert-Manager

This Helm Chart installs and configures the Cert-Manager Operator. It can patch the ClusterManager resource in order to override arguments (for example the list of recursive nameservers)
 and to configure ClusterIssuer or Issuers.

Currently, the built-in in-tree issuers are supported: https://cert-manager.io/docs/configuration/selfsigned/

. selfSigned
. ACME
. CA
. Venafi
. Vault

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.0 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (see folder cluster/management-cluster/cert-manager)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/cert-manager

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certManager.enable_patch | bool | false | Enable pathing of the certManager resource, for the ACME provider. This is required, when the recusrive nameserver shall be changed. For example, when private and public define-domains in AWS Route 53 are used, then the DNS server must be set. Verify the documentation at: https://docs.openshift.com/container-platform/4.15/security/cert_manager_operator/cert-manager-operator-issuer-acme.html The resource itself it created automatically and is therefor patched. |
| certManager.overrideArgs | list | `["--dns01-recursive-nameservers-only","--dns01-recursive-nameservers=ns-362.awsdns-45.com:53,ns-930.awsdns-52.net:53"]` | List of arguments that should be overwritten. |
| issuer[0].acme | object | `{"email":"your@email.com","solvers":[{"dns01":{"route53":{"accessKeyIDSecretRef":{"key":"access-key-id","name":"prod-route53-credentials-secret"},"region":"your-region","secretAccessKeySecretRef":{"key":"secret-access-key","name":"prod-route53-credentials-secret"}}},"selector":{"dnsZones":["define-domains"]}}]}` | Create ACME issuer. ACME CA servers rely on a challenge to verify that a client owns the domain names that the certificate is being requested for. |
| issuer[0].acme.email | string | `"your@email.com"` | Email address, Let's Encrypt will use this to contact you about expiring certificates, and issues related to your account. |
| issuer[0].acme.solvers | list | `[{"dns01":{"route53":{"accessKeyIDSecretRef":{"key":"access-key-id","name":"prod-route53-credentials-secret"},"region":"your-region","secretAccessKeySecretRef":{"key":"secret-access-key","name":"prod-route53-credentials-secret"}}},"selector":{"dnsZones":["define-domains"]}}]` | add a challenge solver. This coulr be DNS01 or HTTP01 The yaml specification will be used as is Verify the official documentation for detailed information: https://cert-manager.io/docs/configuration/acme/ |
| issuer[0].enabled | bool | false | Enable this issuer. |
| issuer[0].name | string | `"acme"` |  |
| issuer[0].syncwave | int | `20` | Syncewave to create this issuer |
| issuer[0].type | string | `"ClusterIssuer"` | Type can be either ClusterIssuer or Issuer |
| issuer[1].enabled | bool | false | Enable this issuer. |
| issuer[1].name | string | `"selfsigned"` |  |
| issuer[1].selfSigned | bool | `true` | Create a selfSigned issuer. The SelfSigned issuer doesn't represent a certificate authority as such, but instead denotes that certificates will "sign themselves" using a given private key. Detailed information can be found at: https://cert-manager.io/docs/configuration/selfsigned/ |
| issuer[1].type | string | `"ClusterIssuer"` | Type can be either ClusterIssuer or Issuer |
| issuer[2].ca | object | `{"secretName":"ca-key-pair"}` | Create CA issuer, CA issuers are generally either for trying cert-manager out or else for advanced users with a good idea of how to run a PKI. Detailed information can be found at: https://cert-manager.io/docs/configuration/ca/ |
| issuer[2].enabled | bool | false | Enable this issuer. |
| issuer[2].name | string | `"ca"` |  |
| issuer[2].type | string | `"ClusterIssuer"` | Type can be either ClusterIssuer or Issuer |
| issuer[3].enabled | bool | false | Enable this issuer. |
| issuer[3].name | string | `"vault"` |  |
| issuer[3].type | string | `"ClusterIssuer"` | Type can be either ClusterIssuer or Issuer |
| issuer[3].vault | object | `{"auth":{"tokenSecretRef":{"key":"token","name":"cert-manager-vault-token"}},"caBundle":"<base64 encoded caBundle PEM file>","path":"pki_int/sign/example-dot-com","server":"https://vault.local"}` | Enable Vault issuer. The Vault Issuer represents the certificate authority Vault. Detailed information can be found at: https://cert-manager.io/docs/configuration/vault/ |
| issuer[4].enabled | bool | false | Enable this issuer. |
| issuer[4].name | string | `"venafi"` |  |
| issuer[4].type | string | `"ClusterIssuer"` | Type can be either ClusterIssuer or Issuer |
| issuer[4].venafi | object | `{"cloud":{"apiTokenSecretRef":{"key":"apikey","name":"vaas-secret"}},"zone":"My Application\\My CIT"}` | The Venafi Issuer types allows you to obtain certificates from Venafi as a Service (VaaS) and Venafi Trust Protection Platform (TPP) instances. Detailed information can be found at: https://cert-manager.io/docs/configuration/venafi/ |

## Example values

```yaml
---
clusterManager:
  enable_patch: true

  overrideArgs:
    - '--dns01-recursive-nameservers-only'
    - --dns01-recursive-nameservers=ns-362.awsdns-45.com:53,ns-930.awsdns-52.net:53

issuer:
  - name: letsencrypt-prod
    type: ClusterIssuer
    enabled: true
    syncwave: 20

    acme:
      email: <-your-email-address>

      solvers:
        - dns01:
            route53:
              accessKeyIDSecretRef:
                key: access-key-id
                name: prod-route53-credentials-secret
              region: us-west-1
              secretAccessKeySecretRef:
                key: secret-access-key
                name: prod-route53-credentials-secret
          selector:
            dnsZones:
              - <list of domain zones>
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
