

# tempo-tracing

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.3](https://img.shields.io/badge/Version-1.0.3-informational?style=flat-square)

 

  ## Description

  Configure the Tempo Operator (distributed tracing).

This Helm chart deploys and configures Grafana Tempo using the Tempo Operator on Kubernetes or OpenShift. Tempo is a high-volume, distributed tracing backend that is cost-effective and requires only object storage to operate.

The chart creates a TempoStack custom resource that is managed by the Tempo Operator, which handles the deployment and lifecycle of all Tempo components including distributors, ingesters, compactors, queriers, and query frontends.

## Prerequisites

### Required

- **Kubernetes** 1.20+ or **OpenShift** 4.10+
- **Tempo Operator** installed in the cluster
  - Install via: OperatorHub (OpenShift) or Operator Lifecycle Manager (OLM)
- **Helm** 3.0+
- **Object Storage** backend configured (S3, Azure Blob Storage, or Google Cloud Storage)
  - With credentials stored in a Kubernetes Secret

### Recommended

- **Prometheus Operator** (for metrics collection)
- **Grafana** (for visualization and dashboards)
- **OpenTelemetry Collector** (for trace collection from applications)

### Validation

The chart includes comprehensive validation for:

- **Storage credential modes**: `static`, `token`, `tokenCCO`
- **Storage types**: `s3`, `azure`, `gcs`
- **Ingress types**: `ingress`, `route`
- **Ingress termination**: `insecure`, `edge`, `passthrough`, `reencrypt`
- **Management states**: `managed`, `unmanaged`
- **Tenant modes**: `openshift`, `static`
- **Authorization permissions**: `read`, `write`
- **Subject kinds**: `user`, `group`
- **Instance address types**: `default`, `podIP`
- **Authorization vs OpenShift mode conflict**: Prevents authorization in OpenShift mode

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.22 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (folder: clusters/management-cluster/setup-tempo-operator)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/tempo-tracing

## Parameters

Verify the subcharts for additional settings:

* [tpl](https://github.com/tjungbauer/helm-charts/tree/main/charts/tpl)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| tempostack-namespace | string | `"tempo2stack-test"` |  |
| tempostack.additionalAnnotations | string | {} | Additional annotations for the TempoStack. |
| tempostack.additionalLabels | object | {} | Additional labels for the TempoStack. |
| tempostack.enabled | bool | false | Enable TempoStack. |
| tempostack.hashRing | object | `{"enabled":false,"memberlist":{"enableIPv6":false,"instanceAddrType":"default"}}` | HashRing defines the spec for the distributed hash ring configuration. |
| tempostack.hashRing.enabled | bool | false | Enabled defines if the hash ring should be enabled. |
| tempostack.hashRing.memberlist | object | {} | Memberlist defines the memberlist configuration for the hash ring. |
| tempostack.hashRing.memberlist.enableIPv6 | bool | false | EnableIPv6 defines if IPv6 should be enabled for the hash ring. |
| tempostack.hashRing.memberlist.instanceAddrType | string | default | InstanceAddrType defines the address type for the hash ring. Valid values: default, podIP - default: Use the default instance address type (default behavior) - podIP: Use the pod IP address for the instance address |
| tempostack.images | object | {} | Images defines the image for each container. |
| tempostack.images.jaegerQuery | string | '' | JaegerQuery defines the tempo-query container image. |
| tempostack.images.oauthProxy | string | '' | OauthProxy defines the oauth-proxy container image. |
| tempostack.images.tempo | string | '' | Tempo defines the tempo container image. |
| tempostack.images.tempoGateway | string | '' | TempoGateway defines the tempo-gateway container image. |
| tempostack.images.tempoGatewayOpa | string | '' | TempoGatewayOpa defines the tempo-gateway-opa container image. |
| tempostack.images.tempoQuery | string | '' | TempoQuery defines the tempo-query container image. |
| tempostack.limits | object | `{"enabled":false,"global":{"ingestion":{"ingestionBurstSizeBytes":"","ingestionRateLimitBytes":"","maxBytesPerTrace":"","maxTracesPerUser":""},"query":{"maxBytesPerTagValues":"","maxSearchDuration":"0s"}}}` | Global is used to define global rate limits. |
| tempostack.limits.enabled | bool | false | Enabled defines if the limits should be enabled. |
| tempostack.limits.global.ingestion | object | {} | Ingestion is used to define ingestion rate limits. If no values are provided, it will output 'ingestion: {}' If values are provided, only the specified values will be included |
| tempostack.limits.global.ingestion.ingestionBurstSizeBytes | string | '' | IngestionBurstSizeBytes defines the maximum local rate-limited sample size per distributor replica in MB. |
| tempostack.limits.global.ingestion.ingestionRateLimitBytes | string | '' | IngestionRateLimitBytes defines the maximum amount of ingested samples per second in MB. |
| tempostack.limits.global.ingestion.maxBytesPerTrace | string | '' | MaxBytesPerTrace defines the maximum size in bytes of a trace. |
| tempostack.limits.global.ingestion.maxTracesPerUser | string | '' | MaxTracesPerUser defines the maximum number of traces per user. |
| tempostack.limits.global.query | object | `{"maxBytesPerTagValues":"","maxSearchDuration":"0s"}` | Query is used to define query rate limits. |
| tempostack.limits.global.query.maxBytesPerTagValues | string | '' | MaxBytesPerTagValues defines the maximum size in bytes of a tag-values query. |
| tempostack.limits.global.query.maxSearchDuration | string | '0s' | MaxSearchDuration defines the maximum allowed time range for a search. If this value is not set, then spec.search.maxDuration is used. |
| tempostack.managementState | string | Managed | ManagementState defines if the CR should be managed by the operator or not. |
| tempostack.name | string | '' | Name of the TempoStack. |
| tempostack.namespace | object | `{"additionalAnnotations":{},"additionalLabels":{},"create":false,"descr":"","display":"","name":"tempo2stack-test"}` | Namespace for the TempoStack. |
| tempostack.namespace.additionalAnnotations | object | {} | Additional annotations for the namespace. |
| tempostack.namespace.additionalLabels | object | {} | Additional labels for the namespace. |
| tempostack.namespace.create | bool | true | Create the namespace for the TempoStack. |
| tempostack.namespace.descr | string | '' | Description of the namespace. |
| tempostack.namespace.display | string | '' | Display name of the namespace. |
| tempostack.namespace.name | string | *tempostack-namespace | Name of the namespace. |
| tempostack.observability | object | `{"enabled":false,"grafana":{"createDatasource":false,"instanceSelector":{"matchExpressions":[]}},"metrics":{"createPrometheusRules":false,"createServiceMonitors":false},"tracing":{"jaeger_agent_endpoint":"localhost:6831","otlp_http_endpoint":"http://localhost:4320","sampling_fraction":""}}` | ObservabilitySpec defines how telemetry data gets handled. |
| tempostack.observability.enabled | bool | true | Enabled defines if the observability should be enabled. |
| tempostack.observability.grafana | object | {} | Grafana defines the grafana configuration. |
| tempostack.observability.grafana.createDatasource | bool | false | CreateDatasource specifies if a Grafana Datasource should be created for Tempo. |
| tempostack.observability.grafana.instanceSelector | object | [] | matchExpressions is a list of label selector requirements. The requirements are ANDed. |
| tempostack.observability.metrics | object | {} | Metrics defines the metrics configuration. |
| tempostack.observability.metrics.createPrometheusRules | bool | false | CreatePrometheusRules specifies if Prometheus rules for alerts should be created for Tempo components. |
| tempostack.observability.metrics.createServiceMonitors | bool | false | CreateServiceMonitors specifies if ServiceMonitors should be created for Tempo components. |
| tempostack.observability.tracing | object | {} | Tracing defines the tracing configuration. |
| tempostack.observability.tracing.jaeger_agent_endpoint | string | 'localhost:6831' | DEPRECATED: JaegerAgentEndpoint defines the Jaeger agent endpoint. |
| tempostack.observability.tracing.otlp_http_endpoint | string | '' | OTLPHttpEndpoint defines the OTLP/http endpoint data gets send to. The default OTLP/http port 4318 collides with the distributor ports, therefore it is recommended to use a different port on the sidecar injected to the Tempo (e.g. 4320). |
| tempostack.observability.tracing.sampling_fraction | string | '' | SamplingFraction defines the sampling ratio. Valid values are 0 to 1. The SamplingFraction has to be defined to enable tracing. |
| tempostack.replicationFactor | int | 1 | The replication factor is a configuration setting that determines how many ingesters need to acknowledge the data from the distributors before accepting a span. |
| tempostack.resources | object | {} | The total amount of resources for Tempo instance. |
| tempostack.resources.claims | list | [] | Claims defines the claims for the Tempo instance. |
| tempostack.resources.limits.memory | string | '2Gi 2000m' | Limits defines the limits for the Tempo instance. |
| tempostack.retention | object | '48h0m0s' | Traces defines retention period. Supported parameter suffixes are "s", "m" and "h". example: 336h default: value is 48h0m0s. |
| tempostack.search.defaultResultLimit | int | '' | Limit used for search requests if none is set by the caller (default: 20) |
| tempostack.search.maxDuration | string | '' | MaxDuration defines the maximum allowed time range for a search. |
| tempostack.search.maxResultLimit | string | '' | MaxResultLimit defines the maximum number of results for a search. If this value is not set, then spec.search.maxResultLimit is used. |
| tempostack.serviceAccount | string | 'tempo-sa' | ServiceAccount defines the service account to use for all tempo components. |
| tempostack.storage | object | `{"secret":{"credentialMode":"static","name":"tempo-s3","type":"s3"},"tls":{"caName":"","certName":"","enabled":false,"minVersion":""}}` | Storage configuration for TempoStack |
| tempostack.storage.secret | object | `{"credentialMode":"static","name":"tempo-s3","type":"s3"}` | Secret configuration for object storage |
| tempostack.storage.secret.credentialMode | string | static | Credential mode for accessing storage Valid values: static, token, tokenCCO |
| tempostack.storage.secret.name | string | tempo-s3 | Name of a secret in the namespace configured for object storage secrets. |
| tempostack.storage.secret.type | string | s3 | Type of object storage backend Valid values: s3 (S3-compatible), azure (Azure Blob Storage), gcs (Google Cloud Storage) |
| tempostack.storage.tls | object | `{"caName":"","certName":"","enabled":false,"minVersion":""}` | TLS configuration for storage connection |
| tempostack.storage.tls.caName | string | '' | CA is the name of a ConfigMap containing a CA certificate (service-ca.crt). It needs to be in the same namespace as the Tempo custom resource. |
| tempostack.storage.tls.certName | string | "" | Cert is the name of a Secret containing a certificate (tls.crt) and private key (tls.key). It needs to be in the same namespace as the Tempo custom resource. |
| tempostack.storage.tls.enabled | bool | false | Enable TLS for storage connection |
| tempostack.storage.tls.minVersion | string | '' | Minimum TLS version (VersionTLS10, VersionTLS11, VersionTLS12, VersionTLS13) |
| tempostack.storageClassName | string | '' | StorageClassName for PVCs used by ingester. Defaults to nil (default storage class in the cluster). |
| tempostack.storageSize | string | 10Gi | Storage size for TempoStack. The size of the persistent volume claim for the Tempo Write-Ahead Logging (WAL). |
| tempostack.template | object | {} | TempoStack component configuration templates Allows customization of individual TempoStack components (gateway, ingester, distributor, etc.) |
| tempostack.template.compactor | object | {} | Compactor defines the tempo compactor component spec. Compacts and deduplicates trace data in object storage |
| tempostack.template.compactor.enabled | bool | false | Enabled defines if the compactor should be enabled. |
| tempostack.template.compactor.podSecurityContext | object | {} | PodSecurityContext defines security context will be applied to all pods of this component. |
| tempostack.template.compactor.replicas | int | 1 | Replicas defines the number of replicas to be created for this component. |
| tempostack.template.compactor.resources | object | {} | Resources defines resources for this component, this will override the calculated resources derived from total |
| tempostack.template.compactor.tolerations | list | [] | Tolerations for compactor pods |
| tempostack.template.distributor | object | {} | Distributor component configuration Receives traces from clients and distributes them to ingesters |
| tempostack.template.distributor.component | object | {} | Component-specific settings for distributor |
| tempostack.template.distributor.component.replicas | int | 1 | Number of distributor replicas |
| tempostack.template.distributor.component.tolerations | list | [] | Tolerations for distributor pods |
| tempostack.template.distributor.enabled | bool | false | Enabled defines if the distributor should be enabled. |
| tempostack.template.distributor.tls | object | {} | TLS defines TLS configuration for distributor receivers |
| tempostack.template.distributor.tls.caName | string | "" | CA is the name of a ConfigMap containing a CA certificate (service-ca.crt). It needs to be in the same namespace as the Tempo custom resource. |
| tempostack.template.distributor.tls.certName | string | "" | Cert is the name of a Secret containing a certificate (tls.crt) and private key (tls.key). It needs to be in the same namespace as the Tempo custom resource. |
| tempostack.template.distributor.tls.enabled | bool | false | Enable TLS for distributor |
| tempostack.template.distributor.tls.minVersion | string | "" | MinVersion defines the minimum acceptable TLS version. |
| tempostack.template.gateway | object | {} | Gateway component configuration The gateway is an optional component that provides a single entry point for trace ingestion |
| tempostack.template.gateway.component | object | `{"podSecurityContext":{},"replicas":1,"resources":{},"tolerations":[]}` | TempoComponentSpec is embedded to extend this definition with further options. |
| tempostack.template.gateway.component.replicas | int | 1 | Replicas defines the number of replicas to be created for this component. |
| tempostack.template.gateway.component.resources | object | {} | Resource requirements for gateway pods |
| tempostack.template.gateway.component.tolerations | list | [] | Tolerations for gateway pods |
| tempostack.template.gateway.enabled | bool | true | Enable the gateway component |
| tempostack.template.gateway.ingress.host | string | '' | Host defines the hostname of the Ingress object. |
| tempostack.template.gateway.ingress.ingressClassName | string | '' | IngressClassName defines the name of an IngressClass cluster resource. Defines which ingress controller serves this ingress resource. |
| tempostack.template.gateway.ingress.termination | string | '' | Termination defines the TLS termination type for OpenShift Routes. Valid values: edge, passthrough, reencrypt - insecure: No TLS termination - edge: TLS termination at the router (default) - passthrough: TLS termination at the backend pod - reencrypt: TLS termination at the router, then re-encrypted to the backend |
| tempostack.template.gateway.ingress.type | string | '' | Type defines the type of Ingress for the Gateway. Valid values: ingress, route, none - ingress: Kubernetes Ingress - route: OpenShift Route |
| tempostack.template.gateway.rbac | bool | false | Enabled defines if the query RBAC should be enabled. |
| tempostack.template.ingester | object | {} | Ingester component configuration Receives traces from distributors and writes them to storage |
| tempostack.template.ingester.enabled | bool | false | Enabled defines if the ingester should be enabled. |
| tempostack.template.ingester.podSecurityContext | object | {} | PodSecurityContext defines security context will be applied to all pods of this component. |
| tempostack.template.ingester.replicas | int | 1 | Number of ingester replicas |
| tempostack.template.ingester.resources | object | {} | Resource requirements for ingester pods |
| tempostack.template.ingester.tolerations | list | [] | Tolerations for ingester pods |
| tempostack.template.querier | object | {} | Querier component configuration Queries trace data from ingesters and object storage |
| tempostack.template.querier.enabled | bool | true | Enabled defines if the querier should be enabled. |
| tempostack.template.querier.podSecurityContext | object | {} | PodSecurityContext defines security context will be applied to all pods of this component. |
| tempostack.template.querier.replicas | int | 1 | Number of querier replicas |
| tempostack.template.querier.resources | object | {} | Resource requirements for querier pods |
| tempostack.template.querier.tolerations | list | [] | Tolerations for querier pods |
| tempostack.template.queryFrontend | object | {} | Query Frontend component configuration Handles query requests and provides the Jaeger Query UI |
| tempostack.template.queryFrontend.component.replicas | int | 1 | Number of query frontend replicas |
| tempostack.template.queryFrontend.component.resources | object | {} | Resource requirements for query frontend pods |
| tempostack.template.queryFrontend.component.tolerations | list | [] | Tolerations for query frontend pods |
| tempostack.template.queryFrontend.jaegerQuery | object | {} | Jaeger Query UI configuration |
| tempostack.template.queryFrontend.jaegerQuery.authentication | object | {} | Authentication defines the options for the oauth proxy used to protect jaeger UI |
| tempostack.template.queryFrontend.jaegerQuery.authentication.enabled | bool | false | Enabled defines if the oauth proxy should be enabled. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.resources | object | {} | Resources defines the resources for the oauth proxy. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.resources.limits | object | {} | Limits defines the limits for the oauth proxy. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.resources.limits.cpu | string | '' | CPU defines the CPU limit for the oauth proxy. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.resources.limits.ephemeral-storage | string | '' | EphemeralStorage defines the ephemeral storage limit for the oauth proxy. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.resources.limits.memory | string | '' | Memory defines the memory limit for the oauth proxy. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.resources.requests | object | {} | Requests defines the requests for the oauth proxy. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.resources.requests.cpu | string | '' | CPU defines the CPU request for the oauth proxy. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.resources.requests.ephemeral-storage | string | '' | EphemeralStorage defines the ephemeral storage request for the oauth proxy. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.resources.requests.memory | string | '' | Memory defines the memory request for the oauth proxy. |
| tempostack.template.queryFrontend.jaegerQuery.authentication.sar | string | `""` | SAR defines the SAR to be used in the oauth-proxy default -- {"namespace": "<tempo_stack_namespace>", "resource": "pods", "verb": "get"} |
| tempostack.template.queryFrontend.jaegerQuery.enabled | bool | true | Enable Jaeger Query UI |
| tempostack.template.queryFrontend.jaegerQuery.findTracesConcurrentRequests | string | '' | FindTracesConcurrentRequests defines the maximum number of concurrent requests for finding traces. |
| tempostack.template.queryFrontend.jaegerQuery.ingress | object | `{"host":"","ingressClassName":"","termination":"","type":""}` | Ingress configuration for Jaeger Query UI |
| tempostack.template.queryFrontend.jaegerQuery.ingress.host | string | '' | Host defines the hostname of the Ingress object. |
| tempostack.template.queryFrontend.jaegerQuery.ingress.ingressClassName | string | '' | IngressClassName defines the name of an IngressClass cluster resource. Defines which ingress controller serves this ingress resource. |
| tempostack.template.queryFrontend.jaegerQuery.ingress.termination | string | '' | Termination defines the TLS termination type for OpenShift Routes. Valid values: edge, passthrough, reencrypt - insecure: No TLS termination - edge: TLS termination at the router (default) - passthrough: TLS termination at the backend pod - reencrypt: TLS termination at the router, then re-encrypted to the backend |
| tempostack.template.queryFrontend.jaegerQuery.ingress.type | string | '' | Type defines the type of Ingress for the Gateway. Valid values: ingress, route, none - ingress: Kubernetes Ingress - route: OpenShift Route |
| tempostack.template.queryFrontend.jaegerQuery.monitorTab | object | {} | MonitorTab defines the monitor tab configuration. |
| tempostack.template.queryFrontend.jaegerQuery.monitorTab.enabled | bool | false | Enabled defines if the monitor tab should be enabled. |
| tempostack.template.queryFrontend.jaegerQuery.monitorTab.prometheusEndpoint | string | '' | PrometheusEndpoint defines the endpoint to the Prometheus instance that contains the span rate, error, and duration (RED) metrics. |
| tempostack.template.queryFrontend.jaegerQuery.monitorTab.redMetricsNamespace | string | '' | RedMetricsNamespace defines the red metrics namespace to be used in the monitor tab. |
| tempostack.template.queryFrontend.jaegerQuery.resources | object | {} | Resource requirements for query frontend pods |
| tempostack.template.queryFrontend.jaegerQuery.servicesQueryDuration | string | '72h0m0s' | ServicesQueryDuration defines how long the services will be available in the services list |
| tempostack.template.queryFrontend.jaegerQuery.tempoQuery | object | {} | TempoQuery defines the tempo-query container image. |
| tempostack.template.queryFrontend.jaegerQuery.tempoQuery.resources | object | {} | Resource requirements for query frontend pods |
| tempostack.tenants.authentication | list | [] | Authentication defines the tempo-gateway component authentication configuration spec per tenant. |
| tempostack.tenants.authentication[0] | object | '' | TenantName defines a human readable, unique name of the tenant. The value of this field must be specified in the X-Scope-OrgID header and in the resources field of a ClusterRole to identify the tenant. |
| tempostack.tenants.authentication[0].oidc | object | {} | Oidc defines the oidc configuration for the tenant. |
| tempostack.tenants.authentication[0].oidc.enabled | bool | false | Enabled OIDC configuration |
| tempostack.tenants.authentication[0].oidc.groupClaim | string | '' | GroupClaim defines the group claim of the oidc provider. |
| tempostack.tenants.authentication[0].oidc.issuerURL | string | '' | IssuerURL defines the issuer url of the oidc provider. |
| tempostack.tenants.authentication[0].oidc.redirectURL | string | '' | RedirectURL defines the redirect url of the oidc provider. |
| tempostack.tenants.authentication[0].oidc.secret | string | '' | Secret defines the secret containing the oidc configuration. |
| tempostack.tenants.authentication[0].oidc.usernameClaim | string | '' | UsernameClaim defines the username claim of the oidc provider. |
| tempostack.tenants.authentication[0].permissions | list | false | Permissions, defines if this tenant has read and write permissions. Permissions can either be "read" or "write" or both. |
| tempostack.tenants.authentication[0].tenantId | string | '' | TenantID defines a universally unique identifier of the tenant. Unlike the tenantName, which must be unique at a given time, the tenantId must be unique over the entire lifetime of the Tempo deployment. Tempo uses this ID to prefix objects in the object storage. |
| tempostack.tenants.authentication[1].permissions | list | [] | Permissions, defines if this tenant has read and write permissions. |
| tempostack.tenants.authorization | object | {} | Authorization defines the authorization configuration for the TempoStack. Configures role-based access control (RBAC) for tenant access IMPORTANT: Authorization cannot be enabled when tenants.mode is set to 'openshift'. In OpenShift mode, authorization is handled by OpenShift OAuth. |
| tempostack.tenants.authorization.enabled | bool | false | Enabled defines if the authorization should be enabled. Must be false when tenants.mode is 'openshift' |
| tempostack.tenants.authorization.roleBindings | list | [] | RoleBindings binds a set of roles to a set of subjects. Multiple role bindings can be defined. |
| tempostack.tenants.authorization.roleBindings[0] | object | '' | Name of the role binding |
| tempostack.tenants.authorization.roleBindings[0].roles | list | [] | Roles lists the names of roles to bind to the subjects. |
| tempostack.tenants.authorization.roleBindings[0].subjects | list | [] | Subjects lists the subjects (users or groups) to bind the roles to. |
| tempostack.tenants.authorization.roleBindings[0].subjects[0] | object | '' | Name of the subject (user or group name) |
| tempostack.tenants.authorization.roleBindings[0].subjects[0].kind | string | 'user' | Kind defines the type of subject. Valid values: user, group - user: Individual user subject - group: Group of users subject |
| tempostack.tenants.authorization.roles | list | [] | Roles defines a set of permissions to interact with a tenant. Multiple roles can be defined with different permissions. |
| tempostack.tenants.authorization.roles[0] | object | '' | Name of the role |
| tempostack.tenants.authorization.roles[0].permissions | list | [] | Permissions defines the permissions granted by this role. Valid values: read, write - read: Read-only access to traces (query operations) - write: Write access to traces (ingestion operations) |
| tempostack.tenants.authorization.roles[0].resources | list | [] | Resources defines the resources that the role has access to. |
| tempostack.tenants.authorization.roles[0].tenants | list | [] | Tenants defines which tenants this role applies to. |
| tempostack.tenants.enabled | bool | true | Enabled defines if the tenants should be enabled. |
| tempostack.tenants.mode | string | openshift | Mode defines the multitenancy mode of the TempoStack. Valid values: openshift, static - openshift: Multi-tenancy mode for OpenShift with authentication via OAuth - static: Static tenant configuration with explicit tenant definitions |
| tempostack.timeout | string | 30s | Timeout configures the same timeout on all components starting at ingress down to the ingester/querier. Timeout configuration on a specific component has a higher precedence. Defaults to 30 seconds. |

## Example settings

```yaml
---
---
tempostack-namespace: &tempostack-namespace tempo2stack-test

tempostack:k.
  enabled: true
  name: tempostack

  managementState: Managed

  namespace:
    create: true
    name: *tempostack-namespace

  storage:
    secret:
      name: tempo-s3
      type: s3
      credentialMode: static

  storageSize: 10Gi
  replicationFactor: 1

  tenants:
    mode: openshift
    enabled: true

    authentication:
      - tenantName: 'dev'
        tenantId: '1610b0c3-c509-4592-a256-a1871353dbfa'
        permissions:
          - read
          - write

      - tenantName: 'prod'
        tenantId: '1610b0c3-c509-4592-a256-a1871353dbfb'
        permissions:
          - write
          - read

  observability:
    enabled: true

    tracing:
      jaeger_agent_endpoint: 'localhost:6831'
      otlp_http_endpoint: 'http://localhost:4320'

  template:
    gateway:
      enabled: true
      rbac: false

      ingress:
        type: 'route'
        termination: 'reencrypt'
      component:
        replicas: 1

    queryFrontend:
      jaegerQuery:
        enabled: true
      component:
        replicas: 1
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
