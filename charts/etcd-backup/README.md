

# etcd-backup

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.7](https://img.shields.io/badge/Version-1.0.7-informational?style=flat-square)

 

  ## Description

  Create a CronJob that performs ETCD Backup and stores the backup to a PV.

This Helm Chart can be used to create a backup of ETCD.
It will execute a CronJob on one of the control planes in order to dump ETCD and store it to a PV.

**WARNING**: In order to be able to create such a backup, this CronJob must be able to start a *PRIVILEGED* pod.

**CAUTION**: The backup contains two files: the etcd DB and a tar.gz. If etcd is encrypted, then the tar.gz will contain the keys to decrypt the DB. It is up to the storage team to be sure that the access to the share is secure.
(Maybe in the future I can extend the Chart ... or just create a pull request :) )

The following objects/settings will be created:

1. Namespace: where will the cronjob be scheduled. (Default etcd-backup)
2. ClusterRole: a dedicated Role that allows to get/list nodes and start a Debug pod.
3. ServiceAccount: The ServiceAccount the CronJob will use (Default etcd-backup).
4. ClusterRoleBinding: A binding that binds the ServiceAccount to the ClusterRole.
5. ClusterRoleBinding-Privileged: A binding that binds the ServiceAccount to the SCC system:openshift:scc:privileged.
6. PersistentVolumeClaim: The Claim to the Storage where the backup will be stored.
7. Optional: PersistentVolume: A dedicated PV, used by the PVC. This is optional and might be automatically created, depending on the StorageClass.
8. CronJob: The actual CronJob starts a Debug Pod to execute the backup script.

## CronJob Workflow

The CronJob will perform the following:

1. It will start a debug pod **on one of the Control Planes** (The CronJob is scheduled on one of the Control Planes).
2. Via the Debug pod, on the Control Plane it will execute the script **/usr/local/bin/cluster-backup.sh** and store it into **/home/core/backup** (on the Control Plane).
3. Then a target folder might be created, if it does not exist yet using configured mountpath and the name of the cluster.
4. The backup files are moved from /host/home/core/backup/* (This is the backup location from the CronJob point of view) to the target folder.
5. To save some space, the files will be zipped.
6. Finally, backup files that are older than the **retention** time (default 30 days) will be removed from the target folder and from the Control Plane.

## Verify the backup

The fole **POD_ManualBackupCheck.yaml** contains an example pod, that could be used to verify the backup.
Per default, the backup is stored in the mounted PVC at **etcd-backup**. When you open a terminal to that Pod you can verify the backups:

```bash
sh-4.4# ls -la /etcd-backup/ocp/
total 73080
drwxrwxrwx. 2 root root     4096 Mar 17 05:50 .
drwxr-xr-x. 4 root root     4096 Mar 17 05:42 ..
-rw-------. 1 root root 24996317 Mar 17 05:48 snapshot_2024-03-17_054810.db.gz
-rw-------. 1 root root 24922192 Mar 17 05:49 snapshot_2024-03-17_054903.db.gz
-rw-------. 1 root root 24657038 Mar 17 05:50 snapshot_2024-03-17_055004.db.gz
-rw-------. 1 root root    78022 Mar 17 05:48 static_kuberesources_2024-03-17_054810.tar.gz
-rw-------. 1 root root    78022 Mar 17 05:49 static_kuberesources_2024-03-17_054903.tar.gz
-rw-------. 1 root root    78022 Mar 17 05:50 static_kuberesources_2024-03-17_055004.tar.gz
```

**CAUTION**: The backup contains two files: the etcd DB and a tar.gz. If etcd is encrypted, then the tar.gz will contain the keys to decrypt the DB. It is up to the storage team to be sure that the access to the share is secure.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.0 |

This chart has no dependencies on other charts.

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (folder clusters/all/etcd-backup)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/etcd-backup

## Parameters

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backup_storage_size | string | `"100Gi"` |  |
| clusterrolebindingPrivileged_name | string | etcd-backup-scc-privileged | Name of the PRIVILEGED cluster role binding |
| clusterrolebinding_name | string | `"etcd-backup"` | Name of the cluster role binding |
| clusterrolename | string | cluster-etcd-backup | Name of the cluster role |
| cronjob.image | string | registry.redhat.io/openshift4/ose-cli | Image to use for the CronJob |
| cronjob.mountpath | string | `"/etcd-backup"` | mount point inside the cronjob pod |
| cronjob.name | string | etcd-backup | Name of the CronJob |
| cronjob.retention | int | `30` |  |
| cronjob.schedule | string | `"0 */4 * * *"` | Schedule of the Cronjob, for example: Every 4 hours |
| enabled | bool | false | Enable ETCD backup. |
| name | string | `"etcd-backup"` |  |
| namespace.create | bool | false | Create the Namespace? |
| namespace.description | string | "Openshift Backup Automation Tool" | Description of the Namespace |
| namespace.displayname | string | "Backup ETCD Automation" | DisplayName of the Namespace |
| namespace.name | string | etcd-backup | Name of the Namespace |
| pv.accessMode | string | ReadWriteOnce | Access mode of the PV |
| pv.enabled | bool | false | Enable PV creation? |
| pv.name | string | etcd-backup | Nmae of the PV |
| pv.path | string | `"<path>"` | Path of the NFS share for example |
| pv.server | string | `"<ip-address>"` | Server address of the NFS share for example |
| pv.size | string | 100Gi | Size of the Storage |
| pv.storageClass | string | `"gp3-csi"` | StorageClass must be provided as empty value here, since NFS mount is not provided as storageclass. |
| pvc.accessMode | string | ReadWriteOnce | using RWO accessMode, which is usually sufficient |
| pvc.name | string | etcd-backup | Name of the PVC |
| pvc.setVolumeName | bool | false | Set the name of the PV, only required if the PV will be created (see below) |
| pvc.size | string | 100Gi | Size of the Storage |
| pvc.storageClass | string | `"gp3-csi"` | StorageClass must be provided as empty value here, since NFS mount is not provided as storageclass. |
| pvc.volumeName | string | etcd-backup | Name of the PV |
| serviceAccount | string | etcd-backup | Name of the ServiceAccount |

## Example values

```yaml
---
name: &bu_name etcd-backup
backup_storage_size: &backup_storage_size "100Gi"

enabled: true
clusterrolebinding_name: *bu_name

# Variables for the Namespace where ETCD backup shall be executed.
namespace:
  create: true
  name: *bu_name
  displayname: "Backup ETCD Automation"
  description: "Openshift Backup Automation Tool"
serviceAccount: *bu_name

cronjob:
  name: *bu_name
  # Every 4 hours
  schedule: "0 */4 * * *"
  # How long shall I keep the backups
  retention: 30
  # mount point inside the cronjob pod
  mountpath: /etcd-backup

pvc:
  name: *bu_name
  # using RWO accessMode, which is usually sufficient
  accessMode: "ReadWriteOnce"
  size: *backup_storage_size
  # If not StorageClass is provided (might be because NFS and the PV must be created first, then still use this parameter as storageClass: ""
  storageClass: "gp3-csi"
  # name of the PV
  setVolumeName: false
  volumeName: *bu_name
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
