

# collection-optional-operators

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.32](https://img.shields.io/badge/Version-1.0.32-informational?style=flat-square)

 

  ## Description

  Collection of optional operators, like CodeReadyWorkspaces without any configuration of a CRD.

This chart can be used to install Operators in OpenShift WITHOUT any additional configuration. Such charts were initially grouped into the purpose of the Operator ... here some additional Operators are deployed.
However, you can install any Operator with this chart. Also, I usually do not use this option of installation operators anymore, since here the chart helper-status-checker is not used.

This chart will create the objects: Namespace, Subscription, OperatorGroup and a Job, that will enable additional console plugins, if enabled.

It is best used with a GitOps approach such as Argo CD does. For example: https://github.com/tjungbauer/openshift-clusterconfig-gitops

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/collection-optional-operators

## Parameters

>> see https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator for a full list of possible parameters.

## Example

Installing the Operator "Loki"

TIP: Fetch the values for the subscription specification with `oc get packagemanifest advanced-cluster-management -o yaml`

```yaml
---
console_plugins:
  enabled: false
  syncwave: 5
  plugins:
    - plugin_name

  job_namespace: kube-system

operators:
  loki-operator:
    enabled: false
    namespace:
      name: openshift-operators-redhat
      create: true
    subscription:
      channel: stable
      approval: Automatic
      operatorName: loki-operator
      source: redhat-operators
      sourceNamespace: openshift-marketplace
      config:
        env:
          - name: FIRST_ENV_PARAMENTER
            value: ThisIsRequierd
          - name: SECOND_ENV_PARAMETER
            value: 'true'
        resources:
          limits:
            cpu: 100m
            memory: 1Gi
          requests:
            cpu: 400m
            memory: 300Mi
        tolerations:
          - effect: NoSchedule
            key: node-role.kubernetes.io/infra
            value: reserved
          - effect: NoExecute
            key: node-role.kubernetes.io/infra
            value: reserved
        nodeSelector:
          key: node-role.kubernetes.io/infra
          value: ""
    operatorgroup:
      create: true
      notownnamespace: true
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
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
