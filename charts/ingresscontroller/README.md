

# ingresscontroller

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.15](https://img.shields.io/badge/Version-1.0.15-informational?style=flat-square)

 

  ## Description

  Configures the IngressController object.

This Helm Chart configures the IngressController and can set a replica, nodeSelector and tolerations.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.14 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (see folder cluster/management-cluster/ingresscontroller)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/ingresscontroller

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingresscontrollers | list | `[{"annotations":"","defaultCertificate":"my-certificate","domain":"mydomain.com","enabled":false,"endpointPublishingStrategy":{"hostNetwork":{"httpPort":7444,"httpsPort":7443,"statsPort":7936},"type":"HostNetwork"},"name":"default","namespaceSelector":{"matchExpressions":[{"key":"myenvironment","operator":"NotIn","values":["false"]}]},"nodePlacement":{"nodeSelector":{"key":"node-role.kubernetes.io/infra","value":""},"tolerations":[{"effect":"NoSchedule","key":"node-role.kubernetes.io/infra","operator":"Equal","value":"reserved"},{"effect":"NoExecute","key":"node-role.kubernetes.io/infra","operator":"Equal","value":"reserved"}]},"replicas":3,"routeAdmission":{"namespaceOwnership":"Strict","wildcardPolicy":"WildcardsDisallowed"},"tlsSecurityProfile":{"custom":{"ciphers":["ECDHE-ECDSA-CHACHA20-POLY1305","ECDHE-RSA-CHACHA20-POLY1305","ECDHE-RSA-AES128-GCM-SHA256","ECDHE-ECDSA-AES128-GCM-SHA256"],"minTLSVersion":"VersionTLS12"},"type":"Custom"}}]` | Define ingressControllers Multiple might be defined. |
| ingresscontrollers[0] | object | `{"annotations":"","defaultCertificate":"my-certificate","domain":"mydomain.com","enabled":false,"endpointPublishingStrategy":{"hostNetwork":{"httpPort":7444,"httpsPort":7443,"statsPort":7936},"type":"HostNetwork"},"name":"default","namespaceSelector":{"matchExpressions":[{"key":"myenvironment","operator":"NotIn","values":["false"]}]},"nodePlacement":{"nodeSelector":{"key":"node-role.kubernetes.io/infra","value":""},"tolerations":[{"effect":"NoSchedule","key":"node-role.kubernetes.io/infra","operator":"Equal","value":"reserved"},{"effect":"NoExecute","key":"node-role.kubernetes.io/infra","operator":"Equal","value":"reserved"}]},"replicas":3,"routeAdmission":{"namespaceOwnership":"Strict","wildcardPolicy":"WildcardsDisallowed"},"tlsSecurityProfile":{"custom":{"ciphers":["ECDHE-ECDSA-CHACHA20-POLY1305","ECDHE-RSA-CHACHA20-POLY1305","ECDHE-RSA-AES128-GCM-SHA256","ECDHE-ECDSA-AES128-GCM-SHA256"],"minTLSVersion":"VersionTLS12"},"type":"Custom"}}` | Name of the IngressController. OpenShift initial IngressController is called 'default'. |
| ingresscontrollers[0].annotations | string | N/A | Additional annotations for the IngressController For example to enable HTTP/2 add the following: ingress.operator.openshift.io/default-enable-http2: true |
| ingresscontrollers[0].defaultCertificate | string | N/A | The name of the secret that stores the certificate information for the IngressController |
| ingresscontrollers[0].domain | string | N/A | domain is a DNS name serviced by the ingress controller and is used to configure multiple features: * For the LoadBalancerService endpoint publishing strategy, domain is used to configure DNS records. See endpointPublishingStrategy. * When using a generated default certificate, the certificate will be valid for domain and its subdomains. See defaultCertificate. * The value is published to individual Route statuses so that end-users know where to target external DNS records. domain must be unique among all IngressControllers, and cannot be updated. If empty, defaults to ingress.config.openshift.io/cluster .spec.domain. |
| ingresscontrollers[0].enabled | bool | false | Enable the configuration |
| ingresscontrollers[0].endpointPublishingStrategy | object | N/A | endpointPublishingStrategy is used to publish the ingress controller endpoints to other networks, enable load balancer integrations, etc. If unset, the default is based on infrastructure.config.openshift.io/cluster .status.platform: AWS: LoadBalancerService (with External scope) Azure: LoadBalancerService (with External scope)  GCP: LoadBalancerService (with External scope) IBMCloud: LoadBalancerService (with External scope) AlibabaCloud: LoadBalancerService (with External scope) Libvirt: HostNetwork Any other platform types (including None) default to HostNetwork. endpointPublishingStrategy cannot be updated. |
| ingresscontrollers[0].namespaceSelector | object | N/A | namespaceSelector is used to filter the set of namespaces serviced by the ingress controller. This is useful for implementing shards. If unset, the default is no filtering. |
| ingresscontrollers[0].nodePlacement | object | empty | Bind IngressController to specific nodes Here as example for Infrastructure nodes. |
| ingresscontrollers[0].nodePlacement.tolerations | list | `[{"effect":"NoSchedule","key":"node-role.kubernetes.io/infra","operator":"Equal","value":"reserved"},{"effect":"NoExecute","key":"node-role.kubernetes.io/infra","operator":"Equal","value":"reserved"}]` | Tolerations, required if the nodes are tainted. |
| ingresscontrollers[0].replicas | int | 2 | Number of replicas for this IngressController |
| ingresscontrollers[0].routeAdmission | object | N/A | routeAdmission defines a policy for handling new route claims (for example, to allow or deny claims across namespaces). |
| ingresscontrollers[0].routeAdmission.namespaceOwnership | string | N/A | namespaces should be handled. <br /> Value must be one of: <br /> <ul> <li>Strict: Do not allow routes in different namespaces to claim the same host.</li> <li>InterNamespaceAllowed: Allow routes to claim different paths of the same host name across namespaces.</li> </ul> If empty, the default is Strict. <br /> |
| ingresscontrollers[0].routeAdmission.wildcardPolicy | string | N/A | wildcardPolicy describes how routes with wildcard policies should be handled for the ingress controller.<br /> Note: Updating WildcardPolicy from WildcardsAllowed to WildcardsDisallowed will cause admitted routes with a wildcard policy of Subdomain to stop working.<br /> These routes must be updated to a wildcard policy of None to be readmitted by the ingress controller.<br /> WildcardPolicy supports WildcardsAllowed and WildcardsDisallowed values.<br /> If empty, defaults to "WildcardsDisallowed". |
| ingresscontrollers[0].tlsSecurityProfile | object | N/A | tlsSecurityProfile specifies settings for TLS connections for ingresscontrollers.  If unset, the default is based on the apiservers.config.openshift.io/cluster resource. Note that when using the Old, Intermediate, and Modern profile types, the effective profile configuration is subject to change between releases.  |
| ingresscontrollers[0].tlsSecurityProfile.type | string | N/A | type is one of Old, Intermediate, Modern or Custom. Custom provides the ability to specify individual TLS security profile parameters. Old, Intermediate and Modern are TLS security profiles based on: https://wiki.mozilla.org/Security/Server_Side_TLS#Recommended_configurations The profiles are intent based, so they may change over time as new ciphers are developed and existing ciphers are found to be insecure. Depending on precisely which ciphers are available to a process, the list may be reduced. Note that the Modern profile is currently not supported because it is not yet well adopted by common software libraries. |

## Example values

```yaml
---
---
# -- Define ingressControllers
# Multiple might be defined.
ingresscontrollers:
    # -- Name of the IngressController. OpenShift initial IngressController is called 'default'.
  - name: default

    # -- Enable the configuration
    # @default -- false
    enabled: true

    # -- Number of replicas for this IngressController
    # @default -- 2
    replicas: 3

    # -- Bind IngressController to specific nodes
    # Here as example for Infrastructure nodes.
    # @default -- empty
    nodePlacement:

      # NodeSelector that shall be used.
      nodeSelector:
        key: node-role.kubernetes.io/infra
        value: ''

      # -- Tolerations, required if the nodes are tainted. 
      tolerations:
        - effect: NoSchedule
          key: node-role.kubernetes.io/infra
          operator: Equal
          value: reserved
        - effect: NoExecute
          key: node-role.kubernetes.io/infra
          operator: Equal
          value: reserved
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
