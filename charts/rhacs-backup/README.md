

# rhacs-backup

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.3](https://img.shields.io/badge/Version-1.0.3-informational?style=flat-square)

 

  ## Description

  Chart to create a CronJoc to backup Advanced Cluster Security for Kubernetes to a PerstistentVolume.

This Helm Chart installs a CronJob that will periodically create a backup of Advanced Cluster Security. The following objects must be considered:

1. CronJob
2. ServiceAccount to run the CronJob
3. PerstistentVolumeClaim to store the backup
4. Optional PerstistentVolume - if you want to use a specific NFS share

Verify the official documentation: https://docs.openshift.com/acs/4.6/backup_and_restore/backing-up-acs.html

To authenticate against ACS a token with *ADMIN* permissions must be created. This token must be stored in a Kubernetes Secret called rox-backup with the keys:

1. rox_token: Token that is created
2. rox_endpoint: Endpoint of ACS (without https://, but with the port 443)

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.0 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/rhacs-backup

## Parameters

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backup_storage_size | string | `"100Gi"` |  |
| cronjob.annotations | object | {} | Custom annotations that shall be applied to the Cronjob Add required key-value pairs as needed |
| cronjob.image | string | registry.redhat.io/openshift4/ose-cli | Image to use for the CronJob |
| cronjob.name | string | acs-backup | Name of the CronJob |
| cronjob.namespace | string | stackrox | Namespace of the CronJob |
| cronjob.nfs_mountpath | string | `"/acs-backup"` | mount point inside the cronjob pod |
| cronjob.retention | int | `30` |  |
| cronjob.schedule | string | `"0 4 * * *"` | Schedule of the Cronjob, for example: daily at 4am |
| cronjob.syncwave | int | 5 | Syncwave for the CronJob |
| enabled | bool | false | Enable ACS backup. |
| name | string | `"acs-backup"` |  |
| namespace | string | `"stackrox"` |  |
| pv.accessMode | string | ReadWriteOnce | Access mode of the PV |
| pv.annotations | object | {} | Custom annotations that shall be applied to the PV Add required key-value pairs as needed |
| pv.enabled | bool | false | Enable PV creation? |
| pv.name | string | acs-backup | Nmae of the PV |
| pv.path | string | `"<path>"` | Path of the NFS share for example |
| pv.server | string | `"<ip-address>"` | Server address of the NFS share for example |
| pv.size | string | 100Gi | Size of the Storage |
| pv.storageClass | string | `""` | StorageClass must be provided as empty value here, since NFS mount is not provided as storageclass. |
| pv.syncwave | int | 2 | Syncwave for the PV |
| pvc.accessMode | string | ReadWriteOnce | using RWO accessMode, which is usually sufficient |
| pvc.annotations | object | {} | Custom annotations that shall be applied to the PVC Add required key-value pairs as needed |
| pvc.name | string | acs-backup | Name of the PVC |
| pvc.setVolumeName | bool | false | Set the name of the PV, only required if the PV will be created (see below) |
| pvc.size | string | 100Gi | Size of the Storage |
| pvc.storageClass | string | N/A | StorageClass must be provided as empty value here, since NFS mount is not provided as storageclass. |
| pvc.syncwave | int | 5 | Syncwave for the PVC |
| serviceAccount.create | bool | false | Create service account or not |
| serviceAccount.name | string | default | ServiceAccount to run the backup |

## Example

```yaml
---
name: &bu_name acs-backup
backup_storage_size: &backup_storage_size "100Gi"

enabled: true
namespace: stackrox

serviceAccount:
  name: *bu_name
  create: true

# Settings for the CronJob
cronjob:
  name: *bu_name
  schedule: "0 4 * * *"
  retention: 30
  nfs_mountpath: /acs-backup

# Settings for the PVC
pvc:
  # -- Name of the PVC
  # @default -- acs-backup
  name: *bu_name

  # -- Size of the Storage
  # @default -- 100Gi
  size: *backup_storage_size

  # -- StorageClass must be provided as empty value here, since NFS mount is not provided as storageclass.
  # @default -- N/A
  storageClass: "gp3-csi"
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
