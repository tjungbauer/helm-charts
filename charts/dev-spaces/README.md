

# dev-spaces

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)

 

  ## Description

  Red Hat OpenShift Dev Spaces is a collaborative Kubernetes-native development solution that
delivers consistent developer environments on Red Hat OpenShift.

Red Hat OpenShift Dev Spaces is a collaborative Kubernetes-native development solution that delivers consistent developer environments on Red Hat OpenShift. It provides:

- **Cloud-Based Development**: Browser-based IDE with no local setup required
- **Consistent Environments**: Reproducible workspaces defined as code
- **Collaborative**: Team-based development with shared workspaces
- **Kubernetes-Native**: Built for containerized application development
- **Extensible**: Support for VS Code extensions and custom plugins

## Prerequisites

- OpenShift cluster 4.12 or later
- Cluster administrator access
- Dev Spaces Operator installed
- Sufficient cluster resources:
  - Minimum 4 CPU cores
  - Minimum 8 GB RAM
  - Storage class for persistent volumes

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.25 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (for example in the folder clusters/management-cluster/setup-file-integrity-operator)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/dev-spaces

## Installation

### Quick Start

```bash
# Add the repository
helm repo add tjungbauer https://github.com/tjungbauer/helm-charts/

# Update repositories
helm repo update

# Install with default values
helm install devspaces tjungbauer/dev-spaces \
  --namespace openshift-devspaces \
  --create-namespace
```

### GitOps / ArgoCD

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: dev-spaces
  namespace: openshift-gitops
spec:
  project: default
  source:
    repoURL: https://github.com/tjungbauer/helm-charts/
    targetRevision: main
    path: charts/dev-spaces
    helm:
      valueFiles:
        - values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: openshift-devspaces
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

## Configuration

### Critical Configuration Requirements

#### 1. Networking Configuration

**Required** - Configure domain and hostname:

```yaml
checluster:
  networking:
    domain: apps.example.com          # Your OpenShift apps domain
    hostname: devspaces                # Dev Spaces hostname
    ingressClassName: openshift-default
```

#### 2. Storage Configuration

Configure persistent storage for workspaces:

```yaml
checluster:
  devEnvironments:
    storage:
      pvcStrategy: per-user              # or: common, per-workspace, ephemeral
      perUserStrategyPvcConfig:
        storageClass: gp3-csi            # Your storage class
        claimSize: 10Gi                  # Size per user
        storageAccessMode:
          - ReadWriteOnce
```

#### 3. Authentication Configuration

**Required for production** - Configure OAuth/OIDC:

```yaml
checluster:
  networking:
    auth:
      identityProviderURL: https://keycloak.example.com
      oAuthClientName: devspaces
      oAuthSecret: devspaces-oauth-secret
      oAuthScope: openid email profile
```

### Component Configuration

#### Che Server

Configure the main Che server component:

```yaml
checluster:
  components:
    cheServer:
      debug: false
      logLevel: INFO
      deployment:
        resources:
          requests:
            cpu: 100m
            memory: 512Mi
          limits:
            cpu: 1
            memory: 1Gi
        tolerations:
          - effect: NoSchedule
            key: node-role
            operator: Equal
            value: devspaces
```

#### Dashboard

Configure the Dev Spaces dashboard:

```yaml
checluster:
  components:
    dashboard:
      logLevel: INFO
      branding:
        logo:
          base64data: <base64-encoded-logo>
          mediatype: image/png
      headerMessage:
        show: true
        text: "Welcome to Dev Spaces"
```

### Workspace Configuration

#### Resource Limits

```yaml
checluster:
  devEnvironments:
    maxNumberOfWorkspacesPerUser: 5
    maxNumberOfRunningWorkspacesPerUser: 3
    maxNumberOfRunningWorkspacesPerCluster: 50
```

#### Timeouts and Idling

```yaml
checluster:
  devEnvironments:
    startTimeoutSeconds: 600
    secondsOfRunBeforeIdling: -1          # -1 = no idling
    secondsOfInactivityBeforeIdling: 1800 # 30 minutes
```

#### Default Editor

```yaml
checluster:
  devEnvironments:
    defaultEditor: che-incubator/che-code/latest
```

