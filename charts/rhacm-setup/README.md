

# rhacm-setup

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.20](https://img.shields.io/badge/Version-1.0.20-informational?style=flat-square)

 

  ## Description

  Setup and configure Advanced Cluster Managerment. Replaces the Chart rhacm-full-stack.

This Helm Chart is installing and configuring Advanced Cluster Management (ACM)

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.22 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (for example in the folder clusters/management-cluster/setup-acm)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <dev@stdin.at> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/rhacm-setup

## Parameters

Verify the subcharts for additional settings:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| helper-operator.operators.advanced-cluster-management.enabled | bool | `false` |  |
| helper-operator.operators.advanced-cluster-management.namespace.create | bool | `true` |  |
| helper-operator.operators.advanced-cluster-management.namespace.name | string | `"open-cluster-management"` |  |
| helper-operator.operators.advanced-cluster-management.operatorgroup.create | bool | `false` |  |
| helper-operator.operators.advanced-cluster-management.operatorgroup.notownnamespace | bool | `false` |  |
| helper-operator.operators.advanced-cluster-management.subscription.approval | string | `"Automatic"` |  |
| helper-operator.operators.advanced-cluster-management.subscription.channel | string | `"release-2.16"` |  |
| helper-operator.operators.advanced-cluster-management.subscription.operatorName | string | `"advanced-cluster-management"` |  |
| helper-operator.operators.advanced-cluster-management.subscription.source | string | `"redhat-operators"` |  |
| helper-operator.operators.advanced-cluster-management.subscription.sourceNamespace | string | `"openshift-marketplace"` |  |
| helper-operator.operators.advanced-cluster-management.syncwave | string | `"0"` |  |
| helper-status-checker.checks[0].namespace.name | string | `"open-cluster-management"` |  |
| helper-status-checker.checks[0].operatorName | string | `"advanced-cluster-management"` |  |
| helper-status-checker.checks[0].serviceAccount.name | string | `"sa-acm-status-checker"` |  |
| helper-status-checker.checks[0].syncwave | int | `3` |  |
| helper-status-checker.enabled | bool | `false` |  |
| override-rhacm-operator-version | string | `"release-2.16"` | Anchor for the operator version |
| rhacm.importClusters | object | `{"addons":{"applicationManager":{"enabled":true},"certPolicyController":{"enabled":true},"iamPolicyController":{"enabled":true},"policyController":{"enabled":true},"searchCollector":{"enabled":true}},"clusters":null,"enabled":false,"klusterlet_addon_syncwave":"10","managed_cluster_syncwave":"5"}` | ManagedCluster + KlusterletAddonConfig when enabled (see templates/rhacm/managedCluster.yaml) This will create a new cluster in the management cluster. However, this will only prepare the cluster, you still need to download and execute the command to fully integrate the new cluster. |
| rhacm.importClusters.addons | object | `{"applicationManager":{"enabled":true},"certPolicyController":{"enabled":true},"iamPolicyController":{"enabled":true},"policyController":{"enabled":true},"searchCollector":{"enabled":true}}` | Klusterlet addon controllers; all default to enabled. Override globally or per cluster via clusters[].addons Per default all addons are enabled. However, you can override this here GLOBALLY |
| rhacm.importClusters.enabled | bool | false | Enable the import of clusters. |
| rhacm.importClusters.klusterlet_addon_syncwave | string | 10 | Syncwave for the KlusterletAddonConfig. MUST be HIGHER than managed_cluster_syncwave |
| rhacm.importClusters.managed_cluster_syncwave | string | 5 | Syncwaves for the ManagedCluster. MUST be LOWER than klusterlet_addon_syncwave |
| rhacm.multiclusterhub.availabilityConfig | string | Basic | Specifies deployment replication for improved availability. Options are: Basic and High |
| rhacm.multiclusterhub.enabled | bool | false | Enable MultiClusterHub object |
| rhacm.multiclusterhub.nodeSelector | object | empty | Specify a nodeSelector for example to move the Pods to infrastructure nodes. |
| rhacm.multiclusterhub.syncwave | string | 3 | Syncwave for the MultiClusterHub |
| rhacm.multiclusterhub.tolerations | list | empty | If you want this component to only run on specific nodes, you can configure tolerations of tainted nodes. |
| rhacm.namespace.name | string | `"open-cluster-management"` |  |
| rhacm.search | object | `{"dbStorage":{"size":"10Gi"},"deployments":{},"enabled":false,"nodeSelector":{"key":"node-role.kubernetes.io/infra","value":""},"syncwave":"15","tolerations":[{"effect":"NoSchedule","key":"storage","operator":"Equal","value":"local"}]}` | Search custom resource (search-v2-operator). See RH ACM 2.16 "Customizing the Search service". https://docs.redhat.com/en/documentation/red_hat_advanced_cluster_management_for_kubernetes/2.16/html/search/acm-search#customize-search-console |
| rhacm.search.dbStorage | object | `{"size":"10Gi"}` | PostgreSQL PVC for search-postgres. Omit entire key (set to null) to let the operator keep defaults (e.g. emptyDir for non-prod). |
| rhacm.search.dbStorage.size | string | 10Gi | Size of the PostgreSQL PVC. |
| rhacm.search.deployments | object | {} | Per-deployment tuning:    collector, indexer, database, queryapi (resources, replicaCount, envVar, arguments). Passed through as YAML. deployments:   collector:     resources:       limits: { cpu: 500m, memory: 128Mi }       requests: { cpu: 250m, memory: 64Mi }   indexer:     replicaCount: 3     resources:       limits: { memory: 5Gi }       requests: { memory: 1Gi }   database:     envVar:       - name: POSTGRESQL_EFFECTIVE_CACHE_SIZE         value: 1024MB       - name: POSTGRESQL_SHARED_BUFFERS         value: 512MB   queryapi:     arguments:       - -v=3 |
| rhacm.search.enabled | bool | false | Enable Search custom resource. |
| rhacm.search.nodeSelector | object | {} | Hub-wide node placement for search pods (maps to spec.nodeSelector). |
| rhacm.search.syncwave | string | `"15"` | Argo CD sync wave; place after MultiClusterHub / search operator is available. |
| rhacm.search.tolerations | list | [] | Hub-wide tolerations for search pods. |
| rhacm.searchCollector | object | false | Search collector add-on: ConfigMap search-collector-config (AllowedResources / DeniedResources). https://docs.redhat.com/en/documentation/red_hat_advanced_cluster_management_for_kubernetes/ |
| rhacm.searchCollector.configMap.allowedResources | object | {} | Structured rules; rendered as YAML under ConfigMap data keys AllowedResources / DeniedResources. |
| rhacm.searchCollector.configMap.enabled | bool | false | Enable Search collector add-on. |
| rhacm.searchCollector.configMap.namespace | string | open-cluster-management-agent | Namespace where the klusterlet search-collector runs. |
| rhacm.searchCollector.configMap.syncwave | string | 20 | Syncwave for the ConfigMap. |

## Example values

```yaml
---
---
# -- Anchor for the operator version
override-rhacm-operator-version: &rhacmversion release-2.10

# Install Operator RHACM
# Deploys Operator --> Subscription and Operatorgroup
# Syncwave: 0
helper-operator:
  operators:
    advanced-cluster-management:
      enabled: false
      syncwave: '0'
      namespace:
        name: open-cluster-management
        create: true
      subscription:
        channel: *rhacmversion
        approval: Automatic
        operatorName: advanced-cluster-management
        source: redhat-operators
        sourceNamespace: openshift-marketplace
      operatorgroup:
        create: false
        notownnamespace: false

# Using sub-chart helper-status-checker
helper-status-checker:
  enabled: false

  checks:

    - operatorName: advanced-cluster-management
      namespace:
        name: open-cluster-management
      syncwave: 3

      serviceAccount:
        name: "sa-acm-status-checker"

rhacm:
  namespace:
    name: open-cluster-management

  # Configure MultiClusterHub
  multiclusterhub:
    enabled: false
    availabilityConfig: Basic
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
