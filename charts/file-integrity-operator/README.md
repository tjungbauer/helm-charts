

# file-integrity-operator

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.15](https://img.shields.io/badge/Version-1.0.15-informational?style=flat-square)

 

  ## Description

  Setup the FileIntegrity Operator (based on AIDE)

This Helm Chart is installing and configuring the File Integrity Operator, which uses AIDE to check if any files have been changed
on the operating system.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.31 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (for example in the folder clusters/management-cluster/setup-file-integrity-operator)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <dev@stdin.at> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/file-integrity-operator

## Worker vs control plane FileIntegrity CRs

The chart can deploy **two independent** `FileIntegrity` custom resources—one for worker nodes and one for control plane nodes. Configure them under `aide.worker` and `aide.controlplane`; each block is disabled by default and can be enabled separately.

Each CR is backed by a daemon set that runs AIDE on nodes matching that CR’s scheduling rules. The chart renders Argo CD sync metadata via `tpl.argocdMetadata`, optional `additionalAnnotations` / `additionalLabels` on each resource, and `spec.tolerations` from values. The control plane block can also attach metadata to the chart-managed `controlplane-aide-conf` ConfigMap (`aide.controlplane.config.customconfig`).

| Setting | Worker (`aide.worker`) | Control plane (`aide.controlplane`) |
| --- | --- | --- |
| Default `enabled` | `false` | `false` |
| `FileIntegrity` name | `worker-fileintegrity` | `controlplane-fileintegrity` |
| Argo CD sync-wave | `5` | `10` |
| Intended node role (`selector` / `nodeSelector`) | `node-role.kubernetes.io/worker` | `node-role.kubernetes.io/master` |
| `tolerations` | `node-role.kubernetes.io/worker` (Exists / NoSchedule) | `node-role.kubernetes.io/master` (Exists / NoSchedule) |
| Custom AIDE config (`config.customconfig`) | `enabled: false` — operator default config | `enabled: true` — references `controlplane-aide-conf` |
| Extra chart objects | none | `ConfigMap` `controlplane-aide-conf` (sync-wave `2`) with control-plane–specific AIDE rules |

**Control plane AIDE config:** When `aide.controlplane.config.customconfig.enabled` is `true` and the name is `controlplane-aide-conf`, the chart creates a `ConfigMap` whose rules focus on paths relevant to control plane nodes (for example `/hostroot/etc/kubernetes`), with excludes for static pod resources, manifests, kubelet CA material, machine-config-daemon transient files, and similar high-churn locations. Worker scans use the File Integrity Operator’s default configuration unless you enable `customconfig` and supply your own `ConfigMap`.

**Compact clusters:** On nodes that carry both worker and control plane labels, enabling **both** CRs can schedule overlapping AIDE daemon sets on the same nodes. For single-node or compact topologies, prefer one `FileIntegrity` CR whose node selector targets each node once, or enable only the block that matches your layout. See the [File Integrity Operator documentation](https://docs.openshift.com/container-platform/latest/security/file_integrity_operator/file-integrity-operator-understanding.html).

## Parameters

Verify the subcharts for additional settings:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aide.controlplane.additionalAnnotations | object | {} | Additional annotations on the FileIntegrity CR (merged with Argo CD sync metadata via tpl.argocdMetadata). |
| aide.controlplane.additionalLabels | object | {} | Additional labels on the FileIntegrity CR. |
| aide.controlplane.config | object | `{"customconfig":{"additionalAnnotations":{},"additionalLabels":{},"enabled":true,"key":"controlplane-aide.conf","name":"controlplane-aide-conf","namespace":"openshift-file-integrity","syncwave":2},"gracePeriod":900,"maxBackups":5}` | FileIntegrity configuration |
| aide.controlplane.config.customconfig | object | `{"additionalAnnotations":{},"additionalLabels":{},"enabled":true,"key":"controlplane-aide.conf","name":"controlplane-aide-conf","namespace":"openshift-file-integrity","syncwave":2}` | Enable a custom configuration. This is usefull for control planes. If not defined a configuration will be created. |
| aide.controlplane.config.customconfig.additionalAnnotations | object | {} | Additional annotations on the control plane AIDE ConfigMap (merged with Argo CD sync metadata via tpl.argocdMetadata). |
| aide.controlplane.config.customconfig.additionalLabels | object | {} | Additional labels on the control plane AIDE ConfigMap. |
| aide.controlplane.config.customconfig.enabled | bool | false | Enable custom configuration |
| aide.controlplane.config.customconfig.key | string | `"controlplane-aide.conf"` | The key that contains the actual AIDE configuration in a configmap specified by Name and Namespace. Defaults to aide.conf |
| aide.controlplane.config.customconfig.namespace | string | `"openshift-file-integrity"` | Namespace of a configMap that contains custom AIDE configuration. A default configuration would be created if omitted. |
| aide.controlplane.config.customconfig.syncwave | int | 2 | Sync-wave when the chart-created control plane AIDE ConfigMap is applied. |
| aide.controlplane.config.gracePeriod | int | 900 | Time between individual aide scans |
| aide.controlplane.config.maxBackups | int | 5 | The maximum number of AIDE database and log backups (leftover from the re-init process) to keep on a node. Older backups beyond this number are automatically pruned by the daemon. |
| aide.controlplane.enabled | bool | false | Enable worker node fileintegrity check |
| aide.controlplane.name | string | `"controlplane-fileintegrity"` | Name of this object |
| aide.controlplane.namespace | string | `"openshift-file-integrity"` | Namespace, typically openshift-file-integrity |
| aide.controlplane.selector | object | `{"key":"node-role.kubernetes.io/master","value":""}` | nodeSelector as key/value |
| aide.controlplane.syncwave | int | `10` | Syncwave when this object is created |
| aide.controlplane.tolerations | list | empty | If you want this component to only run on specific nodes, you can configure tolerations of tainted nodes. |
| aide.worker.additionalAnnotations | object | {} | Additional annotations on the FileIntegrity CR (merged with Argo CD sync metadata via tpl.argocdMetadata). |
| aide.worker.additionalLabels | object | {} | Additional labels on the FileIntegrity CR. |
| aide.worker.config | object | `{"customconfig":{"enabled":false},"gracePeriod":900,"maxBackups":5}` | FileIntegrity configuration |
| aide.worker.config.customconfig | object | `{"enabled":false}` | Enable a custom configuration. This is usefull for control planes. If not defined a configuration will be created. |
| aide.worker.config.customconfig.enabled | bool | false | Enable custom configuration |
| aide.worker.config.gracePeriod | int | 900 | Time between individual aide scans |
| aide.worker.config.maxBackups | int | 5 | The maximum number of AIDE database and log backups (leftover from the re-init process) to keep on a node. Older backups beyond this number are automatically pruned by the daemon. |
| aide.worker.enabled | bool | false | Enable worker node fileintegrity check |
| aide.worker.name | string | `"worker-fileintegrity"` | Name of this object |
| aide.worker.namespace | string | `"openshift-file-integrity"` | Namespace, typically openshift-file-integrity |
| aide.worker.nodeSelector.key | string | `"node-role.kubernetes.io/worker"` |  |
| aide.worker.nodeSelector.value | string | `""` |  |
| aide.worker.selector | object | `{"key":"node-role.kubernetes.io/worker","value":""}` | nodeSelector as key/value |
| aide.worker.syncwave | int | `5` | Syncwave when this object is created |
| aide.worker.tolerations | list | empty | If you want this component to only run on specific nodes, you can configure tolerations of tainted nodes. |

## Example values

```yaml
---
# Deploy operator using helper-operator sub chart
helper-operator:
  operators:
    file-integrity-operator:
      enabled: true
      syncwave: '0'
      namespace:
        name: openshift-file-integrity
        create: true
      subscription:
        channel: stable
        approval: Automatic
        operatorName: file-integrity-operator
        source: redhat-operators
        sourceNamespace: openshift-marketplace
      operatorgroup:
        create: true
        notownnamespace: true

# Verify if operator has been deployed using helper-status-checker sub-chart
helper-status-checker:
  enabled: false

  checks:

    - operatorName: file-integrity-operator
      namespace:
        name: openshift-file-integrity
      syncwave: 3

      serviceAccount:
        name: "sa-file-integrity-checker"

aide:
  worker:
    enabled: true
    syncwave: 5
    name: worker-fileintegrity
    namespace: openshift-file-integrity
    selector:
      key: node-role.kubernetes.io/worker
      value: ""

    config:
      gracePeriod: 900
      maxBackups: 5

  controlplane:
    enabled: false
    syncwave: 10
    name: controlplane-fileintegrity
    namespace: openshift-file-integrity
    selector:
      key: node-role.kubernetes.io/master
      value: ""

    config:
      gracePeriod: 900
      maxBackups: 5

      customconfig:
        enabled: true
        name: controlplane-aide-conf
        namespace: openshift-file-integrity
        key: "controlplane-aide.conf"

    tolerations:
      - effect: NoSchedule
        key: node-role.kubernetes.io/master
        operator: Exists
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
