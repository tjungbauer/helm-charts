[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install Operator OpenShift Data Foundation

This simply installs OpenShift Data Foundation (ODF) Operator and validates the status of the installation. 
It uses the Subchart: 

* helper-operator: to create the required Operator resources
* helper-status-checker: to verify of the Deployments of this Operator are running. 

It is best used with a GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-cluster-bootstrap

## TL;DR 

```console
helm repo add --force-update tjungbauer https://charts.stderr.at
helm repo update
```

## Prerequisites

* Kubernetes 1.12+
* Helm 3

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release tjungbauer/openshift-data-foundation
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Example

```yaml
---
---
###########################
# Enable and configura ODF
###########################
storagecluster:
  enabled: true

  # There are two options:
  # Either install the multigateway only. This is useful if you just need S3 for Quay registry for example.
  multigateway_only:
    enabled: false

    # Name of the stroageclass
    # The class must exist upfront and is currently not created by this chart.
    storageclass: gp3-csi
    
  # Second option is a full deployment, which will provide Block, File and Object Storage  
  full_deployment:
    enabled: true

    # Enable NFS or not
    nfs: enabled
    
    # The label the nodes should have to allow hosting of ODF services
    # Default: cluster.ocs.openshift.io/openshift-storage
    # default_node_label: cluster.ocs.openshift.io/openshift-storage

    # Define the DeviceSets
    storageDeviceSets:
        # Name of the DeviceSet
      - name: ocs-deviceset
        # Resources for the DeviceSets Pods.
        # Limits and Requests can be defined
        # Default:
        #   Limit: cpu: 1, memory: 5Gi
        #   Requests: cpu: 1, memory: 5Gi
        resources:
          requests:
            cpu: '1'
            memory: 5Gi

        # Definitions of the PVC Template
        dataPVCTemplate:
          spec:
            # Default AccessModes
            # Default: ReadWriteOnce
            # accessModes:
            #   - ReadWriteOnce

            # Size of the Storage. Might be 512Gi, 2Ti, 4Ti
            # Default: 512Gi
            resources:
              requests:
                storage: 512Gi
            
            # Name of the stroageclass
            # The class must exist upfront and is currently not created by this chart.
            storageClassName: gp3-csi

      # Replicas: Default 3
      # replica: 3

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

helper-operator:
  operators:
    odf-operator:
      enabled: true
      syncwave: '0'
      namespace:
        name: openshift-storage
        create: true
      subscription:
        channel: stable-4.10
        approval: Automatic
        operatorName: odf-operator
        source: redhat-operators
        sourceNamespace: openshift-marketplace
      operatorgroup:
        create: true

helper-status-checker:
  enabled: true

  # space separate list of deployments which shall be checked for status
  deployments: "ocs-operator odf-console odf-operator-controller-manager ocs-metrics-exporter noobaa-operator csi-addons-controller-manager"

  wait_time: 60  # wait time in seconds for the check-job to verify when the deployments should be ready

  namespace:
    name: openshift-storage

  serviceAccount:
    create: true
    name: "status-checker"
```
