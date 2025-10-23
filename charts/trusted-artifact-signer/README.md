

# trusted-artifact-signer

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)

 

  ## Description

  Configure Trusted Artifact Signer

## Introduction

This Helm chart deploys **Red Hat Trusted Artifact Signer (RHTAS)** on OpenShift. RHTAS is based on the [Sigstore](https://www.sigstore.dev/) project and provides a complete solution for signing, verifying, and maintaining transparency of software artifacts.

### What is RHTAS?

RHTAS provides enterprise-grade software supply chain security by offering:

- **Code Signing**: Cryptographically sign software artifacts (containers, binaries, etc.)
- **Transparency Logging**: Immutable audit trail of all signing events
- **Certificate Authority**: Automated certificate issuance for signing
- **Timestamp Authority**: RFC 3161 compliant timestamping service
- **Key Distribution**: Secure distribution of public keys and certificates

### Components

RHTAS consists of the following integrated components:

#### Core Components

- **Fulcio**: A Root Certificate Authority for issuing code signing certificates based on OIDC identity
  - Issues short-lived certificates (typically 10 minutes)
  - No long-term key management required
  - Identity-based signing tied to your OIDC provider

- **Rekor**: An immutable transparency log for storing artifact signatures
  - Records all signing events with cryptographic proof
  - Enables signature verification and discovery
  - Includes a Search UI for exploring the transparency log

- **TSA (Timestamp Authority)**: RFC 3161 compliant timestamping service
  - Provides trusted timestamps for signatures
  - Proves when artifacts were signed
  - Essential for long-term signature validity

- **CT Log**: Certificate Transparency Log
  - Records all certificates issued by Fulcio
  - Provides transparency and accountability
  - Enables detection of mis-issued certificates

#### Supporting Infrastructure

- **Trillian**: A transparent, append-only log (Merkle tree)
  - Provides the cryptographic foundation for Rekor and CT Log
  - Ensures tamper-evident storage
  - Scalable to billions of entries

- **TUF (The Update Framework)**: Secure key and metadata distribution
  - Distributes public keys and certificates
  - Protects against key compromise and rollback attacks
  - Enables offline signature verification

## Prerequisites

### Required

- **OpenShift**: Version 4.12 or higher
- **OIDC Provider**: A working OIDC/OAuth2 provider for authentication
  - Red Hat SSO (Keycloak)
  - GitHub Actions
  - GitLab CI
  - Google, Microsoft, or other OIDC providers
- **Storage**: Persistent volumes for databases and logs
  - Dynamic provisioning recommended
  - See [Storage Requirements](#storage-requirements) below
- **RHTAS Operator**: Must be installed (this chart can install it via `helper-operator`)

### Optional

- **Custom Certificates**: For production deployments
- **External Databases**: For high-availability setups
- **Monitoring**: Prometheus for metrics collection
- **Custom CA Bundle**: If using internal certificate authorities

### Storage Requirements

Recommended minimum storage sizes:

| Component | Storage Type | Minimum Size | Recommended Size | Notes |
|-----------|-------------|--------------|------------------|-------|
| Rekor | PVC | 5Gi | 20Gi+ | Grows with number of signatures |
| Trillian DB | PVC | 5Gi | 20Gi+ | Stores Merkle tree data |
| TUF | PVC | 100Mi | 500Mi | Stores keys and metadata |

**Note**: Storage requirements scale with usage. For production deployments with high signature volumes, plan for significantly larger storage.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.24 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/trusted-artifact-signer

## Installation

### GitOps Deployment (Recommended)

This chart is designed for GitOps workflows using Argo CD or similar tools. See: https://github.com/tjungbauer/openshift-clusterconfig-gitops

The chart includes ArgoCD sync-wave annotations to ensure proper deployment order:

1. **Wave 0**: RHTAS Operator installation (via `helper-operator`)
2. **Wave 2**: Operator readiness check (via `helper-status-checker`)
3. **Wave 3**: Securesign custom resource deployment

### Quick Start

#### 1. Add Helm Repository

```bash
helm repo add tjungbauer https://charts.stderr.at/
helm repo update
```

#### 2. Basic Installation

```bash
# Install with operator
helm install rhtas tjungbauer/trusted-artifact-signer \
  --create-namespace \
  --namespace trusted-artifact-signer \
  --set securesign.enabled=true \
  --set securesign.fulcio.config.OIDCIssuers[0].Issuer=https://your-oidc-provider.com \
  --set securesign.fulcio.config.OIDCIssuers[0].IssuerURL=https://your-oidc-provider.com
```

#### 3. Custom Installation

1. Create your (minimum) values file:

```yaml
---
securesign:
  # Enable the Securesign resource
  enabled: true

  name: securesign
  namespace: trusted-artifact-signer
  syncwave: '3'

  # Fulcio Configuration - Certificate Authority for Code Signing
  fulcio:
    config:
      OIDCIssuers:
        - ClientID: trusted-artifact-signer
          Issuer: 'https://keycloak-rhsso.apps.cluster.example.com/auth/realms/openshift'
          IssuerURL: 'https://keycloak-rhsso.apps.cluster.example.com/auth/realms/openshift'
          Type: email

  # Trillian Configuration
  trillian:
    database:
      create: true
```

2. Install the chart:

```bash
helm install rhtas tjungbauer/trusted-artifact-signer \
  --create-namespace \
  --namespace trusted-artifact-signer \
  -f my-values.yaml
```

#### 4. Verify Installation

```bash
# Check operator status
oc get csv -n openshift-operators | grep rhtas

# Check Securesign resource
oc get securesign -n trusted-artifact-signer

# Check all components
oc get pods -n trusted-artifact-signer
```

## Configuration

### Critical Configuration Requirements

#### OIDC Issuer Configuration (Required)

RHTAS requires at least one OIDC issuer for Fulcio. The following fields are **mandatory** and validated:

- `ClientID`: Must not be empty
- `Issuer`: Must not be empty 
- `IssuerURL`: Must not be empty

### Component Configuration

Each component can be individually configured with:

- **Replicas**: Scale components independently
- **Resources**: CPU and memory requests/limits
- **Tolerations**: Schedule on specific nodes
- **External Access**: Configure ingress/routes with custom hostnames
- **Monitoring**: Enable Prometheus metrics endpoints
- **Storage**: Customize PVC sizes and storage classes

## Parameters

## Values

### namespace

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| securesign.additionalAnnotations | object | {} | Additional annotations to add to the Securesign instance as key: value pairs. |
| securesign.additionalLabels | object | {} | Additional labels to add to the Securesign instance as key: value pairs. |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| securesign.ctlog | object | `{"maxCertChainSize":153600,"monitoring":{"enabled":false},"privateKeyPasswordRef":{},"publicKeyRef":{},"replicas":1,"resources":{},"rootCertificates":[],"serverConfigRef":{},"tls":{"certificateRef":{},"privateKeyRef":{}},"tolerations":{},"treeID":"","trillian":{"address":"","port":8091}}` | Certificate Transparency Log configuration |
| securesign.ctlog.monitoring | object | `{"enabled":false}` | Monitoring configuration for CT Log |
| securesign.ctlog.monitoring.enabled | bool | false | Enable or disable monitoring for CT Log. |
| securesign.ctlog.privateKeyPasswordRef | object | {} | Private key password reference for the certificate. |
| securesign.ctlog.publicKeyRef | object | {} | Public key reference for the certificate. |
| securesign.ctlog.replicas | int | 1 | Replicas for CT Log. |
| securesign.ctlog.resources | object | {} | Set resources.requests and resources.limits. Per default this block can be omitted. ONLY set this if you know what you are doing. |
| securesign.ctlog.rootCertificates | list | [] | Root certificate references for the certificate. |
| securesign.ctlog.serverConfigRef | object | {} | server config reference for the CT Log |
| securesign.ctlog.tls | object | `{"certificateRef":{},"privateKeyRef":{}}` | TLS configuration for CT Log |
| securesign.ctlog.tls.certificateRef | object | {} | Reference to the secret containing the certificate for TLS encryption. |
| securesign.ctlog.tls.privateKeyRef | object | {} | Reference to the secret containing the private key for TLS encryption. |
| securesign.ctlog.tolerations | object | {} | You can configure tolerations of tainted nodes. |
| securesign.ctlog.treeID | string | '' | Tree ID for the CT Log. |
| securesign.ctlog.trillian | object | `{"address":"","port":8091}` | Trillian configuration for CT Log |
| securesign.ctlog.trillian.address | string | '' | Address of the Trillian server. |
| securesign.ctlog.trillian.port | int | 8091 | Port for Trillian service. |
| securesign.enabled | bool | false | Enable or disable the Securesign resource. |
| securesign.fulcio | object | `{"certificate":{"commonName":"fulcio.hostname","organizationEmail":"admin@example.com","organizationName":"Example Organization","privateKeyPasswordRef":{},"privateKeyRef":{}},"config":{"CIIssuerMetadata":[{"IssuerName":""}],"OIDCIssuers":[{"CIProvider":"","ChallengeClaim":"","ClientID":"trusted-artifact-signer","Issuer":"dummy","IssuerClaim":"","IssuerURL":"dummy","SPIFFETrustDomain":"","SubjectDomain":"","Type":"email"}]},"ctlog":{"address":"","port":80,"prefix":"trusted-artifact-signer"},"externalAccess":{"enabled":true,"host":""},"monitoring":{"enabled":false},"replicas":1,"resources":{},"tolerations":{},"trustedCA":{}}` | Fulcio is a free Root-CA for code signing certs |
| securesign.fulcio.certificate | object | `{"commonName":"fulcio.hostname","organizationEmail":"admin@example.com","organizationName":"Example Organization","privateKeyPasswordRef":{},"privateKeyRef":{}}` | Certificate configuration for Fulcio |
| securesign.fulcio.certificate.commonName | string | `"fulcio.hostname"` | Common Name for the Fulcio certificate. This can use templating, e.g., "{{ .Release.Name }}.example.com" |
| securesign.fulcio.certificate.organizationEmail | string | `"admin@example.com"` | Organization email for the certificate. |
| securesign.fulcio.certificate.organizationName | string | `"Example Organization"` | Organization name for the certificate. |
| securesign.fulcio.certificate.privateKeyPasswordRef | object | {} | Private key password reference for the certificate. |
| securesign.fulcio.certificate.privateKeyRef | object | {} | Private key reference for the certificate. |
| securesign.fulcio.config | object | `{"CIIssuerMetadata":[{"IssuerName":""}],"OIDCIssuers":[{"CIProvider":"","ChallengeClaim":"","ClientID":"trusted-artifact-signer","Issuer":"dummy","IssuerClaim":"","IssuerURL":"dummy","SPIFFETrustDomain":"","SubjectDomain":"","Type":"email"}]}` | Fulcio configuration |
| securesign.fulcio.config.CIIssuerMetadata | list | `[{"IssuerName":""}]` | CIIssuerMetadata configuration for Fulcio |
| securesign.fulcio.config.CIIssuerMetadata[0] | object | '' | Name of the issuer |
| securesign.fulcio.config.OIDCIssuers | list | `[{"CIProvider":"","ChallengeClaim":"","ClientID":"trusted-artifact-signer","Issuer":"dummy","IssuerClaim":"","IssuerURL":"dummy","SPIFFETrustDomain":"","SubjectDomain":"","Type":"email"}]` | List of OIDC Issuers for authentication |
| securesign.fulcio.config.OIDCIssuers[0] | object | trusted-artifact-signer | Client ID for the OIDC Issuer. |
| securesign.fulcio.config.OIDCIssuers[0].CIProvider | string | '' | CI Provider for the OIDC Issuer. |
| securesign.fulcio.config.OIDCIssuers[0].ChallengeClaim | string | '' | Challenge Claim for the OIDC Issuer. |
| securesign.fulcio.config.OIDCIssuers[0].Issuer | string | '' | OIDC Issuer URL |
| securesign.fulcio.config.OIDCIssuers[0].IssuerClaim | string | '' | Issuer Claim for the OIDC Issuer. |
| securesign.fulcio.config.OIDCIssuers[0].IssuerURL | string | '' | OIDC Issuer URL (alternative field) |
| securesign.fulcio.config.OIDCIssuers[0].SPIFFETrustDomain | string | '' | SPIFFE Trust Domain for the OIDC Issuer. |
| securesign.fulcio.config.OIDCIssuers[0].SubjectDomain | string | '' | Subject Domain for the OIDC Issuer. |
| securesign.fulcio.config.OIDCIssuers[0].Type | string | email | Type of authentication. Possible values: email, uri, username |
| securesign.fulcio.ctlog | object | `{"address":"","port":80,"prefix":"trusted-artifact-signer"}` | CT Log configuration for Fulcio |
| securesign.fulcio.ctlog.address | string | '' | Address of the CT Log service. |
| securesign.fulcio.ctlog.port | int | 80 | Port for CT Log service. |
| securesign.fulcio.ctlog.prefix | string | trusted-artifact-signer | Prefix for CT Log. |
| securesign.fulcio.externalAccess | object | `{"enabled":true,"host":""}` | External access configuration for Fulcio |
| securesign.fulcio.externalAccess.enabled | bool | true | Enable external access to Fulcio. |
| securesign.fulcio.externalAccess.host | string | '' | Host for external access to Fulcio. |
| securesign.fulcio.monitoring | object | `{"enabled":false}` | Monitoring configuration for Fulcio |
| securesign.fulcio.monitoring.enabled | bool | false | Enable or disable monitoring for Fulcio. |
| securesign.fulcio.replicas | int | 1 | Replicas for Fulcio. |
| securesign.fulcio.resources | object | {} | Set resources.requests and resources.limits. Per default this block can be omitted. ONLY set this if you know what you are doing. |
| securesign.fulcio.tolerations | object | {} | You can configure tolerations of tainted nodes. |
| securesign.fulcio.trustedCA | object | {} | ConfigMap with additional bundle of trusted CA |
| securesign.name | string | securesign | Name of the Securesign resource. |
| securesign.namespace | string | trusted-artifact-signer | Namespace where the Securesign resource will be deployed. |
| securesign.rekor | object | `{"attestations":{"enabled":true,"url":"file:///var/run/attestations?no_tmp_dir=true"},"backFillRedis":{"enabled":true,"schedule":"0 0 * * *"},"externalAccess":{"enabled":true,"host":""},"maxRequestBodySize":10485760,"monitoring":{"enabled":false,"tlog":{"enabled":false,"interval":"10m"}},"pvc":{"accessModes":["ReadWriteOnce"],"name":"","retain":true,"size":"5Gi"},"rekorSearchUI":{"enabled":true,"host":"","replicas":1,"resources":{},"tolerations":{}},"replicas":1,"resources":{},"searchIndex":{"create":true,"provider":"","url":""},"sharding":[],"signer":{"keyRef":{},"kms":"secret","passwordRef":{}},"tolerations":{},"treeID":"","trillian":{"address":"","port":8091},"trustedCA":{}}` | Rekor is a transparency log and timestamping service |
| securesign.rekor.attestations | object | `{"enabled":true,"url":"file:///var/run/attestations?no_tmp_dir=true"}` | Attestations configuration |
| securesign.rekor.attestations.enabled | bool | true | Enable attestations. |
| securesign.rekor.attestations.url | string | 'file:///var/run/attestations?no_tmp_dir=true' | Url specifies the storage location for attestations, supporting go-cloud blob URLs. url: 'file:///var/run/attestations?no_tmp_dir=true' Url specifies the storage location for attestations, supporting go-cloud blob URLs. The "file:///var/run/attestations" path is specifically for local storage that relies on a mounted Persistent Volume Claim (PVC) for data persistence. Other valid protocols include s3://, gs://, azblob://, and mem://. Examples of valid URLs: - Amazon S3: "s3://my-bucket?region=us-west-1" - S3-Compatible Storage: "s3://my-bucket?endpoint=my.minio.local:8080&s3ForcePathStyle=true" - Google Cloud Storage: "gs://my-bucket" - Azure Blob Storage: "azblob://my-container" - In-memory (for testing/development): "mem://" - Local file system: "file:///var/run/attestations?no_tmp_dir=true" |
| securesign.rekor.backFillRedis | object | `{"enabled":true,"schedule":"0 0 * * *"}` | Redis backfill configuration |
| securesign.rekor.backFillRedis.enabled | bool | true | Enable Redis backfill job. |
| securesign.rekor.backFillRedis.schedule | string | 0 0 * * * (daily at midnight) | Cron schedule for Redis backfill. |
| securesign.rekor.externalAccess | object | `{"enabled":true,"host":""}` | External access configuration for Rekor |
| securesign.rekor.externalAccess.enabled | bool | true | Enable external access to Rekor. |
| securesign.rekor.externalAccess.host | string | '' | Host for external access to Rekor. |
| securesign.rekor.monitoring | object | `{"enabled":false,"tlog":{"enabled":false,"interval":"10m"}}` | Monitoring configuration for Rekor |
| securesign.rekor.monitoring.enabled | bool | false | Enable or disable monitoring for Rekor. |
| securesign.rekor.monitoring.tlog | object | {} | Configuration for Rekor transparency log monitoring |
| securesign.rekor.monitoring.tlog.enabled | bool | false | Enable or disable monitoring for TLog. |
| securesign.rekor.monitoring.tlog.interval | string | 10m | Interval for TLog monitoring. |
| securesign.rekor.pvc | object | `{"accessModes":["ReadWriteOnce"],"name":"","retain":true,"size":"5Gi"}` | Persistent Volume Claim configuration for Rekor |
| securesign.rekor.pvc.accessModes | list | [ReadWriteOnce] | Access modes for the PVC. |
| securesign.rekor.pvc.name | string | '' | Name of the PVC. |
| securesign.rekor.pvc.retain | bool | true | Retain PVC on deletion. |
| securesign.rekor.pvc.size | string | 5Gi | Size of the PVC. |
| securesign.rekor.rekorSearchUI | object | `{"enabled":true,"host":"","replicas":1,"resources":{},"tolerations":{}}` | Rekor Search UI configuration |
| securesign.rekor.rekorSearchUI.enabled | bool | true | Enable or disable Rekor Search UI. |
| securesign.rekor.rekorSearchUI.host | string | '' | Host for external access to Rekor Search UI. |
| securesign.rekor.rekorSearchUI.replicas | int | 1 | Replicas for Rekor Search UI. |
| securesign.rekor.rekorSearchUI.resources | object | {} | Set resources.requests and resources.limits. Per default this block can be omitted. ONLY set this if you know what you are doing. |
| securesign.rekor.rekorSearchUI.tolerations | object | {} | You can configure tolerations of tainted nodes. |
| securesign.rekor.replicas | int | 1 | Replicas for Rekor. |
| securesign.rekor.resources | object | {} | Set resources.requests and resources.limits. Per default this block can be omitted. ONLY set this if you know what you are doing. |
| securesign.rekor.searchIndex.create | bool | true | Define your search index database connection |
| securesign.rekor.searchIndex.provider | string | '' | DB provider. Supported are redis and mysql. IMPORTANT: Provider can only be specified when using external database (trillian.database.create=false) When using managed database (create=true), leave provider unset. |
| securesign.rekor.searchIndex.url | string | '' | DB connection URL. Required when using external database with explicit provider. |
| securesign.rekor.sharding | list | [] | Sharding configuration for Rekor. |
| securesign.rekor.signer | object | `{"keyRef":{},"kms":"secret","passwordRef":{}}` | Signer configuration for Rekor |
| securesign.rekor.signer.keyRef | object | {} | Reference to the signer private key. |
| securesign.rekor.signer.kms | string | secret | Key Management System type. Possible values: secret, kms |
| securesign.rekor.signer.passwordRef | object | {} | OPTIONAL: Password to decrypt the signer private key. |
| securesign.rekor.tolerations | object | {} | You can configure tolerations of tainted nodes. |
| securesign.rekor.treeID | string | '' | ID of Merkle tree in Trillian backend If it is unset, the operator will create new Merkle tree in the Trillian backend |
| securesign.rekor.trillian | object | `{"address":"","port":8091}` | Trillian configuration for Rekor |
| securesign.rekor.trillian.address | string | '' | Address of the Trillian server. |
| securesign.rekor.trillian.port | int | 8091 | Port for Trillian service. |
| securesign.rekor.trustedCA | object | {} | Trusted Certificate Authority configuration for Trillian |
| securesign.syncwave | string | 3 | Syncwave for ArgoCD to manage deployment order. |
| securesign.trillian | object | `{"database":{"create":true,"databaseSecretRef":{},"pvc":{"accessModes":["ReadWriteOnce"],"name":"","retain":true,"size":"5Gi","storageClassName":""},"tls":{}},"maxRecvMessageSize":153600,"monitoring":{"enabled":false},"server":{"replicas":1,"resources":{},"tls":{},"tolerations":{}},"signer":{"replicas":1,"resources":{},"tls":{},"tolerations":{}},"trustedCA":{}}` | Trillian is a transparent, highly scalable and cryptographically verifiable data store |
| securesign.trillian.database | object | `{"create":true,"databaseSecretRef":{},"pvc":{"accessModes":["ReadWriteOnce"],"name":"","retain":true,"size":"5Gi","storageClassName":""},"tls":{}}` | Database configuration for Trillian |
| securesign.trillian.database.create | bool | true | Create database automatically. |
| securesign.trillian.database.databaseSecretRef | object | {} | OPTIONAL: Secret with values to be used to connect to an existing DB or to be used with the creation of a new DB mysql-host: The host of the MySQL server mysql-port: The port of the MySQL server mysql-user: The user to connect to the MySQL server mysql-password: The password to connect to the MySQL server mysql-database: The database to connect to |
| securesign.trillian.database.pvc | object | `{"accessModes":["ReadWriteOnce"],"name":"","retain":true,"size":"5Gi","storageClassName":""}` | PVC configuration for Trillian database |
| securesign.trillian.database.pvc.accessModes | list | [ReadWriteOnce] | Access modes for the PVC. |
| securesign.trillian.database.pvc.name | string | '' | Name of the PVC. |
| securesign.trillian.database.pvc.retain | bool | true | Retain PVC on deletion. |
| securesign.trillian.database.pvc.size | string | 5Gi | Size of the PVC. |
| securesign.trillian.database.pvc.storageClassName | string | '' | Storage class name for the PVC (optional). |
| securesign.trillian.database.tls | object | {} | Configuration for enabling TLS (Transport Layer Security) encryption for managed database. |
| securesign.trillian.maxRecvMessageSize | int | 153600 | MaxRecvMessageSize sets the maximum size in bytes for incoming gRPC messages handled by the Trillian logserver and logsigner |
| securesign.trillian.monitoring | object | `{"enabled":false}` | Monitoring configuration for Trillian |
| securesign.trillian.monitoring.enabled | bool | false | Enable or disable monitoring for Trillian. |
| securesign.trillian.server | object | `{"replicas":1,"resources":{},"tls":{},"tolerations":{}}` | Server configuration for Trillian |
| securesign.trillian.server.replicas | int | 1 | Number of replicas for Trillian server. |
| securesign.trillian.server.resources | object | {} | Set resources.requests and resources.limits. Per default this block can be omitted. ONLY set this if you know what you are doing. |
| securesign.trillian.server.tls | object | {} | Configuration for enabling TLS (Transport Layer Security) encryption for managed server. |
| securesign.trillian.server.tolerations | object | {} | You can configure tolerations of tainted nodes. |
| securesign.trillian.signer | object | `{"replicas":1,"resources":{},"tls":{},"tolerations":{}}` | Signer configuration for Trillian |
| securesign.trillian.signer.replicas | int | 1 | Number of replicas for Trillian signer. |
| securesign.trillian.signer.resources | object | {} | Set resources.requests and resources.limits. Per default this block can be omitted. ONLY set this if you know what you are doing. |
| securesign.trillian.signer.tls | object | {} | Configuration for enabling TLS (Transport Layer Security) encryption for managed signer. |
| securesign.trillian.signer.tolerations | object | {} | You can configure tolerations of tainted nodes. |
| securesign.trillian.trustedCA | object | {} | Trusted Certificate Authority configuration for Trillian |
| securesign.tsa | object | `{"externalAccess":{"enabled":true,"host":""},"maxRequestBodySize":1048576,"monitoring":{"enabled":false},"ntpMonitoring":{"enabled":false},"replicas":1,"resources":{},"signer":{"certificateChain":{"certificateChainRef":{},"intermediateCA":{"intermediateCA":[{"commonName":"tsa.hostname-intermediate","organizationEmail":"jdoe@redhat.com","organizationName":"Red Hat"}],"leafCA":[{"commonName":"tsa.hostname-leaf","organizationEmail":"jdoe@redhat.com","organizationName":"Red Hat"}],"rootCA":[{"commonName":"tsa.hostname-root","organizationEmail":"jdoe@redhat.com","organizationName":"Red Hat"}]}},"file":{},"kms":{},"tink":{}},"tolerations":{},"trustedCA":{}}` | TSA TimestampAuthoritySpec defines the desired state of TimestampAuthority |
| securesign.tsa.externalAccess | object | `{"enabled":true,"host":""}` | External access configuration for TSA |
| securesign.tsa.externalAccess.enabled | bool | true | Enable external access to TSA. |
| securesign.tsa.externalAccess.host | string | '' | Host for external access to TSA. |
| securesign.tsa.monitoring | object | `{"enabled":false}` | Monitoring configuration for TSA |
| securesign.tsa.monitoring.enabled | bool | false | Enable or disable monitoring for TSA. |
| securesign.tsa.ntpMonitoring | object | `{"enabled":false}` | Configuration for NTP monitoring |
| securesign.tsa.ntpMonitoring.enabled | bool | false | Enable or disable monitoring for TSA. |
| securesign.tsa.replicas | int | 1 | Number of replicas for TSA. |
| securesign.tsa.resources | object | {} | Set resources.requests and resources.limits. Per default this block can be omitted. ONLY set this if you know what you are doing. |
| securesign.tsa.signer.certificateChain | object | {} | Certificate chain configuration for TSA signer |
| securesign.tsa.signer.certificateChain.certificateChainRef | object | `{}` | Reference to the secret containing the certificate chain for TSA signer |
| securesign.tsa.signer.certificateChain.intermediateCA.intermediateCA[0] | object | 'tsa.hostname-intermediate' | Common Name for the Intermediate CA. |
| securesign.tsa.signer.certificateChain.intermediateCA.intermediateCA[0].organizationEmail | string | 'jdoe@redhat.com' | Organization Email for the Intermediate CA. |
| securesign.tsa.signer.certificateChain.intermediateCA.intermediateCA[0].organizationName | string | 'Red Hat' | Organization Name for the Intermediate CA. |
| securesign.tsa.signer.certificateChain.intermediateCA.leafCA | list | `[{"commonName":"tsa.hostname-leaf","organizationEmail":"jdoe@redhat.com","organizationName":"Red Hat"}]` | Leaf CA configuration for TSA signer |
| securesign.tsa.signer.certificateChain.intermediateCA.leafCA[0] | object | 'tsa.hostname-leaf' | Common Name for the Leaf CA. |
| securesign.tsa.signer.certificateChain.intermediateCA.leafCA[0].organizationEmail | string | 'jdoe@redhat.com' | Organization Email for the Leaf CA. |
| securesign.tsa.signer.certificateChain.intermediateCA.leafCA[0].organizationName | string | 'Red Hat' | Organization Name for the Leaf CA. |
| securesign.tsa.signer.certificateChain.intermediateCA.rootCA | list | `[{"commonName":"tsa.hostname-root","organizationEmail":"jdoe@redhat.com","organizationName":"Red Hat"}]` | Root CA configuration for TSA signer |
| securesign.tsa.signer.certificateChain.intermediateCA.rootCA[0] | object | 'tsa.hostname-root' | Common Name for the Root CA. |
| securesign.tsa.signer.certificateChain.intermediateCA.rootCA[0].organizationEmail | string | 'jdoe@redhat.com' | Organization Email for the Root CA. |
| securesign.tsa.signer.certificateChain.intermediateCA.rootCA[0].organizationName | string | 'Red Hat' | Organization Name for the Root CA. |
| securesign.tsa.signer.file | object | {} | Configuration for file-based signer |
| securesign.tsa.signer.kms | object | {} | Configuration for KMS-based signer |
| securesign.tsa.signer.tink | object | {} | Configuration for Tink-based signer |
| securesign.tsa.tolerations | object | {} | You can configure tolerations of tainted nodes. |
| securesign.tsa.trustedCA | object | {} | Trusted Certificate Authority configuration for TSA |
| securesign.tuf | object | `{"externalAccess":{"enabled":true,"host":""},"keys":[{"name":"rekor.pub","secretRef":{"key":"","name":""}},{"name":"ctfe.pub","secretRef":{"key":"","name":""}},{"name":"fulcio_v1.crt.pem","secretRef":{"key":"","name":""}},{"name":"tsa.certchain.pem","secretRef":{"key":"","name":""}}],"port":80,"pvc":{"accessModes":["ReadWriteOnce"],"name":"","retain":true,"size":"100Mi"},"replicas":1,"resources":{},"rootKeySecretRef":{"name":"tuf-root-keys"},"tolerations":{}}` | TUF (The Update Framework) provides a secure way to distribute cryptographic keys |
| securesign.tuf.externalAccess | object | `{"enabled":true,"host":""}` | External access configuration for TUF |
| securesign.tuf.externalAccess.enabled | bool | true | Enable external access to TUF. |
| securesign.tuf.externalAccess.host | string | '' | Host for external access to TUF. |
| securesign.tuf.keys | list | `[{"name":"rekor.pub","secretRef":{"key":"","name":""}},{"name":"ctfe.pub","secretRef":{"key":"","name":""}},{"name":"fulcio_v1.crt.pem","secretRef":{"key":"","name":""}},{"name":"tsa.certchain.pem","secretRef":{"key":"","name":""}}]` | List of keys to be managed by TUF List of TUF targets which will be added to TUF root If secretRef is unset, the operator will try to autoconfigure secret reference, by searching secrets in namespace which contain `rhtas.redhat.com/$name` label. |
| securesign.tuf.port | int | 80 | Port for TUF service. |
| securesign.tuf.pvc | object | `{"accessModes":["ReadWriteOnce"],"name":"","retain":true,"size":"100Mi"}` | Persistent Volume Claim configuration for TUF |
| securesign.tuf.pvc.accessModes | list | [ReadWriteOnce] | Access modes for the PVC. |
| securesign.tuf.pvc.name | string | '' | Name of the PVC. |
| securesign.tuf.pvc.retain | bool | true | Retain PVC on deletion. |
| securesign.tuf.pvc.size | string | 100Mi | Size of the PVC. |
| securesign.tuf.replicas | int | 1 | Number of replicas for TUF. |
| securesign.tuf.resources | object | {} | Set resources.requests and resources.limits. Per default this block can be omitted. ONLY set this if you know what you are doing. |
| securesign.tuf.rootKeySecretRef | object | `{"name":"tuf-root-keys"}` | Reference to the secret containing TUF root keys. This secret must exist in the same namespace. |
| securesign.tuf.tolerations | object | {} | You can configure tolerations of tainted nodes. |

## Advanced Configuration

### Search Index Provider

Rekor supports two search index providers (validated at template rendering):

- **redis** (default): In-memory cache, faster but volatile
- **mysql**: Persistent database storage

```yaml
securesign:
  rekor:
    searchIndex:
      enabled: true
      provider: redis  # or mysql
      url: "redis://redis-service:6379"
```

**Validation**: The chart validates that only `redis` or `mysql` is specified:
```
Error: searchIndex.provider must be either 'redis' or 'mysql', got 'invalid'
```

### Custom TUF Keys

Specify keys to be managed by TUF:

```yaml
securesign:
  tuf:
    keys:
      - name: rekor.pub
        secretRef:
          name: rekor-public-key
          key: public
      - name: ctfe.pub
        secretRef:
          name: ctlog-public-key
          key: public
      - name: fulcio_v1.crt.pem
        secretRef:
          name: fulcio-cert
          key: cert
      - name: tsa.certchain.pem
        secretRef:
          name: tsa-cert-chain
          key: chain
```

### TSA Signer Configuration

Configure the Timestamp Authority signer with certificate chains:

```yaml
securesign:
  tsa:
    signer:
      certificateChain:
        intermediateCA:
          intermediateCA:
            - commonName: "tsa-intermediate.example.com"
              organizationEmail: "security@example.com"
              organizationName: "Example Corp"
              privateKeyRef:
                name: tsa-intermediate-key
                key: tls.key
              passwordRef:
                name: tsa-key-password
                key: password
      # Or use file-based signer
      file:
        privateKeyRef:
          name: tsa-file-key
          key: key.pem
        passwordRef:
          name: tsa-file-password
          key: password
      # Or use KMS
      kms:
        keyResource: "projects/my-project/locations/us/keyRings/my-ring/cryptoKeys/my-key"
```

### External Database Configuration

Use an external MySQL database for Trillian:

```yaml
securesign:
  trillian:
    database:
      create: false
      databaseSecretRef:
        name: trillian-db-credentials
        # Secret should contain:
        # mysql-host: database.example.com
        # mysql-port: 3306
        # mysql-user: trillian
        # mysql-password: <password>
        # mysql-database: trillian
```

## Security Considerations

### Secrets Management

RHTAS requires several secrets for proper operation:

- **TUF Root Keys**: Create before deployment
  ```bash
  oc create secret generic tuf-root-keys \
    --from-file=private=tuf-root-private.pem \
    --from-file=public=tuf-root-public.pem \
    -n trusted-artifact-signer
  ```

- **Certificate Private Keys**: For TSA and custom Fulcio certificates
- **Database Credentials**: For external database connections

### Network Policies

Consider implementing network policies to restrict traffic:
- Allow ingress only from authorized sources
- Restrict egress to necessary destinations (OIDC providers, databases)

## Monitoring and Observability

### Prometheus Metrics

Enable monitoring for each component:

```yaml
securesign:
  fulcio:
    externalAccess:
      monitoring:
        enabled: true
  rekor:
    monitoring:
      enabled: true
  trillian:
    monitoring:
      enabled: true
  tsa:
    monitoring:
      enabled: true
```

Metrics endpoints will be exposed on port 9090 for each component.

## Additional Resources

### Documentation

- [Red Hat Trusted Artifact Signer Documentation](https://docs.redhat.com/en/documentation/red_hat_trusted_artifact_signer/)
- [Sigstore Project](https://www.sigstore.dev/)
- [Cosign Documentation](https://docs.sigstore.dev/cosign/overview/)
- [Rekor Documentation](https://docs.sigstore.dev/rekor/overview/)
- [Fulcio Documentation](https://docs.sigstore.dev/fulcio/overview/)

### Related Projects

- [OpenShift GitOps Examples](https://github.com/tjungbauer/openshift-clusterconfig-gitops)
- [RHTAS Operator](https://github.com/securesign/secure-sign-operator)

## License

This Helm chart is licensed under the Apache License 2.0. See the LICENSE file for details.

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
