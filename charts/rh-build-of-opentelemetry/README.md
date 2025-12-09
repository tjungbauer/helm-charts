

# rh-build-of-opentelemetry

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.2](https://img.shields.io/badge/Version-1.0.2-informational?style=flat-square)

 

  ## Description

  Configure Red Hat Build of OpenTelemetry Operator resources (Collector, Instrumentation, TargetAllocator).

This Helm chart deploys and configures **Red Hat Build of OpenTelemetry** resources on OpenShift using the OpenTelemetry Operator. It provides a declarative way to manage:

- **OpenTelemetry Collector** - Vendor-agnostic telemetry data collection
- **Instrumentation** - Automatic instrumentation for multiple languages
- **Target Allocator** - Prometheus target discovery and allocation

## Prerequisites

### Required

- **OpenShift** 4.12+ or **Kubernetes** 1.24+
- **Red Hat Build of OpenTelemetry Operator** installed
  - Install via: OperatorHub (OpenShift) or Operator Lifecycle Manager (OLM)
- **Helm** 3.0+

## Features

### Core Features

- ✅ **OpenTelemetry Collector** - Deploy as deployment, daemonset, statefulset, or sidecar
- ✅ **Auto-Instrumentation** - Support for Java, Node.js, Python, .NET, Go, and Apache HTTPD
- ✅ **Target Allocator** - Prometheus metrics target discovery and distribution
- ✅ **Full Configuration** - Complete control over all resource configurations
- ✅ **OpenShift Compatible** - Tested and optimized for Red Hat OpenShift

### Validation

The chart includes validation for:

- **Collector modes**: `deployment`, `daemonset`, `statefulset`, `sidecar`
- **Management states**: `managed`, `unmanaged`
- **Sampler types**: `always_on`, `always_off`, `traceidratio`, `parentbased_*`, `jaeger_remote`, `xray`
- **Allocation strategies**: `consistent-hashing`, `least-weighted`

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.22 |

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
* <https://github.com/open-telemetry/opentelemetry-operator>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/rh-build-of-opentelemetry

## Parameters

Verify the subcharts for additional settings:

* [tpl](https://github.com/tjungbauer/helm-charts/tree/main/charts/tpl)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| collector.additionalAnnotations | object | {} | Additional annotations for the Collector |
| collector.additionalLabels | object | {} | Additional labels for the Collector |
| collector.config | object | {} | OpenTelemetry Collector configuration |
| collector.enabled | bool | false | Enable OpenTelemetry Collector |
| collector.env | list | [] | Environment variables |
| collector.image | string | `""` | Image configuration |
| collector.managementState | string | managed | Management state (managed/unmanaged) |
| collector.mode | string | deployment | Deployment mode Valid values: deployment, daemonset, statefulset, sidecar |
| collector.name | string | otel-collector | Name of the OpenTelemetry Collector |
| collector.nodeSelector | object | {} | Node selector |
| collector.podSecurityContext | object | {} | Pod Security Context |
| collector.ports | object | {} | Ports configuration |
| collector.replicas | int | 1 | Number of replicas (only for deployment and statefulset modes) |
| collector.resources | object | {} | Resource requirements |
| collector.serviceAccount | string | '' | Service Account |
| collector.syncwave | int | 10 | Sync wave for the OpenTelemetry Collector |
| collector.tolerations | list | [] | Tolerations |
| collector.volumeMounts | list | [] | Volume mounts |
| collector.volumes | list | [] | Volumes |
| instrumentation.additionalAnnotations | object | {} | Additional annotations for Instrumentation |
| instrumentation.additionalLabels | object | {} | Additional labels for Instrumentation |
| instrumentation.apacheHttpd | object | {} | Apache HTTP Server instrumentation configuration |
| instrumentation.apacheHttpd.env | object | {} | Environment variables for Apache HTTP Server instrumentation |
| instrumentation.apacheHttpd.image | string | '' | Image for Apache HTTP Server auto-instrumentation |
| instrumentation.dotnet | object | {} | .NET instrumentation configuration |
| instrumentation.dotnet.env | object | {} | Environment variables for .NET instrumentation |
| instrumentation.dotnet.image | string | '' | Image for .NET auto-instrumentation |
| instrumentation.enabled | bool | false | Enable OpenTelemetry Instrumentation |
| instrumentation.exporter | object | http://otel-collector:4318 | Exporter endpoint |
| instrumentation.go | object | {} | Go instrumentation configuration |
| instrumentation.go.env | object | {} | Environment variables for Go instrumentation |
| instrumentation.go.image | string | '' | Image for Go auto-instrumentation |
| instrumentation.java | object | {} | Java instrumentation configuration |
| instrumentation.java.env | object | {} | Environment variables for Java instrumentation |
| instrumentation.java.image | string | '' | Image for Java auto-instrumentation |
| instrumentation.name | string | otel-instrumentation | Name of the Instrumentation |
| instrumentation.nodejs | object | {} | Node.js instrumentation configuration |
| instrumentation.nodejs.env | object | {} | Environment variables for Node.js instrumentation |
| instrumentation.nodejs.image | string | '' | Image for Node.js auto-instrumentation |
| instrumentation.propagators | list | ["tracecontext", "baggage"] | Propagators |
| instrumentation.python | object | {} | Python instrumentation configuration |
| instrumentation.python.env | object | {} | Environment variables for Python instrumentation |
| instrumentation.python.image | string | '' | Image for Python auto-instrumentation |
| instrumentation.sampler | object | {} | Sampler configuration |
| instrumentation.syncwave | int | 10 | Sync wave for the OpenTelemetry Instrumentation |
| namespace.additionalAnnotations | object | {} | Additional annotations for the namespace |
| namespace.additionalLabels | object | {} | Additional labels for the namespace |
| namespace.create | bool | true | Create the namespace |
| namespace.descr | string | '' | Description of the namespace |
| namespace.display | string | '' | Display name of the namespace |
| namespace.name | string | opentelemetry | Name of the namespace for OpenTelemetry resources |
| targetallocator.additionalAnnotations | object | {} | Additional annotations for Target Allocator |
| targetallocator.additionalLabels | object | {} | Additional labels for Target Allocator |
| targetallocator.allocationStrategy | string | consistent-hashing | Allocation strategy Valid values: consistent-hashing, least-weighted |
| targetallocator.enabled | bool | false | Enable Target Allocator |
| targetallocator.env | list | [] | Environment variables |
| targetallocator.filterStrategy | string | '' | Filter strategy Valid values: relabel-config |
| targetallocator.image | string | '' | Image configuration |
| targetallocator.name | string | otel-targetallocator | Name of the Target Allocator |
| targetallocator.nodeSelector | object | {} | Node selector |
| targetallocator.prometheusCR | object | `{"enabled":true,"podMonitorSelector":{},"scrapeInterval":"30s","serviceMonitorSelector":{}}` | Prometheus CR configuration |
| targetallocator.prometheusCR.enabled | bool | true | Enable Prometheus CR scraping |
| targetallocator.prometheusCR.podMonitorSelector | object | {} | Pod monitor selector |
| targetallocator.prometheusCR.scrapeInterval | string | 30s | Scrape interval |
| targetallocator.prometheusCR.serviceMonitorSelector | object | {} | Service monitor selector |
| targetallocator.replicas | int | 1 | Number of replicas |
| targetallocator.resources | object | {} | Resource requirements |
| targetallocator.serviceAccount | string | '' | Service Account |
| targetallocator.syncwave | int | 10 | Sync wave for the OpenTelemetry Target Allocator |
| targetallocator.tolerations | list | [] | Tolerations |

## Component Details

### OpenTelemetry Collector

The collector receives, processes, and exports telemetry data.

**Deployment Modes:**

1. **Deployment** (default)
   - Stateless collector deployment
   - Horizontal scaling with replicas
   - Best for: General purpose collection

2. **DaemonSet**
   - One collector pod per node
   - Collects node-level metrics
   - Best for: Log collection, node metrics

3. **StatefulSet**
   - Stateful collector with persistent storage
   - Ordered deployment
   - Best for: Buffering, state management

4. **Sidecar**
   - Injected as sidecar container
   - Per-application collection
   - Best for: Application-specific telemetry

**Configuration Example:**

```yaml
collector:
  enabled: true
  mode: deployment  # deployment, daemonset, statefulset, sidecar
  replicas: 2
 
  config:
    receivers:
      otlp:  # OpenTelemetry Protocol
      jaeger:  # Jaeger receiver
      zipkin:  # Zipkin receiver
      prometheus:  # Prometheus scraping
   
    processors:
      batch: {}  # Batching
      memory_limiter: {}  # Memory management
      resource: {}  # Resource attributes
   
    exporters:
      otlp: {}  # OTLP export
      prometheus: {}  # Prometheus export
      logging: {}  # Debug logging
   
    service:
      pipelines:
        traces: {}
        metrics: {}
        logs: {}
```

### Instrumentation

Automatic instrumentation for applications without code changes.

**How It Works:**

1. **Annotation-based Injection**:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    instrumentation.opentelemetry.io/inject-java: "true"
spec:
  # Your deployment spec
```

2. **Namespace-level Injection**:
```yaml
apiVersion: v1
kind: Namespace
metadata:
  annotations:
    instrumentation.opentelemetry.io/inject-java: "true"
```

**Configuration Example:**

```yaml
instrumentation:
  enabled: true
 
  exporter:
    endpoint: http://otel-collector:4318
 
  sampler:
    type: parentbased_traceidratio
    argument: "1.0"  # 100% sampling
 
  java:
    image: custom-java-instrumentation:latest
    env:
      OTEL_EXPORTER_OTLP_TIMEOUT: "10000"
      OTEL_TRACES_EXPORTER: "otlp"
```

### Target Allocator

Distributes Prometheus scrape targets across collector instances.

**Features:**
- Automatic target discovery from ServiceMonitor/PodMonitor
- Consistent hashing for target distribution
- Dynamic reallocation on collector scaling
- Reduces duplicate scraping

**Configuration Example:**

```yaml
targetallocator:
  enabled: true
  replicas: 2
 
  allocationStrategy: consistent-hashing
 
  prometheusCR:
    enabled: true
    scrapeInterval: 30s
   
    serviceMonitorSelector:
      matchLabels:
        team: backend
   
    podMonitorSelector:
      matchLabels:
        monitoring: enabled
```

## Example Configurations

### Example 1: Basic Trace Collection

```yaml
collector:
  enabled: true
  name: traces-collector
  mode: deployment
  replicas: 2
 
  config:
    receivers:
      otlp:
        protocols:
          grpc: {}
          http: {}
   
    processors:
      batch:
        timeout: 1s
        send_batch_size: 1024
   
    exporters:
      otlp:
        endpoint: jaeger-collector:4317
        tls:
          insecure: true
   
    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp]

instrumentation:
  enabled: true
  exporter:
    endpoint: http://traces-collector:4318
  sampler:
    type: always_on
```

### Example 2: DaemonSet for Logs

```yaml
collector:
  enabled: true
  name: logs-collector
  mode: daemonset
 
  volumes:
    - name: varlog
      hostPath:
        path: /var/log
 
  volumeMounts:
    - name: varlog
      mountPath: /var/log
      readOnly: true
 
  config:
    receivers:
      filelog:
        include: [/var/log/pods/*/*/*.log]
        operators:
          - type: json_parser
   
    processors:
      batch: {}
   
    exporters:
      loki:
        endpoint: http://loki:3100/loki/api/v1/push
   
    service:
      pipelines:
        logs:
          receivers: [filelog]
          processors: [batch]
          exporters: [loki]
```

### Example 3: Metrics with Target Allocator

```yaml
collector:
  enabled: true
  name: metrics-collector
  mode: statefulset
  replicas: 3
 
  config:
    receivers:
      prometheus:
        config:
          scrape_configs:
            - job_name: 'otel-collector'
              scrape_interval: 10s
   
    processors:
      batch: {}
   
    exporters:
      prometheusremotewrite:
        endpoint: http://prometheus:9090/api/v1/write
   
    service:
      pipelines:
        metrics:
          receivers: [prometheus]
          processors: [batch]
          exporters: [prometheusremotewrite]

targetallocator:
  enabled: true
  replicas: 2
  allocationStrategy: consistent-hashing
 
  prometheusCR:
    enabled: true
    serviceMonitorSelector:
      matchLabels:
        prometheus: kube-prometheus
```

### Example 4: Production Configuration

```yaml
namespace:
  name: opentelemetry
  create: true
  display: "OpenTelemetry Observability"

collector:
  enabled: true
  name: otel-collector
  mode: deployment
  replicas: 3
 
  serviceAccount: otel-collector-sa
 
  resources:
    limits:
      cpu: 2
      memory: 4Gi
    requests:
      cpu: 500m
      memory: 1Gi
 
  config:
    receivers:
      otlp:
        protocols:
          grpc:
            endpoint: 0.0.0.0:4317
          http:
            endpoint: 0.0.0.0:4318
   
    processors:
      batch:
        timeout: 10s
        send_batch_size: 1024
     
      memory_limiter:
        check_interval: 1s
        limit_mib: 3500
     
      resource:
        attributes:
          - key: cluster.name
            value: production
            action: insert
   
    exporters:
      otlp/tempo:
        endpoint: tempo-gateway:4317
        tls:
          insecure: false
     
      prometheusremotewrite:
        endpoint: http://prometheus:9090/api/v1/write
   
    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: [memory_limiter, batch, resource]
          exporters: [otlp/tempo]
       
        metrics:
          receivers: [otlp]
          processors: [memory_limiter, batch]
          exporters: [prometheusremotewrite]

instrumentation:
  enabled: true
 
  exporter:
    endpoint: http://otel-collector:4318
 
  propagators:
    - tracecontext
    - baggage
    - b3
 
  sampler:
    type: parentbased_traceidratio
    argument: "0.1"  # 10% sampling

targetallocator:
  enabled: true
  replicas: 2
 
  allocationStrategy: consistent-hashing
 
  prometheusCR:
    enabled: true
    scrapeInterval: 30s
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

