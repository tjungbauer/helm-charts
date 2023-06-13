[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Generic Cluster Configuration

Configure your cluster. Any generic and repeatable configuration goes in here. This helps me to quickly deploy Lab environments and demonstrate features. 

It is best used with a GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-cluster-bootstrap

Multiple Argo CD applications are using this Chart to enable different aspects of the cluster (i.e., etcd encryption).

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
helm install my-release tjungbauer/generic-cluster-config
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
The following table lists the configurable parameters of the chart and their default values. The example below to get an idea of how a values file might look like.

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `etcd_encryption.enabled` | Enable ETCD encryption? | `false` |
| `self_provisioner.deactivate` | Disable self provisioner | `false` |

| `config_allowed_registries.enabled` | Enable configuration to limit allowed registries | `false` |
| `config_allowed_registries.registry_sources` | `` | `` |
| `config_allowed_registries.allowed_registries` | Defines list of allowed registries | [] |
| `config_allowed_registries.allowedRegistriesForImport` | Defines list of registries allowed for import | [] |
| `config_allowed_registries.allowedRegistriesForImport.domain` | Domainname | `` |
| `config_allowed_registries.allowedRegistriesForImport.insecure` | Shall SSL be verified or not | `` |
| `idp.enabled` | Shall identity provider configuration be done. This includes IDP setup itself as well as frontpage customization | `false` |
| `idp.customloginpage.enabled` | Enable a customized login page for OpenShift | `false` |
| `idp.customloginpage.secretname` | Secret name that holds the html configuration for the startpage (login) of OpenShift | `customlogin` |
| `idp.customloginpage.secretname_providerpage` | Secretname that holds the html configuration for the IDP selection page | `customerproviderpage` |
| `enable_idp_provider` | Create IDP configuration such as LDAP or HTPasswd | `false` |
| `providers.htpasswd` | List of configurations for HTPasswd IDP | `` |
| `providers.htpasswd.name` | Name of IDP as shown on the IDP selection page | `HTPASSWD` |
| `providers.htpasswd.enabled` | Is this IDP enabled? | `false` |
| `providers.htpasswd.secretname` | Name of the secret that holds sensitive information (the htpasswd file) | `htpasswd-secret` |
| `providers.ldap` | List of configurations for LDAP IDP | `` |
| `providers.ldap.name` | Name of IDP as shown on the IDP selection page  | `LDAP` |
| `providers.ldap.enabled` | Is this IDP enabled? | `false` |
| `providers.ldap.url` | LDAP server URL | `120.0.0.1` |
| `providers.ldap.insecure` | Is LDAP server using a valid certificate? | `true` |
| `providers.ldap.binddn` | Username to authenticate against the LDAP | `xyz` |
| `providers.ldap.preferredusername` | Preferred username as they are stored in LDAP. AD typically uses sAMAccountName | `sAMAccountName` |
| `providers.ldap.secretname` | Name of the secret that stored the bindPassword | `ldap-secret` |
| `providers.ldap.cmname` | Name of the ConfigMap | `ca-config-map` |
| `console` | List of items that configure console customizations. For example: Banners, additional Links, Example for YAMLs etc. | `` |
| `console.console_banners` | Definition of Top or Bottom Banners | `` |
| `console.console_banners.<BANNER>.enabled` | Shall a banner on the top of the page be enabled | `false` |
| `console.console_banners.<BANNER>.text` | Text the banner shall show | `` |
| `console.console_banners.<BANNER>.location` | Location of the banner. Can be BannerTop or BannerBottom | `` |
| `console.console_banners.<BANNER>.color` | Text color of the Banner | `#` |
| `console.console_banners.<BANNER>.backgroundcolor` | Background color of the banner | `#` |
| `console.console_banners.<BANNER>.link.href` | A link to "somewhere" | `` |
| `console.console_banners.<BANNER>.link.text` | Text of that link | `` |
| `console.console_links` | Shall we create custom links in the UI. This represents a list of possible links | `` |
| `console.console_links.<YOURCUSTOMLINK>.enabled` | Is this link definition enabled | `false` |
| `console.console_links.<YOURCUSTOMLINK>.text` | Text of this custom link | `` |
| `console.console_links.<YOURCUSTOMLINK>.location` | Location where the link shall be placed. Can be either: **UserMenu, HelpMenu, NamespaceDashboard, ApplicationMenu** | `` |
| `console.console_links.<YOURCUSTOMLINK>.href` | Target of this custom link | `` |
| `console.console_links.<YOURCUSTOMLINK>.namespaces` | List of namespaces where the link shall be shown. Valid for NamespaceDashboard location | `` |
| `console.console_links.<YOURCUSTOMLINK>.applicationMenu.section` | The section inside the application menu. | `` |
| `console.console_links.<YOURCUSTOMLINK>.applicationMenu.imageURL` | The image that shall be used in the application menu. The image should be squar and will be shown as 24x24 pixels. | `` |
| `console.yamlsamples` | List of YAML samples as they should be shown in the UI whenever you create a YAML of that kind | `` |
| `console.yamlsamples.<YOURSAMPLE>.enabled` | Is this customization enabled | `` |
| `console.yamlsamples.<YOURSAMPLE>.targetresource.apiversion` | API version of that kind | `` |
| `console.yamlsamples.<YOURSAMPLE>.targetresource.kind` | The kind of the kubernetes object you would like to customize | `` |
| `console.yamlsamples.<YOURSAMPLE>.title` | A title to be shown in the UI | `` |
| `console.yamlsamples.<YOURSAMPLE>.descr` | A description to be shown in the UI | `` |
| `console.yamlsamples.<YOURSAMPLE>.yamlDef` | Your YAML example as it should be shown in the UI | `` |


## Example

```yaml
---
etcd_encryption:
  enabled: false

self_provisioner:
  deactivate: false

config_allowed_registries:
  enabled: false
  registry_sources:
    allowed_registries:
    - registry.connect.redhat.com
    - registry.redhat.io
    - quay.io
    - registry.access.redhat.com
    - 'image-registry.openshift-image-registry.svc:5000'
  allowedRegistriesForImport:
  - domain: quay.io
    insecure: false
  - domain: registry.connect.redhat.com
  - domain: registry.redhat.io

idp:
  enabled: false
  customloginpage:
    enabled: false
    secretname: customlogin
    secretname_providerpage: customerproviderpage
  enable_idp_provider: false
  providers:
    htpasswd:
      - name: HTPASSWD
        enabled: false
        secretname: htpasswd-secret
    ldap:
      - name: LDAP
        enabled: false
        url: 127.0.0.1
        insecure: true
        binddn: xyz
        preferredusername: sAMAccountName

console:
  console_banners:
    topbanner:
      enabled: false
      text: 'MGMT Cluster'
      location: BannerTop
      color: "#FFFFFF"
      backgroundcolor: '#0088ee'
    bottombanner:
      enabled: false
      text: Copyright © 2020 Sample Company, Inc. |
      location: BannerBottom
      color: "#FFFFFF"
      backgroundcolor: '#000'
      link:
        href: 'https://www.example.com/data-protection-policy'
        text: Data Protection and Privacy Policy

  console_links:
    userlink:
      enabled: false
      text: "Intranet"
      location: UserMenu
      href: https://intranet
    namespacedlink:
      enabled: false
      text: Link valid for selected namespace only
      location: NamespaceDashboard
      href: https://report
      namespaces:
        - default
        - openshift-gitops
    namespacedlink_all_namespaces:
      enabled: false
      text: Report Violations
      location: NamespaceDashboard
      href: https://report
    helplink:
      enabled: false
      text: Red Hat CVE Database
      location: HelpMenu
      href: https://access.redhat.com/security/security-updates/#/cve
    applicationlink:
      enabled: false
      text: Red Hat Subscription Management
      location: ApplicationMenu
      href: https://access.redhat.com/management
      applicationMenu:
        section: My Subscriptions
        imageURL: https://raw.githubusercontent.com/tjungbauer/helm-charts/gh-pages/images/configuration.png

  yamlsamples:
    secret-yaml-sample:
      enabled: false
      targetresource:
        apiversion: v1
        kind: secret
      title: "Secret based on cleartext values"
      descr: "This is an example to create a Secret based on clear-text values"
      yamlDef: |+
            apiVersion: v1
            kind: Secret
            metadata:
              name: example
            type: Opaque
            stringData:
              email: youremail@address.com
              password: YourSuperPassword
```
