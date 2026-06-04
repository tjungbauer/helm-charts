

# dev-spaces

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.5](https://img.shields.io/badge/Version-1.0.5-informational?style=flat-square)

 

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

### Values validation

`values.schema.json` documents and validates chart values (enums for log levels, PVC strategy, image pull policy, and related fields). Helm applies it during `helm lint` and `helm install` when a schema is present:

```bash
helm lint . -f values.yaml
```

See `CHANGELOG.md` for release history.

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
| checluster.enabled | bool | false | Enable or disable the CheCluster resource. |
| checluster.name | string | devspaces | Name of the CheCluster resource. |
| checluster.namespace | string | openshift-devspaces | Namespace where Dev Spaces will be deployed. |
| devspaces_namespace | string | `"devspaces"` |  |
| namespace.create | bool | false | Create the namespace if it does not exist. |
| namespace.name | string | test-namespace | Name of the namespace. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

