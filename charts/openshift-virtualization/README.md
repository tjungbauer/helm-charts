

# openshift-virtualization

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)

 

  ## Description

  Configure the operator Openshift Virtualization (HyperConverged and HostPath Provisioner)

This Helm Chart is configuring OpenShift Virtualization Operator.
This means is is responsible to configure HyperConverged and HostPathProvisioner resources.

It does not create new VMs and template configurations. Moreover, additional Operators, such as NMState Operator, might be required for your whole setup.
It can be used be the built in database, or an example and hardcoded postgres instance, or with your very own configuration.

NOTE: This is an evolving chart. I am trying to cover most settings, but especially the HyperConverged resource is quite big. If you miss any setting, please let me know or create a PR.

Be sure to follow the documentation for additional settings, supported features and more at, for example: https://docs.redhat.com/

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.23 |

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

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/openshift-virtualization

## Parameters

Verify the subcharts for additional settings:

* [tpl](https://github.com/tjungbauer/helm-charts/tree/main/charts/tpl)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| hostPathProvisioner.additionalAnnotations | object | {} | Additional annotations to add to the HostPathProvisioner resource |
| hostPathProvisioner.additionalLabels | object | {} | Additional labels to add to the HostPathProvisioner resource |
| hostPathProvisioner.enabled | bool | false | Enable HostPathProvisioner for local storage provisioning |
| hostPathProvisioner.featureGates | list | [] | Feature gates for HostPathProvisioner |
| hostPathProvisioner.imagePullPolicy | string | IfNotPresent | Image pull policy for HostPathProvisioner containers Allowed values: Always, IfNotPresent, Never |
| hostPathProvisioner.name | string | hostpath-provisioner | Name of the HostPathProvisioner resource |
| hostPathProvisioner.namespace | string | openshift-cnv | Namespace where HostPathProvisioner is installed |
| hostPathProvisioner.pathConfig | object | `{"path":"/var/hpvolumes","useNamingPrefix":false}` | PathConfig describes the location and layout of PV storage on nodes. Deprecated |
| hostPathProvisioner.pathConfig.path | string | /var/hpvolumes | The path the directories for the PVs are created under Must be an absolute path starting with '/' |
| hostPathProvisioner.pathConfig.useNamingPrefix | bool | false | Use the name of the PVC requesting the PV as part of the directory created |
| hostPathProvisioner.storagePool | list | [] | Storage pool configuration for the provisioner Can be either a string for simple configuration or a list for advanced configuration with PVC templates |
| hostPathProvisioner.storagePool[0] | object | "local" | Name specifies an identifier that is used in the storage class arguments to identify the source to use. |
| hostPathProvisioner.storagePool[0].path | string | "/var/hpvolumes" | the path to use on the host, this is a required field |
| hostPathProvisioner.storagePool[0].pvcTemplate | object | {} | PVCTemplate is the template of the PVC to create as the source volume |
| hostPathProvisioner.storagePool[0].pvcTemplate.accessModes | list | [] | accessModes contains the desired access modes the volume should have. |
| hostPathProvisioner.storagePool[0].pvcTemplate.dataSource | object | {} | dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. When the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef, and dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified. If the namespace is specified, then dataSourceRef will not be copied to dataSource. |
| hostPathProvisioner.storagePool[0].pvcTemplate.dataSourceRef | object | {} | dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the dataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, when namespace isn't specified in dataSourceRef, both fields (dataSource and dataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. When namespace is specified in dataSourceRef, dataSource isn't set to the same value and must be empty. There are three important differences between dataSource and dataSourceRef: * While dataSource only allows two specific types of objects, dataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While dataSource ignores disallowed values (dropping them), dataSourceRef preserves all values, and generates an error if a disallowed value is specified. * While dataSource only allows local objects, dataSourceRef allows objects in any namespaces. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled. (Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled. |
| hostPathProvisioner.storagePool[0].pvcTemplate.resources | object | requests.storage: 50Gi | resources contains the desired resources the volume should have. |
| hostPathProvisioner.storagePool[0].pvcTemplate.selector | object | {} | selector is a label query over volumes to consider for binding. |
| hostPathProvisioner.storagePool[0].pvcTemplate.storageClassName | string | "" | storageClassName is the name of the StorageClass required by the claim. |
| hostPathProvisioner.storagePool[0].pvcTemplate.volumeAttributesClassName | string | "" | volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim. |
| hostPathProvisioner.storagePool[0].pvcTemplate.volumeMode | string | "" | volumeMode defines what type of volume is required by the claim. |
| hostPathProvisioner.storagePool[0].pvcTemplate.volumeName | string | "" | volumeName is the binding reference to the PersistentVolume backing this claim. |
| hostPathProvisioner.workload | object | `{"affinity":{},"nodeSelector":{},"tolerations":[]}` | Workload placement configuration for HostPathProvisioner pods |
| hostPathProvisioner.workload.affinity | object | {} | Affinity rules for HostPathProvisioner pods |
| hostPathProvisioner.workload.nodeSelector | object | {} | Node selector for HostPathProvisioner pods |
| hostPathProvisioner.workload.tolerations | list | [] | Tolerations for HostPathProvisioner pods |
| virtualization.additionalAnnotations | object | {} | Additional annotations to add to the HyperConverged resource |
| virtualization.additionalLabels | object | {} | Additional labels to add to the HyperConverged resource |
| virtualization.applicationAwareConfig | object | {} | ApplicationAwareConfig set the AAQ configurations |
| virtualization.applicationAwareConfig.allowApplicationAwareClusterResourceQuota | bool | false | AllowApplicationAwareClusterResourceQuota if set to true, allows creation and management of ClusterAppsResourceQuota |
| virtualization.applicationAwareConfig.namespaceSelector | object | {} | NamespaceSelector determines in which namespaces scheduling gate will be added to pods.. |
| virtualization.applicationAwareConfig.vmiCalcConfigName | string | "" | VmiCalcConfigName determine how resource allocation will be done with ApplicationsResourceQuota. Allowed values: VmiPodUsage, VirtualResources, DedicatedVirtualResources or IgnoreVmiCalculator |
| virtualization.certConfig | object | `{"ca":{"duration":"48h0m0s","renewBefore":"24h0m0s"},"server":{"duration":"24h0m0s","renewBefore":"12h0m0s"}}` | certConfig holds the rotation policy for internal, self-signed certificates |
| virtualization.certConfig.ca | object | `{"duration":"48h0m0s","renewBefore":"24h0m0s"}` | Certificate Authority configuration |
| virtualization.certConfig.ca.duration | string | 48h0m0s | CA certificate duration |
| virtualization.certConfig.ca.renewBefore | string | 24h0m0s | CA certificate renewal time before expiry |
| virtualization.certConfig.server | object | `{"duration":"24h0m0s","renewBefore":"12h0m0s"}` | Server certificate configuration |
| virtualization.certConfig.server.duration | string | 24h0m0s | Server certificate duration |
| virtualization.certConfig.server.renewBefore | string | 12h0m0s | Server certificate renewal time before expiry |
| virtualization.commonBootImageNamespace | string | "" | commonBootImageNamespaceCommonBootImageNamespace override the default namespace of the common boot images, in order to hide them. If not set, HCO won't set any namespace, letting SSP to use the default. If set, use the namespace to create the DataImportCronTemplates and the common image streams, with this namespace. This field is not set by default. |
| virtualization.commonInstancetypesDeployment | string | true | CommonInstancetypesDeployment holds the configuration of common-instancetypes deployment within KubeVirt. Enabled controls the deployment of common-instancetypes resources, defaults to True. |
| virtualization.commonTemplatesNamespace | string | "openshift" | User can specify namespace in which common templates will be deployed. This will override default openshift namespace. |
| virtualization.defaultCPUModel | string | "" | defines a cluster default for CPU model: default CPU model is set when VMI doesn't have any CPU model. |
| virtualization.defaultRuntimeClass | string | "" | DefaultRuntimeClass defines a cluster default for the RuntimeClass to be used for VMIs pods if not set there. Default RuntimeClass can be changed when kubevirt is running, existing VMIs are not impacted till the next restart/live-migration when they are eventually going to consume the new default RuntimeClass. |
| virtualization.deployOVS | bool | false | OvS Opt-In Label - Controls whether Open vSwitch (OvS) Container Network Interface (CNI) is deployed |
| virtualization.enabled | bool | false | Enable OpenShift Virtualization (CNV) configuration. This will configure the HyperConverged resource. |
| virtualization.evictionStrategy | string | "" | EvictionStrategy defines at the cluster level if the VirtualMachineInstance should be<br /> migrated instead of shut-off in case of a node drain. If the VirtualMachineInstance specific<br /> field is set it overrides the cluster level one.<br /> Allowed values:<br /> <ul>  <li>`None` no eviction strategy at cluster level.</li>  <li>`LiveMigrate` migrate the VM on eviction; a not live migratable VM with no specific strategy will block the drain of the node util manually evicted.</li>  <li>`LiveMigrateIfPossible` migrate the VM on eviction if live migration is possible, otherwise directly evict.</li>  <li>`External` block the drain, track eviction and notify an external controller.</li> </ul> Defaults to LiveMigrate with multiple worker nodes, None on single worker clusters. |
| virtualization.featureGates | object | `{"alignCPUs":false,"autoResourceLimits":false,"deployKubeSecondaryDNS":false,"deployVmConsoleProxy":true,"disableMDevConfiguration":false,"downwardMetrics":false,"enableApplicationAwareQuota":false,"enableCommonBootImageImport":true,"persistentReservation":false}` | Feature gates for OpenShift Virtualization |
| virtualization.featureGates.alignCPUs | bool | false | Set the alignCPUs feature gate to enable KubeVirt to request up to two additional dedicated CPUs in order to complete the total CPU count to an even parity when using emulator thread isolation. |
| virtualization.featureGates.autoResourceLimits | bool | false | Enable KubeVirt to set automatic limits when they are needed. If ResourceQuota with set memory limits is associated with a namespace, each pod in that namespace must have memory limits set. By default, KubeVirt does not set such limits to the virt-launcher pod. |
| virtualization.featureGates.deployKubeSecondaryDNS | bool | false | Set the deployKubeSecondaryDNS feature gate to true to allow deploying KubeSecondaryDNS by CNAO. |
| virtualization.featureGates.deployVmConsoleProxy | bool | true | Deploy VM Console Proxy for remote console access. |
| virtualization.featureGates.disableMDevConfiguration | bool | false | Disable mediated device configuration |
| virtualization.featureGates.downwardMetrics | bool | false | Set the downwardMetrics feature gate in order to allow exposing a limited set of VM and host metrics to the guest. |
| virtualization.featureGates.enableApplicationAwareQuota | bool | false | EnableApplicationAwareQuota if true, enables the Application Aware Quota feature |
| virtualization.featureGates.enableCommonBootImageImport | bool | true | Enable common boot image import from external registries<br /> Opt-in to automatic delivery/updates of the common data import cron templates. There are two sources for the data import cron templates: hard coded list of common templates, and custom templates that can be added to the dataImportCronTemplates field. This feature gates only control the common templates. It is possible to use custom templates by adding them to the dataImportCronTemplates field. |
| virtualization.featureGates.persistentReservation | bool | false | Snable persistent reservation of a LUN through the SCSI Persistent Reserve commands on Kubevirt. In order to issue privileged SCSI ioctls, the VM requires activation of the persistent reservation flag. |
| virtualization.higherWorkloadDensity | object | `{"memoryOvercommitPercentage":100}` | HigherWorkloadDensity holds configurataion aimed to increase virtual machine density |
| virtualization.higherWorkloadDensity.memoryOvercommitPercentage | int | 100 | MemoryOvercommitPercentage is the percentage of memory we want to give VMIs compared to the amount given to its parent pod (virt-launcher). For example, a value of 102 means the VMI will "see" 2% more memory than its parent pod. Values under 100 are effectively "undercommits". Overcommits can lead to memory exhaustion, which in turn can lead to crashes. Use carefully. |
| virtualization.infra | object | `{"nodePlacement":{"affinity":{},"nodeSelector":{},"tolerations":[]}}` | infra HyperConvergedConfig influences the pod configuration (currently only placement) for all the infra components needed on the virtualization enabled cluster but not necessarily directly on each node running VMs/VMIs. |
| virtualization.infra.nodePlacement | object | `{"affinity":{},"nodeSelector":{},"tolerations":[]}` | NodePlacement describes node scheduling configuration. |
| virtualization.infra.nodePlacement.affinity | object | {} | affinity enables pod affinity/anti-affinity placement expanding the types of constraints that can be expressed with nodeSelector. affinity is going to be applied to the relevant kind of pods in parallel with nodeSelector |
| virtualization.infra.nodePlacement.nodeSelector | object | {} | Node selector for infrastructure components |
| virtualization.infra.nodePlacement.tolerations | list | [] | Tolerations for infrastructure components |
| virtualization.kubeSecondaryDNSNameServerIP | string | "" | KubeSecondaryDNSNameServerIP defines name server IP used by KubeSecondaryDNS |
| virtualization.liveMigrationConfig | object | `{"allowAutoConverge":false,"allowPostCopy":false,"bandwidthPerMigration":"","completionTimeoutPerGiB":150,"network":"","parallelMigrationsPerCluster":5,"parallelOutboundMigrationsPerNode":2,"progressTimeout":150}` | Live migration limits and timeouts are applied so that migration processes do not overwhelm the cluster. |
| virtualization.liveMigrationConfig.allowAutoConverge | bool | false | AllowAutoConverge allows the platform to compromise performance/availability of VMIs to guarantee successful VMI live migrations. Defaults to false |
| virtualization.liveMigrationConfig.allowPostCopy | bool | false | When enabled, KubeVirt attempts to use post-copy live-migration in case it reaches its completion timeout while attempting pre-copy live-migration. Post-copy migrations allow even the busiest VMs to successfully live-migrate. However, events like a network failure or a failure in any of the source or destination nodes can cause the migrated VM to crash or reach inconsistency. Enable this option when evicting nodes is more important than keeping VMs alive. |
| virtualization.liveMigrationConfig.bandwidthPerMigration | string | "" | Bandwidth limit of each migration, the value is quantity of bytes per second (e.g. 2048Mi = 2048MiB/sec) |
| virtualization.liveMigrationConfig.completionTimeoutPerGiB | int | 150 | Completion timeout per GiB of VM memory (seconds) If a migrating VM is big and busy, while the connection to the destination node is slow, migration may never converge. The completion timeout is calculated based on completionTimeoutPerGiB times the size of the guest (both RAM and migrated disks, if any). For example, with completionTimeoutPerGiB set to 800, a virtual machine instance with 6GiB memory will timeout if it has not completed migration in 1h20m. Use a lower completionTimeoutPerGiB to induce quicker failure, so that another destination or post-copy is attempted. Use a higher completionTimeoutPerGiB to let workload with spikes in its memory dirty rate to converge. |
| virtualization.liveMigrationConfig.network | string | "" | The migrations will be performed over a dedicated multus network to minimize disruption to tenant workloads due to network saturation when VM live migrations are triggered. |
| virtualization.liveMigrationConfig.parallelMigrationsPerCluster | int | 5 | Maximum parallel migrations per cluster |
| virtualization.liveMigrationConfig.parallelOutboundMigrationsPerNode | int | 2 | Maximum parallel outbound migrations per node |
| virtualization.liveMigrationConfig.progressTimeout | int | 150 | Progress timeout for migration (seconds) |
| virtualization.mediatedDevicesConfiguration | object | {} | MediatedDevicesConfiguration holds information about MDEV types to be defined on nodes, if available |
| virtualization.mediatedDevicesConfiguration.mediatedDeviceTypes | list | [] | List of mediated device types to be created on all nodes |
| virtualization.mediatedDevicesConfiguration.nodeMediatedDeviceTypes | list | [] | Configure mediated device types for specific nodes using node selectors |
| virtualization.name | string | kubevirt-hyperconverged | Name of the HyperConverged resource |
| virtualization.namespace | string | openshift-cnv | Namespace where OpenShift Virtualization is installed |
| virtualization.permittedHostDevices | object | {} | PermittedHostDevices defines the host devices that are permitted for use by VMs. |
| virtualization.resourceRequirements | object | `{"autoCPULimitNamespaceLabelSelector":{},"vmiCPUAllocationRatio":10}` | ResourceRequirements describes the resource requirements for the operand workloads. |
| virtualization.resourceRequirements.autoCPULimitNamespaceLabelSelector | object | {} | When set, AutoCPULimitNamespaceLabelSelector will set a CPU limit on virt-launcher for VMIs running inside namespaces that match the label selector. The CPU limit will equal the number of requested vCPUs. This setting does not apply to VMIs with dedicated CPUs. |
| virtualization.resourceRequirements.vmiCPUAllocationRatio | int | 10 | VmiCPUAllocationRatio defines, for each requested virtual CPU, how much physical CPU to request per VMI from the hosting node. The value is in fraction of a CPU thread (or core on non-hyperthreaded nodes). VMI POD CPU request = number of vCPUs * 1/vmiCPUAllocationRatio For example, a value of 1 means 1 physical CPU thread per VMI CPU thread. A value of 100 would be 1% of a physical thread allocated for each requested VMI thread. This option has no effect on VMIs that request dedicated CPUs. Defaults to 10 |
| virtualization.scratchSpaceStorageClass | string | "" | Override the storage class used for scratch space during transfer operations. The scratch space storage class is determined in the following order: value of scratchSpaceStorageClass, if that doesn't exist, use the default storage class, if there is no default storage class, use the storage class of the DataVolume, if no storage class specified, use no storage class for scratch space |
| virtualization.storageImport | object | `{"insecureRegistries":[]}` | StorageImport contains configuration for importing containerized data. |
| virtualization.storageImport.insecureRegistries | list | [] | InsecureRegistries is a list of image registries URLs that are not secured. Setting an insecure registry URL in this list allows pulling images from this registry. |
| virtualization.tlsSecurityProfile | object | {} | TLSSecurityProfile specifies the settings for TLS connections to be propagated to all kubevirt-hyperconverged components. If unset, the hyperconverged cluster operator will consume the value set on the APIServer CR on OCP/OKD or Intermediate if on vanilla k8s. Note that only Old, Intermediate and Custom profiles are currently supported, and the maximum available MinTLSVersions is VersionTLS12. |
| virtualization.tlsSecurityProfile.custom.ciphers | list | [] | ciphers is used to specify the cipher algorithms that are negotiated during the TLS handshake. Operators may remove entries their operands do not support. For example, to use DES-CBC3-SHA |
| virtualization.tlsSecurityProfile.custom.minTLSVersion | string | "" | minTLSVersion is used to specify the minimal version of the TLS protocol that is negotiated during the TLS handshake. For example, to use TLS VersionTLS10, VersionTLS11, VersionTLS12, VersionTLS13 NOTE: currently the highest minTLSVersion allowed is VersionTLS12 |
| virtualization.tlsSecurityProfile.type | string | "Intermediate" | type is one of Old, Intermediate, Modern or Custom. Custom provides the ability to specify individual TLS security profile parameters. Allowed values: Old, Intermediate, Modern, Custom |
| virtualization.tuningPolicy | string | "" | TuningPolicy allows to configure the mode in which the RateLimits of kubevirt are set. If TuningPolicy is not present the default kubevirt values are used. It can be set to `annotation` for fine-tuning the kubevirt queryPerSeconds (qps) and burst values. Qps and burst values are taken from the annotation hco.kubevirt.io/tuningPolicy <br> Can either me: empty, annotation or highBurst |
| virtualization.uninstallStrategy | string | "BlockUninstallIfWorkloadsExist" | UninstallStrategy defines how to proceed on uninstall when workloads (VirtualMachines, DataVolumes) still exist. <br /> BlockUninstallIfWorkloadsExist will prevent the CR from being removed when workloads still exist.<br /> BlockUninstallIfWorkloadsExist is the safest choice to protect your workloads from accidental data loss, so it's strongly advised.<br /> RemoveWorkloads will cause all the workloads to be cascading deleted on uninstallation.<br /> WARNING: please notice that RemoveWorkloads will cause your workloads to be deleted as soon as this CR will be, even accidentally, deleted.<br /> Please correctly consider the implications of this option before setting it.<br /> BlockUninstallIfWorkloadsExist is the default behaviour.<br /> |
| virtualization.virtualMachineOptions | object | `{"disableFreePageReporting":false,"disableSerialConsoleLog":true}` | VirtualMachineOptions holds the cluster level information regarding the virtual machine. |
| virtualization.virtualMachineOptions.disableFreePageReporting | bool | false | DisableFreePageReporting disable the free page reporting of memory balloon device https://libvirt.org/formatdomain.html#memory-balloon-device. This will have effect only if AutoattachMemBalloon is not false and the vmi is not requesting any high performance feature (dedicatedCPU/realtime/hugePages), in which free page reporting is always disabled. |
| virtualization.virtualMachineOptions.disableSerialConsoleLog | bool | true | DisableSerialConsoleLog disables logging the auto-attached default serial console. If not set, serial console logs will be written to a file and then streamed from a container named `guest-console-log`. The value can be individually overridden for each VM, not relevant if AutoattachSerialConsole is disabled for the VM. |
| virtualization.vmStateStorageClass | string | "" | VMStateStorageClass is the name of the storage class to use for the PVCs created to preserve VM state, like TPM. The storage class must support RWX in filesystem mode. |
| virtualization.workloadUpdateStrategy | object | `{"batchEvictionInterval":"1m0s","batchEvictionSize":10,"workloadUpdateMethods":[]}` | WorkloadUpdateStrategy defines at the cluster level how to handle automated workload updates |
| virtualization.workloadUpdateStrategy.batchEvictionInterval | string | 1m0s | BatchEvictionInterval Represents the interval to wait before issuing the next batch of shutdowns |
| virtualization.workloadUpdateStrategy.batchEvictionSize | int | 10 | BatchEvictionSize Represents the number of VMIs that can be forced updated per the BatchShutdownInterval interval |
| virtualization.workloadUpdateStrategy.workloadUpdateMethods | list | [] | WorkloadUpdateMethods defines the methods that can be used to disrupt workloads during automated workload updates. When multiple methods are present, the least disruptive method takes precedence over more disruptive methods. For example if both LiveMigrate and Evict methods are listed, only VMs which are not live migratable will be restarted/shutdown. An empty list defaults to no automated workload updating. |
| virtualization.workloads.nodePlacement.affinity | object | {} | Affinity rules for VM workloads |
| virtualization.workloads.nodePlacement.nodeSelector | object | {} | Node selector for VM workloads |
| virtualization.workloads.nodePlacement.tolerations | list | [] | Tolerations for VM workloads |

## Example settings

```yaml
---
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