### Git Services Integration

Configure Git provider integration:

```yaml
checluster:
  gitServices:
    github:
      - secretName: github-oauth-secret
        endpoint: https://github.com
        disableSubdomainIsolation: false
   
    gitlab:
      - secretName: gitlab-oauth-secret
        endpoint: https://gitlab.com
   
    bitbucket:
      - secretName: bitbucket-oauth-secret
        endpoint: https://bitbucket.org
```

### Advanced Configuration

#### Container Build

Enable/disable container builds in workspaces:

```yaml
checluster:
  devEnvironments:
    disableContainerBuildCapabilities: false
    containerBuildConfiguration:
      openShiftSecurityContextConstraint: container-build
```

#### Trusted Certificates

```yaml
checluster:
  devEnvironments:
    trustedCerts:
      disableWorkspaceCaBundleMount: false
      gitTrustedCertsConfigMapName: git-trusted-certs
```

#### Advanced Authorization

```yaml
checluster:
  networking:
    auth:
      advancedAuthorization:
        allowGroups:
          - developers
          - admins
        allowUsers:
          - user@example.com
        denyGroups:
          - blocked-group
        denyUsers:
          - blocked@example.com
```

## Configuration Examples

### Example 1: Basic Configuration

Minimal setup for development:

```yaml
checluster:
  enabled: true
  namespace: openshift-devspaces
 
  devEnvironments:
    storage:
      pvcStrategy: per-user
      perUserStrategyPvcConfig:
        claimSize: 5Gi
 
  networking:
    domain: apps.example.com
    hostname: devspaces
```

### Example 2: Production Configuration

Production-ready setup with resource limits:

```yaml
checluster:
  enabled: true
  namespace: openshift-devspaces
 
  components:
    cheServer:
      logLevel: INFO
      deployment:
        resources:
          requests:
            cpu: 200m
            memory: 1Gi
          limits:
            cpu: 2
            memory: 2Gi
 
  devEnvironments:
    maxNumberOfWorkspacesPerUser: 10
    maxNumberOfRunningWorkspacesPerUser: 5
    maxNumberOfRunningWorkspacesPerCluster: 100
    startTimeoutSeconds: 600
    secondsOfInactivityBeforeIdling: 3600
   
    storage:
      pvcStrategy: per-user
      perUserStrategyPvcConfig:
        storageClass: gp3-csi
        claimSize: 20Gi
   
    tolerations:
      - effect: NoSchedule
        key: devspaces
        operator: Equal
        value: "true"
 
  networking:
    domain: apps.prod.example.com
    hostname: devspaces
    ingressClassName: openshift-default
    tlsSecretName: devspaces-tls
   
    auth:
      identityProviderURL: https://keycloak.prod.example.com
      oAuthClientName: devspaces
      oAuthSecret: devspaces-oauth-secret
```

## Validation

The chart includes comprehensive validations:

- **Log Levels**: Must be DEBUG, INFO, WARN, or ERROR
- **Image Pull Policy**: Must be Always, IfNotPresent, or Never
- **Deployment Strategy**: Must be Recreate or RollingUpdate
- **PVC Strategy**: Must be common, per-workspace, per-user, or ephemeral
- **Timeout Values**: Must be positive integers
- **Namespace Templates**: Must contain `<username>`, `<userid>`, or `<workspaceid>`
- **Storage Quantities**: Must be valid Kubernetes quantities (e.g., 10Gi)

## Monitoring and Observability

### Enable Metrics

```yaml
checluster:
  components:
    metrics:
      enable: true
```

### Health Checks

```bash
# Check overall status
oc get checluster -n openshift-devspaces

# Check component health
oc get pods -n openshift-devspaces

# Check routes
oc get routes -n openshift-devspaces
```

## Additional Resources

