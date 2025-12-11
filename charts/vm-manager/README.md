# vm-manager

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: 4.16](https://img.shields.io/badge/AppVersion-4.16-informational?style=flat-square)

A Helm chart for managing Virtual Machines in OpenShift Virtualization

**Homepage:** <https://github.com/tjungbauer/helm-charts/tree/main/charts/vm-manager>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Source Code

* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://docs.openshift.com/container-platform/latest/virt/>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.23 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dataVolumes.ubuntu-base.contentType | string | `"kubevirt"` |  |
| dataVolumes.ubuntu-base.description | string | `"Ubuntu 22.04 Base Image"` |  |
| dataVolumes.ubuntu-base.enabled | bool | `false` |  |
| dataVolumes.ubuntu-base.pvc.accessModes[0] | string | `"ReadWriteOnce"` |  |
| dataVolumes.ubuntu-base.pvc.size | string | `"20Gi"` |  |
| dataVolumes.ubuntu-base.pvc.storageClassName | string | `"ocs-storagecluster-ceph-rbd"` |  |
| dataVolumes.ubuntu-base.pvc.volumeMode | string | `"Filesystem"` |  |
| dataVolumes.ubuntu-base.source.registry.url | string | `"docker://quay.io/containerdisks/ubuntu:22.04"` |  |
| global.namespace | string | Release namespace | Default namespace for all resources |
| global.sshKeys | list | [] | SSH public keys to be injected into VMs via cloud-init |
| secrets.registry-credentials.enabled | bool | `false` |  |
| secrets.registry-credentials.stringData.".dockerconfigjson" | string | `"{\n  \"auths\": {\n    \"quay.io\": {\n      \"username\": \"user\",\n      \"password\": \"password\",\n      \"auth\": \"dXNlcjpwYXNzd29yZA==\"\n    }\n  }\n}\n"` |  |
| secrets.registry-credentials.type | string | `"kubernetes.io/dockerconfigjson"` |  |
| secrets.vm-ssh-keys.enabled | bool | `true` |  |
| secrets.vm-ssh-keys.stringData.authorized_keys | string | `"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAB... user@example.com\nssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... admin@example.com\n"` |  |
| secrets.vm-ssh-keys.type | string | `"Opaque"` |  |
| services.web-server-svc.enabled | bool | `true` |  |
| services.web-server-svc.ports[0].name | string | `"http"` |  |
| services.web-server-svc.ports[0].nodePort | int | `30080` |  |
| services.web-server-svc.ports[0].port | int | `80` |  |
| services.web-server-svc.ports[0].protocol | string | `"TCP"` |  |
| services.web-server-svc.ports[0].targetPort | int | `80` |  |
| services.web-server-svc.selector."vm.kubevirt.io/name" | string | `"web-server"` |  |
| services.web-server-svc.type | string | `"NodePort"` |  |
| virtualMachineInstances.test-vmi.description | string | `"Test VMI"` |  |
| virtualMachineInstances.test-vmi.disks[0].disk.bus | string | `"virtio"` |  |
| virtualMachineInstances.test-vmi.disks[0].name | string | `"test-disk"` |  |
| virtualMachineInstances.test-vmi.enabled | bool | `false` |  |
| virtualMachineInstances.test-vmi.interfaces[0].masquerade | object | `{}` |  |
| virtualMachineInstances.test-vmi.interfaces[0].name | string | `"default"` |  |
| virtualMachineInstances.test-vmi.networks[0].name | string | `"default"` |  |
| virtualMachineInstances.test-vmi.networks[0].pod | object | `{}` |  |
| virtualMachineInstances.test-vmi.resources.requests.cpu | string | `"500m"` |  |
| virtualMachineInstances.test-vmi.resources.requests.memory | string | `"1Gi"` |  |
| virtualMachineInstances.test-vmi.volumes[0].emptyDisk.capacity | string | `"5Gi"` |  |
| virtualMachineInstances.test-vmi.volumes[0].name | string | `"test-disk"` |  |
| virtualMachines.web-server.annotations | object | `{"vm.kubevirt.io/os":"rhel9"}` | Additional annotations for the VM |
| virtualMachines.web-server.autoattachGraphicsDevice | bool | `true` | Device configuration |
| virtualMachines.web-server.autoattachMemBalloon | bool | `true` |  |
| virtualMachines.web-server.cpu | object | `{"cores":2,"dedicatedCpuPlacement":false,"model":"host-passthrough","sockets":1,"threads":1}` | CPU configuration |
| virtualMachines.web-server.dataVolumeTemplates | list | `[{"name":"web-server-root","pvc":{"accessModes":["ReadWriteOnce"],"size":"30Gi","storageClassName":"ocs-storagecluster-ceph-rbd"},"source":{"registry":{"url":"docker://quay.io/containerdisks/rhel:9-latest"}}}]` | DataVolume templates for this VM |
| virtualMachines.web-server.description | string | `"RHEL 9 Web Server"` | Description of the VM |
| virtualMachines.web-server.disks | list | `[{"bootOrder":1,"disk":{"bus":"virtio"},"name":"root-disk"},{"disk":{"bus":"virtio"},"name":"cloud-init"}]` | Disk configuration |
| virtualMachines.web-server.enabled | bool | false | Enable this Virtual Machine |
| virtualMachines.web-server.evictionStrategy | string | "" | Eviction strategy for the VM Allowed values: None, LiveMigrate, LiveMigrateIfPossible, External |
| virtualMachines.web-server.features | object | `{"acpi":{},"apic":{},"hyperv":{"relaxed":{},"spinlocks":{"spinlocks":8191},"vapic":{}},"smm":{"enabled":true}}` | VM features |
| virtualMachines.web-server.firmware | object | `{"bootloader":{"efi":{"secureBoot":true}}}` | Firmware configuration |
| virtualMachines.web-server.inputs | list | `[{"bus":"usb","name":"tablet","type":"tablet"}]` | Input devices |
| virtualMachines.web-server.interfaces | list | `[{"masquerade":{},"model":"virtio","name":"default"}]` | Network interfaces |
| virtualMachines.web-server.labels | object | `{"app":"web-server","os":"rhel9","tier":"frontend"}` | Additional labels for the VM |
| virtualMachines.web-server.machine | object | `{"type":"pc-q35-rhel9.2.0"}` | Machine type configuration |
| virtualMachines.web-server.memory | object | `{"guest":"2Gi","hugepages":{"pageSize":""}}` | Memory configuration |
| virtualMachines.web-server.namespace | string | global.namespace or Release.Namespace | Namespace for this VM (overrides global namespace) |
| virtualMachines.web-server.networks | list | `[{"name":"default","pod":{}}]` | Network configuration |
| virtualMachines.web-server.nodeSelector | object | `{"node-role.kubernetes.io/worker":""}` | Node selector for VM placement |
| virtualMachines.web-server.priorityClassName | string | `""` | Priority class for VM scheduling |
| virtualMachines.web-server.resources | object | `{"limits":{"cpu":"2","memory":"4Gi"},"requests":{"cpu":"1","memory":"2Gi"}}` | Resource requirements |
| virtualMachines.web-server.runStrategy | string | "" | Run strategy for the VM Allowed values: Always, RerunOnFailure, Manual, Halted |
| virtualMachines.web-server.running | bool | false | VM running state |
| virtualMachines.web-server.tolerations | list | `[{"effect":"NoSchedule","key":"vm-workload","operator":"Equal","value":"true"}]` | Tolerations for VM placement |
| virtualMachines.web-server.volumes | list | `[{"dataVolume":{"name":"web-server-root"},"name":"root-disk"},{"cloudInitNoCloud":{"userData":"#cloud-config\nuser: cloud-user\npassword: changeme\nchpasswd: { expire: False }\nssh_pwauth: True\nssh_authorized_keys:\n  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAB... user@example.com\npackages:\n  - httpd\n  - firewalld\nruncmd:\n  - systemctl enable httpd\n  - systemctl start httpd\n  - systemctl enable firewalld\n  - systemctl start firewalld\n  - firewall-cmd --add-service=http --permanent\n  - firewall-cmd --reload\n  - echo \"<h1>Hello from OpenShift Virtualization!</h1>\" > /var/www/html/index.html\n"},"name":"cloud-init"}]` | Volume configuration |
| virtualMachines.windows-vm.cpu.cores | int | `4` |  |
| virtualMachines.windows-vm.cpu.sockets | int | `1` |  |
| virtualMachines.windows-vm.cpu.threads | int | `1` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[0].name | string | `"windows-vm-disk"` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[0].pvc.accessModes[0] | string | `"ReadWriteOnce"` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[0].pvc.size | string | `"60Gi"` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[0].pvc.storageClassName | string | `"ocs-storagecluster-ceph-rbd"` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[0].source.blank | object | `{}` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[1].name | string | `"virtio-drivers-iso"` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[1].pvc.accessModes[0] | string | `"ReadWriteOnce"` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[1].pvc.size | string | `"1Gi"` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[1].pvc.storageClassName | string | `"ocs-storagecluster-ceph-rbd"` |  |
| virtualMachines.windows-vm.dataVolumeTemplates[1].source.http.url | string | `"https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso"` |  |
| virtualMachines.windows-vm.description | string | `"Windows Server 2022"` |  |
| virtualMachines.windows-vm.disks[0].bootOrder | int | `1` |  |
| virtualMachines.windows-vm.disks[0].disk.bus | string | `"sata"` |  |
| virtualMachines.windows-vm.disks[0].name | string | `"windows-disk"` |  |
| virtualMachines.windows-vm.disks[1].cdrom.bus | string | `"sata"` |  |
| virtualMachines.windows-vm.disks[1].name | string | `"virtio-drivers"` |  |
| virtualMachines.windows-vm.enabled | bool | `false` |  |
| virtualMachines.windows-vm.features.hyperv.relaxed | object | `{}` |  |
| virtualMachines.windows-vm.features.hyperv.spinlocks.spinlocks | int | `8191` |  |
| virtualMachines.windows-vm.features.hyperv.vapic | object | `{}` |  |
| virtualMachines.windows-vm.features.smm.enabled | bool | `true` |  |
| virtualMachines.windows-vm.firmware.bootloader.efi.secureBoot | bool | `false` |  |
| virtualMachines.windows-vm.interfaces[0].bridge | object | `{}` |  |
| virtualMachines.windows-vm.interfaces[0].model | string | `"e1000e"` |  |
| virtualMachines.windows-vm.interfaces[0].name | string | `"default"` |  |
| virtualMachines.windows-vm.labels.app | string | `"windows-server"` |  |
| virtualMachines.windows-vm.labels.os | string | `"windows"` |  |
| virtualMachines.windows-vm.machine.type | string | `"pc-q35-rhel9.2.0"` |  |
| virtualMachines.windows-vm.memory.guest | string | `"4Gi"` |  |
| virtualMachines.windows-vm.networks[0].name | string | `"default"` |  |
| virtualMachines.windows-vm.networks[0].pod | object | `{}` |  |
| virtualMachines.windows-vm.resources.limits.cpu | string | `"4"` |  |
| virtualMachines.windows-vm.resources.limits.memory | string | `"8Gi"` |  |
| virtualMachines.windows-vm.resources.requests.cpu | string | `"2"` |  |
| virtualMachines.windows-vm.resources.requests.memory | string | `"4Gi"` |  |
| virtualMachines.windows-vm.runStrategy | string | `"Manual"` |  |
| virtualMachines.windows-vm.running | bool | `false` |  |
| virtualMachines.windows-vm.volumes[0].dataVolume.name | string | `"windows-vm-disk"` |  |
| virtualMachines.windows-vm.volumes[0].name | string | `"windows-disk"` |  |
| virtualMachines.windows-vm.volumes[1].dataVolume.name | string | `"virtio-drivers-iso"` |  |
| virtualMachines.windows-vm.volumes[1].name | string | `"virtio-drivers"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
