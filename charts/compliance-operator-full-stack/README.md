

# compliance-operator-full-stack

  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.22](https://img.shields.io/badge/Version-1.0.22-informational?style=flat-square)

 

  ## Description

  Master chart to deploy and configure the Compliance Operator

This Helm Chart is installing and configuring the Compliance operator, using the following workflow:

1. Create required Namespace
2. Installing the Compliance operator by applying the Subscription and Operatorgroup object. (In addition, the InstallPlan can be approved if required)
3. Verifying if the operator is ready to use Install and configure the compliance operator.
4. Apply a ScanSettingBinding and, optionally, a TailoredProfile.

## Dependencies

This charts has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | helper-operator | ~1.0.21 |
| https://charts.stderr.at/ | helper-status-checker | ~3.0.0 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> |  |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/compliance-operator-full-stack

## Parameters

:bulb: **TIP**: See README files of sub Charts for additional possible settings: [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator) and [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator).

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| compliance.namespace.descr | string | `"Red Hat Compliance"` |  |
| compliance.namespace.name | string | `"openshift-compliance"` |  |
| compliance.namespace.syncwave | string | `"0"` |  |
| compliance.scansettingbinding.enabled | bool | `false` |  |
| compliance.scansettingbinding.profiles[0].kind | string | `"Profile"` |  |
| compliance.scansettingbinding.profiles[0].name | string | `"ocp4-cis-node"` |  |
| compliance.scansettingbinding.profiles[1].kind | string | `"Profile"` |  |
| compliance.scansettingbinding.profiles[1].name | string | `"ocp4-cis"` |  |
| compliance.scansettingbinding.scansetting | string | `"default"` |  |
| compliance.scansettingbinding.syncwave | string | `"3"` |  |
| compliance.scansettingbinding.tailored.enabled | bool | `false` |  |
| compliance.scansettingbinding.tailored.modified_profiles[0].description | string | `"Modified ocp4-cis profile"` |  |
| compliance.scansettingbinding.tailored.modified_profiles[0].disableRule[0].name | string | `"ocp4-scc-limit-container-allowed-capabilities"` |  |
| compliance.scansettingbinding.tailored.modified_profiles[0].disableRule[0].rationale | string | `"Disabling CIS-OCP 5.2.8 that will always be triggered as long nutanix-csi does not provide SCC configuration"` |  |
| compliance.scansettingbinding.tailored.modified_profiles[0].extends | string | `"ocp4-cis"` |  |
| compliance.scansettingbinding.tailored.modified_profiles[0].name | string | `"tailoredprofile-ocp4-cis"` |  |
| compliance.scansettingbinding.tailored.modified_profiles[0].title | string | `"Tailored Profile of ocp4-cis"` |  |
| helper-operator.operators.compliance-operator.enabled | bool | false | Enabled yes/no |
| helper-operator.operators.compliance-operator.namespace.create | bool | "" | Description of the namespace. |
| helper-operator.operators.compliance-operator.namespace.name | string | `"openshift-compliance"` | The Namespace the Operator should be installed in. The compliance operator should be deployed into **openshift-compliance** Namepsace that must be created. |
| helper-operator.operators.compliance-operator.operatorgroup.create | bool | false | Create an Operatorgroup object |
| helper-operator.operators.compliance-operator.operatorgroup.notownnamespace | bool | false | Monitor own Namespace. For some Operators no `targetNamespaces` must be defined |
| helper-operator.operators.compliance-operator.subscription.approval | string | Automatic | Update behavior of the Operator. Manual/Automatic |
| helper-operator.operators.compliance-operator.subscription.channel | string | stable | Channel of the Subscription |
| helper-operator.operators.compliance-operator.subscription.operatorName | string | "empty" | Name of the Operator |
| helper-operator.operators.compliance-operator.subscription.source | string | redhat-operators | Source of the Operator |
| helper-operator.operators.compliance-operator.subscription.sourceNamespace | string | openshift-marketplace | Namespace of the source |
| helper-operator.operators.compliance-operator.syncwave | string | 0 | Syncwave for the operator deployment |
| helper-status-checker.enabled | bool | false | Enable status checker |
| helper-status-checker.namespace | object | "" | Define where the operator is installed For the compliance operator this should be "**openshift-compliance**" |
| helper-status-checker.operatorName | string | "" | Define the name of the operator that shall be verified.  Use the value of the currentCSV (packagemanifest) but WITHOUT the version !! For the compliance operator the name should be "**compliance-operator**" |
| helper-status-checker.serviceAccount | object | `{"create":true,"name":"sa-compliance"}` | Set the values of the ServiceAccount that will execute the status checker Job. |

## Example values

```yaml
---
# Install Operator Compliance Operator
# Deploys Operator --> Subscription and Operatorgroup
# Syncwave: 0
helper-operator:
  operators:
    compliance-operator:
      enabled: true
      syncwave: '0'
      namespace:
        name: openshift-compliance
        create: true
      subscription:
        channel: stable
        approval: Automatic
        operatorName: compliance-operator
        source: redhat-operators
        sourceNamespace: openshift-marketplace
      operatorgroup:
        create: true
        notownnamespace: true

helper-status-checker:
  enabled: true

  # use the value of the currentCSV (packagemanifest) but WITHOUT the version !!
  operatorName: compliance-operator

  # where operator is installed
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

    # Example
    tailored:
      enabled: false
      modified_profiles:
      - name: tailoredprofile-ocp4-cis
        description: Modified ocp4-cis profile
        title: Tailored Profile of ocp4-cis
        extends: ocp4-cis
        disableRule:
        - name: ocp4-scc-limit-container-allowed-capabilities
          rationale: Disabling CIS-OCP 5.2.8 that will always be triggered as long nutanix-csi does not provide SCC configuration

    profiles:
      - name: ocp4-cis-node
        kind: Profile  # Could be Profile or TailedProfile
      - name: ocp4-cis
        kind: Profile
    scansetting: default

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
