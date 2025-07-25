

# minio-configurator

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.8](https://img.shields.io/badge/Version-1.0.8-informational?style=flat-square)

 

  ## Description

  A Chart to automate the bucket creation and configuration for MINIO Object Storage

This Chart is based on the [Bitnami Minio Chart](https://github.com/bitnami/charts/tree/main/bitnami/minio). Without Bitnami I would not have been able to create this Helm Chart.

Unlike Bitnami's chart, which does a full deployment of Minio including the configuration of the Buckets, 
I wanted to create a small and quick chart, that focuses on the bucket configuration only. Therefore, I forked the original chart, cleaned it up, streamlined it a little bit and 
added some additional features, like Bucket replication and the option to ignore the TLS certificate etc. 

It should help to overcome the requirement that manual configurations are required before gitops can perform certain steps.
The main use cases are:

- create a bucket
- configure the bucket (ie. quota or lifecycle)
- create a user 
- create a policy and assign it to the user
- enable bucket replication

To achieve this, a provisioning Job is created in order to use an MC command line tool

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/minio-configurator

## Parameters

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| provisioning.enabled | bool | `false` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `"minio-provisioner"` |  |

## Example

```yaml
# -- Name of the resources (unlike Bitnami I am not using any templating here)
# @default -- ""
name: minio-provisioner

# -- Namespace where the provisioner should be scheduled
# @default -- ""
namespace: minio-operator

# -- Argo CD Sync wave for the Minio provisioner
# @default -- 5
synwave: 5

argoproj:
  # -- Argo CD Hook phase
  # @default -- Sync
  hook: Sync

  # -- Argo CD delete policy for the hook
  # @default -- HookSucceeded
  hook_delete_policy: HookSucceeded

image:
  # -- Specifies the image (by Bitnami) that contains the mc command line tool
  url: docker.io/bitnami/minio:2024.5.1-debian-12-r0

  # -- Pull policy for the image. Can be Always or IfNotPresent
  # @default -- Always
  pullPolicy: IfNotPresent

  # -- Optional List of pull secrets for the image
  # @default -- []
  pullSecrets: []

# Parameters for authentication
auth:
  # -- Mount credentials as a files instead of using an environment variable.
  # @default -- false
  useCredentialsFiles: true

  # -- Name of the Secret that contains the access to Minio
  # Must contain root-password and root-user
  # @default -- ''
  secretName: minio-provisioner

# -- Skip TLS verification for Minio. This set the variable MC_INSECURE to true
# Can be used when you are using self-signed certificates for example.
# @default -- false
skip_tls_verification: true

# TLS Settings
tls:
  # -- Enable tls in front of the container
  enabled: true

  # -- The mount path where the secret will be located
  # Custom mount path where the certificates will be located, if empty will default to /certs
  # @default -- ""
  mountPath: ""

  # -- Name of the Secret that contains the TLS information
  # @default -- ""
  secretName: ""

# Actual bucket configuration
provisioning:
  # -- Enable Bucket provisioning
  # @default -- false
  enabled: false

  # -- Optionally specify extra list of additional commands for provisioning
  # @default -- []
  extraCommands: []

  # -- Optionall define resource for the provisioner pod.
  # Simply define typical resources, like limits.cpu; requests.memory etc.
  # @default -- {}
  resources: {}

  # -- Policies provisioning <br />
  # https://docs.min.io/docs/minio-admin-complete-guide.html#policy
  # e.g.
  # policies:
  #   - name: custom-bucket-specific-policy
  #     statements:
  #       - resources:
  #           - "arn:aws:s3:::my-bucket"
  #         actions:
  #           - "s3:GetBucketLocation"
  #           - "s3:ListBucket"
  #           - "s3:ListBucketMultipartUploads"
  #       - resources:
  #           - "arn:aws:s3:::my-bucket/*"
  #         # Allowed values: "Allow" | "Deny"
  #         # Defaults to "Deny" if not specified
  #         effect: "Allow"
  #         actions:
  #           - "s3:AbortMultipartUpload"
  #           - "s3:DeleteObject"
  #           - "s3:GetObject"
  #           - "s3:ListMultipartUploadParts"
  #           - "s3:PutObject"
  # @default -- []
  policies: []

  # -- Users provisioning. Can be used in addition to provisioning.usersExistingSecrets.
  # e.g.
  # users:
  #   - username: test-username
  #     password: test-password
  #     disabled: false
  #     policies:
  #       - readwrite
  #       - consoleAdmin
  #       - diagnostics
  #     # When set to true, it will replace all policies with the specified.
  #     # When false, the policies will be added to the existing.
  #     setPolicies: false
  # @default -- []
  users: []

  # -- Instead of configuring users inside values.yaml, referring to existing Kubernetes secrets containing user configurations is possible.
  # e.g.
  # usersExistingSecrets:
  #   - centralized-minio-users
  #
  # All provided Kubernetes secrets require a specific data structure. The same data from the provisioning.users example above
  #  can be defined via secrets with the following data structure. The secret keys have no meaning to the provisioning job         except that
  # they are used as filenames.
  #   ## apiVersion: v1
  #   ## kind: Secret
  #   ## metadata:
  #   ##   name: centralized-minio-users
  #   ## type: Opaque
  #   ## stringData:
  #   ##   username1: |
  #   ##     username=test-username
  #   ##     password=test-password
  #   ##     disabled=false
  #   ##     policies=readwrite,consoleAdmin,diagnostics
  #   ##     setPolicies=false
  # @default -- []
  usersExistingSecrets: []

  # -- Provisioning.groups 
  # e.g.
  # groups
  #   - name: test-group
  #     disabled: false
  #     members:
  #       - test-username
  #     policies:
  #       - readwrite
  #     # When set to true, it will replace all policies with the specified.
  #     # When false, the policies will be added to the existing.
  #     setPolicies: false
  # @default -- []
  groups: []

  # -- buckets, versioning, lifecycle, quota and tags provisioning
  # Buckets https://docs.min.io/docs/minio-client-complete-guide.html#mb
  # Lifecycle https://docs.min.io/docs/minio-client-complete-guide.html#ilm
  # Quotas https://docs.min.io/docs/minio-admin-complete-guide.html#bucket
  # Tags https://docs.min.io/docs/minio-client-complete-guide.html#tag
  # Versioning https://docs.min.io/docs/minio-client-complete-guide.html#version
  # e.g.
  # buckets:
  #   - name: test-bucket
  #     region: us-east-1
  #     # Only when mode is 'distributed'
  #     # Allowed values: "Versioned" | "Suspended" | "Unchanged"
  #     # Defaults to "Suspended" if not specified.
  #     # For compatibility, accepts boolean values as well, where true maps
  #     # to "Versioned" and false to "Suspended".
  #     # ref: https://docs.minio.io/docs/distributed-minio-quickstart-guide
  #     versioning: Suspended
  #     # Versioning is automatically enabled if withLock is true
  #     # ref: https://docs.min.io/docs/minio-bucket-versioning-guide.html
  #     withLock: true
  #     # Only when mode is 'distributed'
  #     # ref: https://docs.minio.io/docs/distributed-minio-quickstart-guide
  #     lifecycle:
  #       - id: TestPrefix7dRetention
  #         prefix: test-prefix
  #         disabled: false
  #         expiry:
  #           days: 7
  #           deleteMarker: false
  #           # Days !OR! date
  #           # date: "2021-11-11T00:00:00Z"
  #           nonconcurrentDays: 3
  #      bucketReplication:
  #        enabled: true
  #        targetClusterUrl: name of the target cluster
  #        targetClusterPort: 443
  #        targetBucket: name of the target bucket
  #        replicationSettings:
  #           - existing-objects
  #        credSecretName: secret that contains the keys: username and password to authenticate at the target cluster
  #     # Only when mode is 'distributed'
  #     # ref: https://docs.minio.io/docs/distributed-minio-quickstart-guide
  #     quota:
  #       # set (hard still works as an alias but is deprecated) or clear(+ omit size)
  #       type: set
  #       size: 10GiB
  #     tags:
  #       key1: value1
  # @default -- ''
  buckets:
    - testbucket

  # Config provisioning
  # e.g.
  # config:
  #   - name: region
  #     options:
  #       name: us-east-1  
  # @default -- []
  config: []

  # -- Automatic Cleanup for Finished Jobs
  # @param provisioning.cleanupAfterFinished.enabled Enables Cleanup for Finished Jobs
  # @param provisioning.cleanupAfterFinished.seconds Sets the value of ttlSecondsAfterFinished
  # ref: https://kubernetes.io/docs/concepts/workloads/controllers/ttlafterfinished/
  # @default -- disabled
  cleanupAfterFinished:
    enabled: false
    seconds: 600

  # -- Tolerations for the provisioning Pod
  # @default -- []
  tolerations:
    - effect: NoSchedule
      key: infra
      operator: Equal
      value: reserved
    - effect: NoExecute
      key: infra
      operator: Equal
      value: reserved

# Information of the Minio Cluster 
miniocluster:
  # -- Name/URL of the Minio Cluster
  # @default -- ''
  url: minio-tenant-console-url

  # -- Port of the Minio Cluster
  # @default -- ''
  port: 443

# Specifies whether a ServiceAccount should be created
serviceAccount:
  # Enable the creation of a ServiceAccount
  # @default -- false
  create: false

  # -- Name of the created ServiceAccount
  # @default -- ''
  name: "minio-provisioner"

  # -- Enable/disable auto mounting of the service account token
  # @default -- false
  automountServiceAccountToken: false
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