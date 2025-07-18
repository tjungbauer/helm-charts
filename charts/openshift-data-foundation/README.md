

# openshift-data-foundation

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.35](https://img.shields.io/badge/Version-1.0.35-informational?style=flat-square)

 

  ## Description

  Deploys and configures the OpenShift Data Foundation Operator.

This Helm Chart is installing and configuring OpenShift Data Foundation, using the following workflow:

1. Create required Namespace
2. Installing the ODF operator by applying the Subscription and OperatorGroup object. (In addition, the InstallPlan can be approved if required)
3. Verifying if the operator is ready to use Install and configure the compliance operator.
4. Apply the required storage configuration.

Two options are possible. You can either configure the full ODF feature set including block, file and S3 storage based on Ceph or you deploy the MultiCloudGateway only, which provides just object storage.
This is the easiest option to quickly provide S3 storage for example for Quay, Logging etc.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | helper-operator | ~1.0.36 |
| https://charts.stderr.at/ | helper-status-checker | ~4.0.0 |
| https://charts.stderr.at/ | tpl | ~1.0.22 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (folder: clusters/management-cluster/setup-openshift-data-foundation)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/openshift-data-foundation

## Parameters

Verify the subcharts for additional settings:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| helper-operator.operators.odf-operator.enabled | bool | `false` |  |
| helper-operator.operators.odf-operator.namespace.create | bool | `false` |  |
| helper-operator.operators.odf-operator.namespace.name | string | `"openshift-storage"` |  |
| helper-operator.operators.odf-operator.operatorgroup.create | bool | `true` |  |
| helper-operator.operators.odf-operator.subscription.approval | string | `"Automatic"` |  |
| helper-operator.operators.odf-operator.subscription.channel | string | `"stable-4.14"` |  |
| helper-operator.operators.odf-operator.subscription.operatorName | string | `"odf-operator"` |  |
| helper-operator.operators.odf-operator.subscription.source | string | `"redhat-operators"` |  |
| helper-operator.operators.odf-operator.subscription.sourceNamespace | string | `"openshift-marketplace"` |  |
| helper-operator.operators.odf-operator.syncwave | string | `"0"` |  |
| helper-status-checker.checks[0].namespace.name | string | `"openshift-storage"` |  |
| helper-status-checker.checks[0].operatorName | string | `"odf-operator"` |  |
| helper-status-checker.checks[0].serviceAccount.name | string | `"status-checker-odf"` |  |
| helper-status-checker.checks[0].syncwave | int | `3` |  |
| helper-status-checker.enabled | bool | `false` |  |
| storagecluster.enabled | bool | false | Enable or disable StorageCluster |
| storagecluster.full_deployment | object | `{"default_node_label":"cluster.ocs.openshift.io/openshift-storage","enabled":false,"nfs":"enabled","resourceProfile":"balanced","storageDeviceSets":[{"count":1,"dataPVCTemplate":{"spec":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"512Gi"}},"storageClassName":"gp3-csi","volumeMode":"Block"}},"name":"ocs-deviceset","replica":3,"resources":{}}]}` | Second option is a full deployment, which will provide Block, File and Object Storage |
| storagecluster.full_deployment.default_node_label | string | cluster.ocs.openshift.io/openshift-storage | The label the nodes should have to allow hosting of ODF services |
| storagecluster.full_deployment.enabled | bool | false | Enable full deployment of ODF (incl. Ceph, S3 etc.) |
| storagecluster.full_deployment.nfs | string | false | Enable NFS or not |
| storagecluster.full_deployment.resourceProfile | string | balanced | In the Configure performance. The following profiles are available: <br /> <ul> <li>lean (24 CPU, 72GiB): Use this in a resource constrained environment with minimum resources that are lower than the recommended. This profile minimizes resource consumption by allocating fewer CPUs and less memory.</li> <li>balanced (30 CPU, 72 GiB, default): Use this when recommended resources are available. This profile provides a balance between resource consumption and performance for diverse workloads.</li> <li>performance (45 CPU, 96 GiB): Use this in an environment with sufficient resources to get the best performance. This profile is tailored for high performance by allocating ample memory and CPUs to ensure optimal execution of demanding workloads.</li> </ul> <br /> |
| storagecluster.full_deployment.storageDeviceSets | list | `[{"count":1,"dataPVCTemplate":{"spec":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"512Gi"}},"storageClassName":"gp3-csi","volumeMode":"Block"}},"name":"ocs-deviceset","replica":3,"resources":{}}]` | Define the storage deviceSets |
| storagecluster.full_deployment.storageDeviceSets[0] | object | `{"count":1,"dataPVCTemplate":{"spec":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"512Gi"}},"storageClassName":"gp3-csi","volumeMode":"Block"}},"name":"ocs-deviceset","replica":3,"resources":{}}` | Name of the DeviceSet |
| storagecluster.full_deployment.storageDeviceSets[0].count | int | 1 | Count is the number of devices in each StorageClassDeviceSet |
| storagecluster.full_deployment.storageDeviceSets[0].dataPVCTemplate | object | `{"spec":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"512Gi"}},"storageClassName":"gp3-csi","volumeMode":"Block"}}` | Definitions of the PVC Template |
| storagecluster.full_deployment.storageDeviceSets[0].dataPVCTemplate.spec.accessModes | list | `["ReadWriteOnce"]` | Default AccessModes @efault -- ReadWriteOnce |
| storagecluster.full_deployment.storageDeviceSets[0].dataPVCTemplate.spec.resources | object | 512Gi | Size of the Storage. Might be 512Gi, 2Ti, 4Ti |
| storagecluster.full_deployment.storageDeviceSets[0].dataPVCTemplate.spec.storageClassName | string | `"gp3-csi"` | Name of the stroageclass The class must exist upfront and is currently not created by this chart. |
| storagecluster.full_deployment.storageDeviceSets[0].dataPVCTemplate.spec.volumeMode | string | Block | volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec. |
| storagecluster.full_deployment.storageDeviceSets[0].replica | int | 3 | Replicas |
| storagecluster.full_deployment.storageDeviceSets[0].resources | object | '' | Resources for the DeviceSets Pods. Limits and Requests can be defined Usually not required to define, only set when you know what you are doing. |
| storagecluster.multigateway_only | object | `{"enabled":false,"storageclass":"gp3-csi"}` | There are two options: Either install the MultiCloudGateway only. This is useful if you just need S3 for Quay registry for example or do a full deployment. |
| storagecluster.multigateway_only.enabled | bool | false | Enable MultiCloudGateway only. This will only install S3 but not the full Ceph storage. |
| storagecluster.multigateway_only.storageclass | string | `"gp3-csi"` | Name of the storageclass The class must exist upfront and is currently not created by this chart. |
| storagecluster.syncwave | int | 3 | Syncwave for the StorageCluster object. |

## Example #1 - MultiCloudGateway only

```yaml
---
###########################
# Enable and configura ODF
###########################
storagecluster:
  enabled: false
  multigateway_only:
    enabled: false
    storageclass: gp3-csi

# Install Operator Compliance Operator
# Deploys Operator --> Subscription and Operatorgroup
# Syncwave: 0
helper-operator:
  operators:
    odf-operator:
      enabled: true
      syncwave: '0'
      namespace:
        name: openshift-storage
        create: true
      subscription:
        channel: stable-4.14
        approval: Automatic
        operatorName: odf-operator
        source: redhat-operators
        sourceNamespace: openshift-marketplace
      operatorgroup:
        create: true

helper-status-checker:
  enabled: true

  checks:

    - operatorName: odf-operator
      namespace:
        name: openshift-storage
      syncwave: 3

      serviceAccount:
        name: "status-checker-odf"
```

## Example #2 - Full deployment

```yaml
---
---
###########################
# Enable and configura ODF
###########################
storagecluster:
  enabled: false

  full_deployment:

    enabled: false
    nfs: enabled
    default_node_label: cluster.ocs.openshift.io/openshift-storage

    storageDeviceSets:
      - name: ocs-deviceset
        dataPVCTemplate:
          spec:
            accessModes:
              - ReadWriteOnce
            resources:
              requests:
                storage: 512Gi
            storageClassName: gp3-csi
        replica: 3

    # Resource settings for the different components.
    # ONLY set this if you know what you are doing.
    # For every component Limits and Requests can be set.

    # For testing request settings might be reduced.
    # compontent_resources:
      # MDS Defaults
      #   Limits: cpu 3, memory: 8Gi
      #   Requests: cpu: 1, memory: 8Gi
      # mds:
      #   requests:
      #     cpu: '1'
      #     memory: 8Gi

      # RGW Defaults
      #   Limits: cpu 2, memory: 4Gi
      #   Requests: cpu: 1, memory: 4Gi
      # rgw: ...
      # rgw:
      #   requests:
      #     cpu: '1'
      #     memory: 4Gi

      # MON Defaults
      #   Limits: cpu 2, memory: 4Gi
      #   Requests: cpu: 1, memory: 4Gi
      # mon: ...

      # MGR Defaults
      #   Limits: cpu 2, memory: 4Gi
      #   Requests: cpu: 1, memory: 4Gi
      # mgr: ...

      # NOOBAA-CORE Defaults
      #   Limits: cpu 2, memory: 4Gi
      #   Requests: cpu: 1, memory: 4Gi
      # moobaa-core: ...

      # NOOBAA-DB Defaults
      #   Limits: cpu 2, memory: 4Gi
      #   Requests: cpu: 1, memory: 4Gi
      # moobaa-DB: ...

# Install Operator Compliance Operator
# Deploys Operator --> Subscription and Operatorgroup
# Syncwave: 0
helper-operator:
  operators:
    odf-operator:
      enabled: false
      syncwave: '0'
      namespace:
        name: openshift-storage
        create: false
      subscription:
        channel: stable-4.14
        approval: Automatic
        operatorName: odf-operator
        source: redhat-operators
        sourceNamespace: openshift-marketplace
      operatorgroup:
        create: true

helper-status-checker:
  enabled: false

  checks:

    - operatorName: odf-operator
      namespace:
        name: openshift-storage
      syncwave: 3

      serviceAccount:
        name: "status-checker-odf"

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
