

# rh-build-of-opentelemetry

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.7](https://img.shields.io/badge/Version-1.0.7-informational?style=flat-square)

 

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
| https://charts.stderr.at/ | tpl | ~1.0.31 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <dev@stdin.at> | <https://blog.stderr.at/> |

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
| collector.config.exporters.debug.sampling_initial | int | `5` |  |
| collector.config.exporters.debug.sampling_thereafter | int | `200` |  |
| collector.config.exporters.debug.verbosity | string | `"basic"` |  |
| collector.config.exporters.loki.endpoint | string | `"http://loki-gateway.loki.svc.cluster.local:3100/loki/api/v1/push"` |  |
| collector.config.exporters.loki.labels.resource."k8s.container.name" | string | `"container"` |  |
| collector.config.exporters.loki.labels.resource."k8s.namespace.name" | string | `"namespace"` |  |
| collector.config.exporters.loki.labels.resource."k8s.pod.name" | string | `"pod"` |  |
| collector.config.exporters.otlp/tempo.endpoint | string | `"tempo-gateway.tempo.svc.cluster.local:4317"` |  |
| collector.config.exporters.otlp/tempo.tls.ca_file | string | `"/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"` |  |
| collector.config.exporters.otlp/tempo.tls.insecure | bool | `false` |  |
| collector.config.exporters.prometheusremotewrite.endpoint | string | `"http://prometheus-server.monitoring.svc.cluster.local:9090/api/v1/write"` |  |
| collector.config.exporters.prometheusremotewrite.resource_to_telemetry_conversion.enabled | bool | `true` |  |
| collector.config.processors.batch.send_batch_max_size | int | `2048` |  |
| collector.config.processors.batch.send_batch_size | int | `1024` |  |
| collector.config.processors.batch.timeout | string | `"10s"` |  |
| collector.config.processors.k8sattributes.auth_type | string | `"serviceAccount"` |  |
| collector.config.processors.k8sattributes.extract.metadata[0] | string | `"k8s.namespace.name"` |  |
| collector.config.processors.k8sattributes.extract.metadata[1] | string | `"k8s.deployment.name"` |  |
| collector.config.processors.k8sattributes.extract.metadata[2] | string | `"k8s.pod.name"` |  |
| collector.config.processors.k8sattributes.extract.metadata[3] | string | `"k8s.pod.uid"` |  |
| collector.config.processors.k8sattributes.extract.metadata[4] | string | `"k8s.node.name"` |  |
| collector.config.processors.k8sattributes.passthrough | bool | `false` |  |
| collector.config.processors.memory_limiter.check_interval | string | `"1s"` |  |
| collector.config.processors.memory_limiter.limit_mib | int | `3500` |  |
| collector.config.processors.memory_limiter.spike_limit_mib | int | `512` |  |
| collector.config.processors.resource.attributes[0].action | string | `"insert"` |  |
| collector.config.processors.resource.attributes[0].key | string | `"cluster.name"` |  |
| collector.config.processors.resource.attributes[0].value | string | `"production-cluster"` |  |
| collector.config.processors.resource.attributes[1].action | string | `"insert"` |  |
| collector.config.processors.resource.attributes[1].key | string | `"k8s.cluster.name"` |  |
| collector.config.processors.resource.attributes[1].value | string | `"production-cluster"` |  |
| collector.config.processors.resource.attributes[2].action | string | `"insert"` |  |
| collector.config.processors.resource.attributes[2].key | string | `"deployment.environment"` |  |
| collector.config.processors.resource.attributes[2].value | string | `"production"` |  |
| collector.config.receivers.jaeger.protocols.grpc.endpoint | string | `"0.0.0.0:14250"` |  |
| collector.config.receivers.jaeger.protocols.thrift_http.endpoint | string | `"0.0.0.0:14268"` |  |
| collector.config.receivers.otlp.protocols.grpc.endpoint | string | `"0.0.0.0:4317"` |  |
| collector.config.receivers.otlp.protocols.http.cors.allowed_origins[0] | string | `"https://*.example.com"` |  |
| collector.config.receivers.otlp.protocols.http.endpoint | string | `"0.0.0.0:4318"` |  |
| collector.config.receivers.prometheus.config.scrape_configs[0].job_name | string | `"otel-collector"` |  |
| collector.config.receivers.prometheus.config.scrape_configs[0].scrape_interval | string | `"30s"` |  |
| collector.config.receivers.prometheus.config.scrape_configs[0].static_configs[0].targets[0] | string | `"0.0.0.0:8888"` |  |
| collector.config.service.pipelines.logs.exporters[0] | string | `"loki"` |  |
| collector.config.service.pipelines.logs.processors[0] | string | `"memory_limiter"` |  |
| collector.config.service.pipelines.logs.processors[1] | string | `"k8sattributes"` |  |
| collector.config.service.pipelines.logs.processors[2] | string | `"resource"` |  |
| collector.config.service.pipelines.logs.processors[3] | string | `"batch"` |  |
| collector.config.service.pipelines.logs.receivers[0] | string | `"otlp"` |  |
| collector.config.service.pipelines.metrics.exporters[0] | string | `"prometheusremotewrite"` |  |
| collector.config.service.pipelines.metrics.processors[0] | string | `"memory_limiter"` |  |
| collector.config.service.pipelines.metrics.processors[1] | string | `"resource"` |  |
| collector.config.service.pipelines.metrics.processors[2] | string | `"batch"` |  |
| collector.config.service.pipelines.metrics.receivers[0] | string | `"otlp"` |  |
| collector.config.service.pipelines.metrics.receivers[1] | string | `"prometheus"` |  |
| collector.config.service.pipelines.traces.exporters[0] | string | `"otlp/tempo"` |  |
| collector.config.service.pipelines.traces.processors[0] | string | `"memory_limiter"` |  |
| collector.config.service.pipelines.traces.processors[1] | string | `"k8sattributes"` |  |
| collector.config.service.pipelines.traces.processors[2] | string | `"resource"` |  |
| collector.config.service.pipelines.traces.processors[3] | string | `"batch"` |  |
| collector.config.service.pipelines.traces.receivers[0] | string | `"otlp"` |  |
| collector.config.service.pipelines.traces.receivers[1] | string | `"jaeger"` |  |
| collector.config.service.telemetry.logs.level | string | `"info"` |  |
| collector.config.service.telemetry.metrics.address | string | `"0.0.0.0:8888"` |  |
| collector.config.service.telemetry.metrics.level | string | `"detailed"` |  |
| collector.enabled | bool | `true` |  |
| collector.managementState | string | `"managed"` |  |
| collector.mode | string | `"deployment"` |  |
| collector.name | string | `"otel-collector"` |  |
| collector.nodeSelector."node-role.kubernetes.io/worker" | string | `""` |  |
| collector.replicas | int | `3` |  |
| collector.resources.limits.cpu | int | `2` |  |
| collector.resources.limits.memory | string | `"4Gi"` |  |
| collector.resources.requests.cpu | string | `"500m"` |  |
| collector.resources.requests.memory | string | `"1Gi"` |  |
| collector.serviceAccount.create | bool | `false` |  |
| collector.serviceAccount.name | string | `"otel-collector-sa"` |  |
| collector.tolerations[0].effect | string | `"NoSchedule"` |  |
| collector.tolerations[0].key | string | `"node-role.kubernetes.io/infra"` |  |
| collector.tolerations[0].operator | string | `"Exists"` |  |
| instrumentation.dotnet.env.OTEL_DOTNET_AUTO_METRICS_INSTRUMENTATION_ENABLED | string | `"true"` |  |
| instrumentation.dotnet.env.OTEL_DOTNET_AUTO_TRACES_INSTRUMENTATION_ENABLED | string | `"true"` |  |
| instrumentation.dotnet.env.OTEL_EXPORTER_OTLP_TIMEOUT | string | `"10000"` |  |
| instrumentation.enabled | bool | `true` |  |
| instrumentation.exporter.endpoint | string | `"http://otel-collector.opentelemetry.svc.cluster.local:4318"` |  |
| instrumentation.java.env.OTEL_EXPORTER_OTLP_TIMEOUT | string | `"10000"` |  |
| instrumentation.java.env.OTEL_INSTRUMENTATION_COMMON_PEER_SERVICE_MAPPING | string | `"redis=redis-service,postgresql=postgres-service"` |  |
| instrumentation.java.env.OTEL_LOGS_EXPORTER | string | `"otlp"` |  |
| instrumentation.java.env.OTEL_METRICS_EXPORTER | string | `"otlp"` |  |
| instrumentation.java.env.OTEL_TRACES_EXPORTER | string | `"otlp"` |  |
| instrumentation.name | string | `"otel-instrumentation"` |  |
| instrumentation.nodejs.env.OTEL_EXPORTER_OTLP_TIMEOUT | string | `"10000"` |  |
| instrumentation.nodejs.env.OTEL_NODE_RESOURCE_DETECTORS | string | `"env,host,os,serviceinstance"` |  |
| instrumentation.propagators[0] | string | `"tracecontext"` |  |
| instrumentation.propagators[1] | string | `"baggage"` |  |
| instrumentation.propagators[2] | string | `"b3"` |  |
| instrumentation.propagators[3] | string | `"jaeger"` |  |
| instrumentation.python.env.OTEL_EXPORTER_OTLP_TIMEOUT | string | `"10000"` |  |
| instrumentation.python.env.OTEL_PYTHON_LOGGING_AUTO_INSTRUMENTATION_ENABLED | string | `"true"` |  |
| instrumentation.sampler.argument | string | `"0.25"` |  |
| instrumentation.sampler.type | string | `"parentbased_traceidratio"` |  |
| namespace.create | bool | `true` |  |
| namespace.descr | string | `"Production OpenTelemetry Stack"` |  |
| namespace.display | string | `"OpenTelemetry Observability"` |  |
| namespace.name | string | `"opentelemetry"` |  |
| targetallocator.allocationStrategy | string | `"consistent-hashing"` |  |
| targetallocator.enabled | bool | `true` |  |
| targetallocator.env[0].name | string | `"OTEL_LOG_LEVEL"` |  |
| targetallocator.env[0].value | string | `"info"` |  |
| targetallocator.name | string | `"otel-targetallocator"` |  |
| targetallocator.nodeSelector."node-role.kubernetes.io/worker" | string | `""` |  |
| targetallocator.prometheusCR.enabled | bool | `true` |  |
| targetallocator.prometheusCR.podMonitorSelector.matchExpressions[0].key | string | `"monitoring"` |  |
| targetallocator.prometheusCR.podMonitorSelector.matchExpressions[0].operator | string | `"In"` |  |
| targetallocator.prometheusCR.podMonitorSelector.matchExpressions[0].values[0] | string | `"enabled"` |  |
| targetallocator.prometheusCR.podMonitorSelector.matchExpressions[0].values[1] | bool | `true` |  |
| targetallocator.prometheusCR.scrapeInterval | string | `"30s"` |  |
| targetallocator.prometheusCR.serviceMonitorSelector.matchLabels.prometheus | string | `"kube-prometheus"` |  |
| targetallocator.replicas | int | `2` |  |
| targetallocator.resources.limits.cpu | int | `1` |  |
| targetallocator.resources.limits.memory | string | `"1Gi"` |  |
| targetallocator.resources.requests.cpu | string | `"200m"` |  |
| targetallocator.resources.requests.memory | string | `"256Mi"` |  |
| targetallocator.serviceAccount | string | `"otel-targetallocator-sa"` |  |

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