- [Dev Spaces Documentation](https://access.redhat.com/documentation/en-us/red_hat_openshift_dev_spaces)
- [Eclipse Che Documentation](https://eclipse.dev/che/docs/)
- [Devfile Registry](https://registry.devfile.io)
- [Dev Spaces Operator](https://github.com/eclipse-che/che-operator)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| checluster.additionalAnnotations | object | {} | Additional annotations to add to the CheCluster instance as key: value pairs. |
| checluster.additionalLabels | object | {} | Additional labels to add to the CheCluster instance as key: value pairs. |
| checluster.components.cheServer | object | `{"clusterRoles":[],"debug":false,"deployment":{"tolerations":{}},"logLevel":"INFO","proxy":{"credentialsSecretName":"","nonProxyHosts":[],"port":"","url":""}}` | General configuration settings related to the Che server. |
| checluster.components.cheServer.clusterRoles | list | [] | Additional ClusterRoles assigned to Che ServiceAccount. <br /> Each role must have a `app.kubernetes.io/part-of=che.eclipse.org` label. <br /> The defaults roles are: <br /> <ol> <li>- `<che-namespace>-cheworkspaces-clusterrole`</li> <li>- `<che-namespace>-cheworkspaces-namespaces-clusterrole`</li> <li>- `<che-namespace>-cheworkspaces-devworkspace-clusterrole`</li> </ol> where the <che-namespace> is the namespace where the CheCluster CR is created. <br /> The Che Operator must already have all permissions in these ClusterRoles to grant them. |
| checluster.components.cheServer.debug | bool | false | Enables the debug mode for Che server. |
| checluster.components.cheServer.deployment | object | `{"tolerations":{}}` | Deployment override options. |
| checluster.components.cheServer.deployment.tolerations | object | {} | Tolerations for Che Server pods. |
| checluster.components.cheServer.logLevel | string | INFO | Log level for Che Server (DEBUG, INFO). |
| checluster.components.cheServer.proxy | object | `{"credentialsSecretName":"","nonProxyHosts":[],"port":"","url":""}` | Proxy server settings for Kubernetes cluster. No additional configuration is required for OpenShift cluster. By specifying these settings for the OpenShift cluster, you override the OpenShift proxy configuration. |
| checluster.components.cheServer.proxy.credentialsSecretName | string | '' | The secret name that contains `user` and `password` for a proxy server. The secret must have a `app.kubernetes.io/part-of=che.eclipse.org` label. |
| checluster.components.cheServer.proxy.nonProxyHosts | list | [] | A list of hosts that can be reached directly, bypassing the proxy.<br /> Specify wild card domain use the following form `.<DOMAIN>`, for example:<br /> <ol> <li>- localhost</li> <li>- 127.0.0.1</li> <li>- my.host.com</li> <li>- 123.42.12.32</li> </ol> Use only when a proxy configuration is required. The Operator respects OpenShift cluster-wide proxy configuration,<br /> defining `nonProxyHosts` in a custom resource leads to merging non-proxy hosts lists from the cluster proxy configuration, and the ones defined in the custom resources.<br /> |
| checluster.components.cheServer.proxy.port | string | '' | Proxy port. |
| checluster.components.cheServer.proxy.url | string | '' | URL (protocol+hostname) of the proxy server. Use only when a proxy configuration is required. The Operator respects OpenShift cluster-wide proxy configuration, defining `url` in a custom resource leads to overriding the cluster proxy configuration. |
| checluster.components.dashboard | object | `{"branding":{"logo":{"base64data":"","mediatype":""}},"deployment":{"tolerations":{}},"headerMessage":{"show":false,"text":""},"logLevel":"INFO"}` | Configuration settings related to the dashboard used by the Che installation. |
| checluster.components.dashboard.branding | object | `{"logo":{"base64data":"","mediatype":""}}` | Dashboard branding resources. |
| checluster.components.dashboard.branding.logo | object | `{"base64data":"","mediatype":""}` | Dashboard logo. |
| checluster.components.dashboard.branding.logo.base64data | string | '' | Base64-encoded logo data. |
| checluster.components.dashboard.branding.logo.mediatype | string | '' | Media type of the logo (e.g., image/png). |
| checluster.components.dashboard.deployment | object | `{"tolerations":{}}` | Deployment configuration for Dashboard |
| checluster.components.dashboard.deployment.tolerations | object | {} | Tolerations for Dashboard pods. |
| checluster.components.dashboard.headerMessage | object | `{"show":false,"text":""}` | Header message configuration |
| checluster.components.dashboard.headerMessage.show | bool | false | Instructs dashboard to show the message. |
| checluster.components.dashboard.headerMessage.text | string | '' | Header message text. |
| checluster.components.dashboard.logLevel | string | INFO | The log level for the Dashboard. (can be DEBUG, INFO, WARN, ERROR, FATAL, TRACE, SILENT) |
| checluster.components.devfileRegistry | object | `{"deployment":{"tolerations":{}},"disableInternalRegistry":"","externalDevfileRegistries":[]}` | Configuration settings related to the devfile registry used by the Che installation. |
| checluster.components.devfileRegistry.deployment | object | `{"tolerations":{}}` | Deployment configuration for Devfile Registry |
| checluster.components.devfileRegistry.deployment.tolerations | object | {} | Tolerations for Devfile Registry pods. |
| checluster.components.devfileRegistry.disableInternalRegistry | string | false | Disable internal devfile registry. |
| checluster.components.devfileRegistry.externalDevfileRegistries | list | [] | External devfile registries serving sample ready-to-use devfiles. |
| checluster.components.imagePuller | object | `{"enable":false,"spec":{"affinity":"","cachingCPULimit":"","cachingCPURequest":"","cachingIntervalHours":"","cachingMemoryLimit":"","cachingMemoryRequest":"","configMapName":"","daemonsetName":"","deploymentName":"","imagePullSecrets":"","imagePullerImage":"","images":"","nodeSelector":""}}` | Image Puller configuration |
| checluster.components.imagePuller.enable | bool | false | Enable Kubernetes Image Puller. Install and configure the community supported Kubernetes Image Puller Operator. When you set the value to `true` without providing any specs, it creates a default Kubernetes Image Puller object managed by the Operator. When you set the value to `false`, the Kubernetes Image Puller object is deleted, and the Operator uninstalled, regardless of whether a spec is provided. If you leave the `spec.images` field empty, a set of recommended workspace-related images is automatically detected and pre-pulled after installation. Note that while this Operator and its behavior is community-supported, its payload may be commercially-supported for pulling commercially-supported images. |
| checluster.components.imagePuller.spec | object | `{"affinity":"","cachingCPULimit":"","cachingCPURequest":"","cachingIntervalHours":"","cachingMemoryLimit":"","cachingMemoryRequest":"","configMapName":"","daemonsetName":"","deploymentName":"","imagePullSecrets":"","imagePullerImage":"","images":"","nodeSelector":""}` | A Kubernetes Image Puller spec to configure the image puller in the CheCluster. |
| checluster.components.imagePuller.spec.affinity | string | '' | Affinity for image puller pods. |
| checluster.components.imagePuller.spec.cachingCPULimit | string | '' | CPU limit for caching. |
| checluster.components.imagePuller.spec.cachingCPURequest | string | '' | CPU request for caching. |
| checluster.components.imagePuller.spec.cachingIntervalHours | string | '' | Caching interval hours. |
| checluster.components.imagePuller.spec.cachingMemoryLimit | string | '' | Memory limit for caching. |
| checluster.components.imagePuller.spec.cachingMemoryRequest | string | '' | Memory request for caching. |
| checluster.components.imagePuller.spec.configMapName | string | '' | ConfigMap name for image puller configuration. |
| checluster.components.imagePuller.spec.daemonsetName | string | '' | Daemonset name for image puller. |
| checluster.components.imagePuller.spec.deploymentName | string | '' | Deployment name for image puller. |
| checluster.components.imagePuller.spec.imagePullSecrets | string | '' | Image pull secrets. |
| checluster.components.imagePuller.spec.imagePullerImage | string | '' | Image puller image. |
| checluster.components.imagePuller.spec.images | string | '' | Images to pre-pull. |
| checluster.components.imagePuller.spec.nodeSelector | string | '' | Node selector for image puller pods. |
| checluster.components.metrics | object | `{"enable":true}` | Metrics configuration |
| checluster.components.metrics.enable | bool | true | Enables `metrics` for the Che server endpoint. |
| checluster.components.pluginRegistry | object | `{"deployment":{"tolerations":{}},"disableInternalRegistry":"","externalPluginRegistries":[],"openVSXURL":"https://open-vsx.org"}` | Configuration settings related to the plug-in registry used by the Che installation. |
| checluster.components.pluginRegistry.deployment | object | `{"tolerations":{}}` | Deployment configuration for Plugin Registry |
| checluster.components.pluginRegistry.deployment.tolerations | object | {} | Tolerations for Plugin Registry pods. |
| checluster.components.pluginRegistry.disableInternalRegistry | string | false | Disable internal plugin registry. |
| checluster.components.pluginRegistry.externalPluginRegistries | list | [] | External plugin registries. |
| checluster.components.pluginRegistry.openVSXURL | string | https://open-vsx.org | Open VSX registry URL. If omitted an embedded instance will be used. |
| checluster.containerRegistry.hostname | string | '' | An optional hostname or URL of an alternative container registry to pull images from. |
| checluster.containerRegistry.organization | string | '' | An optional repository name of an alternative registry to pull images from. |
| checluster.devEnvironments.allowedSources | object | `{"urls":[]}` | AllowedSources defines the allowed sources on which workspaces can be started. |
| checluster.devEnvironments.allowedSources.urls | list | [] | List of allowed source URLs. |
| checluster.devEnvironments.containerBuildConfiguration | object | `{"openShiftSecurityContextConstraint":"container-build"}` | Container build configuration |
| checluster.devEnvironments.containerBuildConfiguration.openShiftSecurityContextConstraint | string | container-build | OpenShift security context constraint to build containers. |
| checluster.devEnvironments.defaultComponents | list | [] | Default components applied to DevWorkspaces. These default components are meant to be used when a Devfile, that does not contain any components. |
| checluster.devEnvironments.defaultEditor | string | '' | The default editor to workspace create with. It could be a plugin ID or a URI. The plugin ID must have `publisher/name/version` format. The URI must start from `http://` or `https://`. |
| checluster.devEnvironments.defaultNamespace | object | `{"autoProvision":true,"template":"<username>-devspaces"}` | Default namespace configuration |
| checluster.devEnvironments.defaultNamespace.autoProvision | bool | true | ndicates if is allowed to automatically create a user namespace. If it set to false, then user namespace must be pre-created by a cluster administrator. |
| checluster.devEnvironments.defaultNamespace.template | string | <username>-devspaces | If you don't create the user namespaces in advance, this field defines the Kubernetes namespace created when you start your first workspace. You can use `<username>` and `<userid>` placeholders, such as che-workspace-<username>. |
| checluster.devEnvironments.deploymentStrategy | string | Recreate | Deployment strategy (Recreate, RollingUpdate). DeploymentStrategy defines the deployment strategy to use to replace existing workspace pods with new ones. The available deployment stragies are `Recreate` and `RollingUpdate`. With the `Recreate` deployment strategy, the existing workspace pod is killed before the new one is created. With the `RollingUpdate` deployment strategy, a new workspace pod is created and the existing workspace pod is deleted only when the new workspace pod is in a ready state. If not specified, the default `Recreate` deployment strategy is used. |
| checluster.devEnvironments.disableContainerBuildCapabilities | bool | false | Disables the container build capabilities. |
| checluster.devEnvironments.editorsDownloadUrls | list | [] | EditorsDownloadUrls provides a list of custom download URLs for JetBrains editors in a local-to-remote flow. It is particularly useful in disconnected or air-gapped environments, where editors cannot be downloaded from the public internet. Each entry contains an editor identifier in the `publisher/name/version` format and the corresponding download URL. Currently, this field is intended only for JetBrains editors and should not be used for other editor types. |
| checluster.devEnvironments.ignoredUnrecoverableEvents | list | [] | IgnoredUnrecoverableEvents defines a list of Kubernetes event names that should be ignored when deciding to fail a workspace that is starting. This option should be used if a transient cluster issue is triggering false-positives (for example, if the cluster occasionally encounters FailedScheduling events). Events listed here will not trigger workspace failures. |
| checluster.devEnvironments.imagePullPolicy | string | IfNotPresent | ImagePullPolicy defines the imagePullPolicy used for containers in a DevWorkspace. (Always, IfNotPresent, Never). |
| checluster.devEnvironments.maxNumberOfRunningWorkspacesPerCluster | int | -1 | The maximum number of concurrently running workspaces across the entire Kubernetes cluster. This applies to all users in the system. If the value is set to -1, it means there is no limit on the number of running workspaces. |
| checluster.devEnvironments.maxNumberOfRunningWorkspacesPerUser | int | -1 | The maximum number of running workspaces per user. The value, -1, allows users to run an unlimited number of workspaces. |
| checluster.devEnvironments.maxNumberOfWorkspacesPerUser | int | -1 | Total number of workspaces, both stopped and running, that a user can keep. The value, -1, allows users to keep an unlimited number of workspaces. |
| checluster.devEnvironments.networking | object | `{"externalTLSConfig":{"enabled":false}}` | Configuration settings related to the workspaces networking. |
| checluster.devEnvironments.networking.externalTLSConfig | object | `{"enabled":false}` | External TLS configuration |
| checluster.devEnvironments.networking.externalTLSConfig.enabled | bool | false | Enabled determines whether external TLS configuration is used. If set to true, the operator will not set TLS config for ingress/route objects. Instead, it ensures that any custom TLS configuration will not be reverted on synchronization. |
| checluster.devEnvironments.persistUserHome | object | `{"disableInitContainer":false,"enabled":false}` | Persist user home directory |
| checluster.devEnvironments.persistUserHome.disableInitContainer | bool | false | Disable init container for persistent home. |
| checluster.devEnvironments.persistUserHome.enabled | bool | false | Enable persistent user home. |
| checluster.devEnvironments.podSchedulerName | string | '' | Pod scheduler for the workspace pods. If not specified, the pod scheduler is set to the default scheduler on the cluster. |
| checluster.devEnvironments.runtimeClassName | string | '' | RuntimeClassName specifies the spec.runtimeClassName for workspace pods. |
| checluster.devEnvironments.secondsOfInactivityBeforeIdling | int | 1800 | Total number of workspaces, both stopped and running, that a user can keep. The value, -1, allows users to keep an unlimited number of workspaces. |
| checluster.devEnvironments.secondsOfRunBeforeIdling | int | -1 | Run timeout for workspaces in seconds. This timeout is the maximum duration a workspace runs. To disable workspace run timeout, set this value to -1. |
| checluster.devEnvironments.serviceAccount | string | '' | ServiceAccount to use by the DevWorkspace operator when starting the workspaces. |
| checluster.devEnvironments.serviceAccountTokens | list | [] | List of ServiceAccount tokens that will be mounted into workspace pods as projected volumes.<br /> You can specify the following fields:<br /> <ol> <li>- mountPath: The path within the workspace container at which the token should be mounted.</li> <li>- name: The name of the ServiceAccount token.</li> <li>- path: The path relative to the mount point of the file to project the token into.</li> <li>- audience: OPTIONAL: The intended audience of the token.</li> <li>- expirationSeconds: OPTIONAL: ExpirationSeconds is the requested duration of validity of the serviceaccount token. </li> </ol> |
| checluster.devEnvironments.startTimeoutSeconds | int | 300 | StartTimeoutSeconds determines the maximum duration (in seconds) that a workspace can take to start before it is automatically failed. If not specified, the default value of 300 seconds (5 minutes) is used. |
| checluster.devEnvironments.storage | object | `{"perUserStrategyPvcConfig":{"claimSize":"","storageAccessMode":[],"storageClass":""},"pvcStrategy":"per-workspace"}` | Storage configuration |
| checluster.devEnvironments.storage.perUserStrategyPvcConfig | object | `{"claimSize":"","storageAccessMode":[],"storageClass":""}` | Per-user strategy PVC configuration |
| checluster.devEnvironments.storage.perUserStrategyPvcConfig.claimSize | string | '' | PVC claim size. |
| checluster.devEnvironments.storage.perUserStrategyPvcConfig.storageAccessMode | list | [] | Storage access modes. |
| checluster.devEnvironments.storage.perUserStrategyPvcConfig.storageClass | string | '' | Storage class for PVC. |
| checluster.devEnvironments.storage.pvcStrategy | string | per-workspace | Persistent volume claim strategy for the Che server. The supported strategies are: `per-user` (all workspaces PVCs in one volume), `per-workspace` (each workspace is given its own individual PVC) and `ephemeral` (non-persistent storage where local changes will be lost when the workspace is stopped.) |
| checluster.devEnvironments.tolerations | object | {} | The pod tolerations of the workspace pods limit where the workspace pods can run. |
| checluster.devEnvironments.trustedCerts | object | `{"disableWorkspaceCaBundleMount":false,"gitTrustedCertsConfigMapName":""}` | Trusted certificates configuration |
| checluster.devEnvironments.trustedCerts.disableWorkspaceCaBundleMount | bool | false | By default, the Operator creates and mounts the 'ca-certs-merged' ConfigMap <br /> containing the CA certificate bundle in users' workspaces at two locations: <br /> '/public-certs' and '/etc/pki/ca-trust/extracted/pem'. <br /> The '/etc/pki/ca-trust/extracted/pem' directory is where the system stores extracted CA certificates <br /> for trusted certificate authorities on Red Hat (e.g., CentOS, Fedora). <br /> This option disables mounting the CA bundle to the '/etc/pki/ca-trust/extracted/pem' directory <br /> while still mounting it to '/public-certs'. |
| checluster.devEnvironments.trustedCerts.gitTrustedCertsConfigMapName | string | '' | The ConfigMap contains certificates to propagate to the Che components and to provide a particular configuration for Git. |
| checluster.devEnvironments.user | object | `{"clusterRoles":[]}` | User configuration |
| checluster.devEnvironments.user.clusterRoles | list | [] | Additional ClusterRoles assigned to the user. The role must have `app.kubernetes.io/part-of=che.eclipse.org` label. |
| checluster.enabled | bool | false | Enable or disable the CheCluster resource. |
| checluster.gitServices.azure | list | [] | Azure DevOps configuration. |
| checluster.gitServices.bitbucket | list | [] | Bitbucket configuration. |
| checluster.gitServices.github | list | [] | GitHub configuration. |
| checluster.gitServices.gitlab | list | [] | GitLab configuration. |
| checluster.name | string | devspaces | Name of the CheCluster resource. |
| checluster.namespace | string | openshift-devspaces | Namespace where Dev Spaces will be deployed. |
| checluster.networking | object | `{"auth":{"advancedAuthorization":{"allowGroups":[],"allowUsers":[],"denyGroups":[],"denyUsers":[]},"gateway":{"deployment":{"tolerations":{}},"kubeRbacProxy":{"logLevel":0},"oAuthProxy":{"cookieExpireSeconds":86400},"traefik":{"logLevel":"INFO"}},"identityProviderURL":"","oAuthAccessTokenInactivityTimeoutSeconds":"","oAuthAccessTokenMaxAgeSeconds":"","oAuthClientName":"","oAuthScope":"","oAuthSecret":""},"domain":"","hostname":"","ingressClassName":"","tlsSecretName":""}` | Networking, Che authentication, and TLS configuration. |
| checluster.networking.auth | object | `{"advancedAuthorization":{"allowGroups":[],"allowUsers":[],"denyGroups":[],"denyUsers":[]},"gateway":{"deployment":{"tolerations":{}},"kubeRbacProxy":{"logLevel":0},"oAuthProxy":{"cookieExpireSeconds":86400},"traefik":{"logLevel":"INFO"}},"identityProviderURL":"","oAuthAccessTokenInactivityTimeoutSeconds":"","oAuthAccessTokenMaxAgeSeconds":"","oAuthClientName":"","oAuthScope":"","oAuthSecret":""}` | Authentication configuration |
| checluster.networking.auth.advancedAuthorization | object | `{"allowGroups":[],"allowUsers":[],"denyGroups":[],"denyUsers":[]}` | Advanced authorization configuration |
| checluster.networking.auth.advancedAuthorization.allowGroups | list | [] | List of groups that are allowed to access the Che server. |
| checluster.networking.auth.advancedAuthorization.allowUsers | list | [] | List of users that are allowed to access the Che server. |
| checluster.networking.auth.advancedAuthorization.denyGroups | list | [] | List of groups that are denied to access the Che server. |
| checluster.networking.auth.advancedAuthorization.denyUsers | list | [] | List of users that are denied to access the Che server. |
| checluster.networking.auth.gateway | object | `{"deployment":{"tolerations":{}},"kubeRbacProxy":{"logLevel":0},"oAuthProxy":{"cookieExpireSeconds":86400},"traefik":{"logLevel":"INFO"}}` | Gateway configuration |
| checluster.networking.auth.gateway.deployment | object | `{"tolerations":{}}` | Deployment override options.<br /> Since gateway deployment consists of several containers, they must be distinguished in the configuration by their names:<br /> <ol> <li>- `gateway`</li> <li>- `configbump`</li> <li>- `oauth-proxy`</li> <li>- `kube-rbac-proxy`</li> </ol> |
| checluster.networking.auth.gateway.deployment.tolerations | object | {} | Tolerations for gateway pods. |
| checluster.networking.auth.gateway.kubeRbacProxy | object | `{"logLevel":0}` | Configuration for kube-rbac-proxy within the Che gateway pod. |
| checluster.networking.auth.gateway.kubeRbacProxy.logLevel | int | 0 | The glog log level for the kube-rbac-proxy container within the gateway pod. <br /> Larger values represent a higher verbosity. The default value is `0`. |
| checluster.networking.auth.gateway.oAuthProxy | object | `{"cookieExpireSeconds":86400}` | Configuration for oauth-proxy within the Che gateway pod. |
| checluster.networking.auth.gateway.oAuthProxy.cookieExpireSeconds | int | 86400 | Expire timeframe for cookie. If set to 0, cookie becomes a session-cookie which will expire when the browser is closed. |
| checluster.networking.auth.gateway.traefik | object | `{"logLevel":"INFO"}` | Configuration for traefik within the Che gateway pod. |
| checluster.networking.auth.gateway.traefik.logLevel | string | INFO | The log level for the Traefik container within the gateway pod: <br /> `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`, or `PANIC`. The default value is `INFO` |
| checluster.networking.auth.identityProviderURL | string | '' | Public URL of the Identity Provider server. |
| checluster.networking.auth.oAuthAccessTokenInactivityTimeoutSeconds | string | '' | OAuth access token inactivity timeout in seconds. |
| checluster.networking.auth.oAuthAccessTokenMaxAgeSeconds | string | '' | Inactivity timeout for tokens to set in the OpenShift `OAuthClient` resource used to set up identity federation on the OpenShift side. 0 means tokens for this client never time out. |
| checluster.networking.auth.oAuthClientName | string | '' | Access token max age for tokens to set in the OpenShift `OAuthClient` resource used to set up identity federation on the OpenShift side. |
| checluster.networking.auth.oAuthScope | string | '' | Name of the OpenShift `OAuthClient` resource used to set up identity federation on the OpenShift side. |
| checluster.networking.auth.oAuthSecret | string | '' | Name of the secret set in the OpenShift `OAuthClient` resource used to set up identity federation on the OpenShift side. |
| checluster.networking.domain | string | '' | DFor an OpenShift cluster, the Operator uses the domain to generate a hostname for the route. |
| checluster.networking.hostname | string | '' | The public hostname of the installed Che server. |
| checluster.networking.ingressClassName | string | '' | IngressClassName is the name of an IngressClass cluster resource. If a class name is defined in both the `IngressClassName` field and the `kubernetes.io/ingress.class` annotation, `IngressClassName` field takes precedence. |
| checluster.networking.tlsSecretName | string | '' | The name of the secret used to set up Ingress TLS termination. If the field is an empty string, the default cluster certificate is used. The secret must have a `app.kubernetes.io/part-of=che.eclipse.org` label. |
| checluster.syncwave | string | 3 | Syncwave for ArgoCD to manage deployment order. |
| devspaces_namespace | string | `"admin-devspaces"` |  |
| namespace.create | bool | false | Create the namespace if it does not exist. |
| namespace.name | string | test-namespace | Name of the namespace. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

