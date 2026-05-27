

# kube-descheduler

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)

 

  ## Description

  Setup and configure the Kube Descheduler Operator to evict pods based on specific strategies

This chart renders the cluster-scoped `KubeDescheduler` custom resource (`operator.openshift.io/v1`) in `openshift-kube-descheduler-operator`. It configures descheduling interval, mode, logging, strategy profiles, optional profile customizations, and eviction limits.

The OpenShift Descheduler Operator must already be installed (OLM package `cluster-kube-descheduler-operator`). This chart does not deploy the operator or its subscription.

Use `mode: Predictive` to simulate evictions before switching to `Automatic`. Invalid values for `mode`, `logLevel`, `operatorLogLevel`, `profiles`, and the `dev*` threshold fields fail at `helm template` / install time.

Operator reference: https://github.com/openshift/cluster-kube-descheduler-operator

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.27 |

Typical use is GitOps (for example Argo CD) together with a separate chart or manifest that installs the operator.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <dev@stdin.at> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/openshift-descheduler

## Parameters

* [tpl](https://github.com/tjungbauer/helm-charts/tree/main/charts/tpl) — shared labels and annotations helpers

## Values

### namespace

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| descheduler.additionalAnnotations | object | {} | Additional labels to add to the Keycloak instance as key: value pairs. |
| descheduler.additionalLabels | object | {} | Additional labels to add to the Keycloak instance as key: value pairs. |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| descheduler.deschedulingIntervalSeconds | int | 3600 | The descheduling interval in seconds. Sets the number of seconds between descheduler runs. |
| descheduler.enabled | bool | false | Enable or disable the KubeDescheduler CR creation |
| descheduler.evictionLimits | string | {} | Eviction limits to restrict the number of evictions during each descheduling run |
| descheduler.logLevel | string | Normal | Log level for the descheduler component (operand). Valid values: Normal, Debug, Trace, TraceAll |
| descheduler.mode | string | Predictive | Descheduling mode. Mode configures the descheduler to either evict pods (Automatic) or to simulate the eviction (Predictive) Valid values:   - Predictive: The descheduler only simulates eviction (default)   - Automatic: The descheduler actively evicts pods |
| descheduler.operatorLogLevel | string | Normal | Log level for the descheduler operator. Valid values: Normal, Debug, Trace, TraceAll |
| descheduler.profileCustomizations | object | {} | Profile customizations to modify default behavior of certain profiles |
| descheduler.profileCustomizations.namespaces | object | {} | Namespace configuration for all strategies |
| descheduler.profileCustomizations.namespaces.excluded | list | [] | List of namespaces to exclude from descheduling |
| descheduler.profileCustomizations.namespaces.included | list | [] | List of namespaces to include (cannot include protected namespaces: kube-system, hypershift, and openshift-* prefixed namespaces) |
| descheduler.profiles | list | [] | List of descheduler profiles to enable. Multiple profiles can be combined. Available profiles:   - AffinityAndTaints: Evicts pods violating node/pod affinity and node taints   - TopologyAndDuplicates: Balances pod distribution based on topology constraints   - SoftTopologyAndDuplicates: Same as TopologyAndDuplicates but includes soft constraints   - LifecycleAndUtilization: Focuses on pod lifecycles and node resource consumption   - LongLifecycle: Similar to LifecycleAndUtilization but without 24h pod lifetime eviction   - CompactAndScale: Evicts pods to enable workload consolidation on fewer nodes   - KubeVirtRelieveAndMigrate: Optimized for KubeVirt workloads with live migration support   - EvictPodsWithPVC: Allows eviction of pods with PVCs (use with other profiles)   - EvictPodsWithLocalStorage: Allows eviction of pods with local storage |
| descheduler.syncwave | int | 10 | Syncwave for Argo CD |

## Example values

```yaml
---
descheduler:
  enabled: true
  syncwave: 10

  deschedulingIntervalSeconds: 3600
  mode: Predictive
  logLevel: Normal
  operatorLogLevel: Normal

  profiles:
    - AffinityAndTaints
    - LifecycleAndUtilization

  profileCustomizations:
    namespaces:
      excluded:
        - openshift-monitoring

  # evictionLimits:
  #   total: 10
  #   node: 2
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
