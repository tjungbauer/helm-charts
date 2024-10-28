

# openshift-logging

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 3.0.0](https://img.shields.io/badge/Version-3.0.0-informational?style=flat-square)

 

  ## Description

  Deploy and configure OpenShift Logging based on LokiStack

This Helm Chart is installing and configuring OpenShift Logging.

**WARNING**: With the chart version 3, OpenShift Logging Version 6 is supported and should be used for new deployments. It drops the old ClusterLogging and ClusterLogForwarder resources and instead,
defines a ClusterlogForwarder resource, where everything can be configured. Moreover, the UI Plugin has been shifted to the *Cluster Observability Operator* which means that an additional Operator
has to be deployed and configured to enable the UI Plugin.

The values file *values-v5.0.yaml* provides an example for (old) version 5.x.

The values file *values-v6.0.yaml* provides an example for (new) version 6.x.

**NOTE**: OpenShift Logging using EFK stack (Elasticsearch, Kibana and Fluentd) is considered as deprecated and has been removed from this Chart. Instead, LokiStack with Vector
should be used.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.0 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (for example in the folder clusters/management-cluster/setup-openshift-logging)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/openshift-logging

## Parameters

Verify the subcharts for additional settings:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)
* [helper-lokistack](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-lokistack)

## Values

### OpenShift Logging 6.0

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| loggingConfig.additionalClusterRoles | list | N/A | Additional ClusterRoles and ClusterRoleBindings that shall be created. These Roles and Bindings allow the ServiceAccount to write logs into Loki |
| loggingConfig.collector.resources.limits | object | N/A | LIMITS for CPU, memory and storage |
| loggingConfig.collector.resources.requests | object | N/A | REQUESTS for CPU, memory and storage |
| loggingConfig.collector.tolerations | list | N/A | Define the tolerations the collector Pods will accept |
| loggingConfig.collectorLogLevel | string | off | Specify the log level of the collector. Valid values are: trace, debug, info, warn, error and off |
| loggingConfig.collectorServiceAccount | object | `{"bindings":["collect-audit-logs","collect-application-logs","collect-infrastructure-logs"],"create":false,"name":"cluster-logging-operator"}` | Service Account that shall be used for logging and is used by the collector pods |
| loggingConfig.collectorServiceAccount.bindings | list | N/A | List of default bindings for this ServiceAccount. Administrators have to explicitly grant log collection permissions to the ServiceAccount. Three base roles that can be bound to exist:<br /> <ul> <li>collect-audit-logs ... To collect audit logs</li> <li>collect-application-logs ... To collector application logs</li> <li>collect-infrastructure-logs ... To collect infrastructure logs</li> </ul> |
| loggingConfig.collectorServiceAccount.create | bool | false | Shall we create the ServiceAccount. cluster-logging-operator is typically deployed by the OpenShift Logging operator once it has been deployed. |
| loggingConfig.collectorServiceAccount.name | string | cluster-logging-operator | Name of the ServiceAccount for the collector |
| loggingConfig.outputs[0] | object | empty | EXAMPLE: LokiStack inside OpenShift Name used to refer to the output from a `pipeline`. |

### Generic Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| loggingConfig.enabled | bool | false | Enable openshift logging configuration |
| loggingConfig.managementState | string | Managed | Indicator if the resource is 'Managed' or 'Unmanaged' by the operator. This allows administrators to temporarily pause log forwarding by setting. |
| loggingConfig.operatorVersion | string | N/A | Defines if we are going to deploy openshift logging verison 6.x. This changes the possible settings and resources. |
| loggingConfig.syncwave | string | 4 | Syncwave for the ClusterLogging resource |

### OpenShift Logging 6.0 - Filters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| loggingConfig.filters | list | `[{"name":"detectexception","type":"detectMultilineException"},{"name":"parse-json","type":"parse"}]` | Transform or drop log messages in the pipeline. Users can define filters that match certain log fields and drop or modify the messages. Filters are applied in the order specified in the pipeline. |
| loggingConfig.filters[0] | object | `{"name":"detectexception","type":"detectMultilineException"}` | Name used to refer to the filter from a "pipeline". |
| loggingConfig.filters[0].type | string | `"detectMultilineException"` | Type of filter. |
| loggingConfig.filters[1].type | string | `"parse"` | Type of filter. |

### OpenShift Logging 5.0

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| loggingConfig.logStore | object | N/A | Parameters that are required for OpenShift Logging Version 5.x |
| loggingConfig.logStore.collection.resources | object | N/A | The resource requirements for the collector. Set this only when you know what you are doing |
| loggingConfig.logStore.collection.resources.limits | object | N/A | LIMITS for CPU, memory and storage |
| loggingConfig.logStore.collection.resources.requests | object | N/A | REQUESTS for CPU, memory and storage |
| loggingConfig.logStore.collection.tolerations | list | N/A | Define the tolerations the collector Pods will accept |
| loggingConfig.logStore.collection.type | string | vector | The type of Log Collection to configure Vector in case of Loki. |
| loggingConfig.logStore.lokistack | string | logging-loki | Name of the LokiStack resource. |
| loggingConfig.logStore.type | string | `"lokistack"` | The Type of Log Storage to configure. The operator currently supports either using ElasticSearch managed by elasticsearch-operator or Loki managed by loki-operator (LokiStack) as a default log store. However, Elasticsearch is deprecated and should not be used here ... it would result in an error |
| loggingConfig.logStore.visualization.ocpConsole.logsLimit | int | none | LogsLimit is the max number of entries returned for a query. |
| loggingConfig.logStore.visualization.ocpConsole.timeout | string | none | Timeout is the max duration before a query timeout |
| loggingConfig.logStore.visualization.tolerations | list | N/A | Define the tolerations the visualisation Pod will accept |
| loggingConfig.logStore.visualization.type | string | ocp-console | The type of Visualization to configure Could be either Kibana (deprecated) or ocp-console |

### OpenShift Logging 6.0 - Outputs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| loggingConfig.outputs | list | N/A | Define destinations to forward logs to. Each output has a unique name and type-specific configuration. The outputs sections will be handed-over 1:1 to the Helm tamplte.<br /> Each output must have a unique name and a type. Supported types are:<br /> <ul> <li> azureMonitor <li> Forwards logs to Azure Monitor. <li> cloudwatch: Forwards logs to AWS CloudWatch. </li> <li> elasticsearch: Forwards logs to an external Elasticsearch instance. </li> <li> googleCloudLogging: Forwards logs to Google Cloud Logging. </li> <li> http: Forwards logs to a generic HTTP endpoint. </li> <li> kafka: Forwards logs to a Kafka broker. </li> <li> loki: Forwards logs to a Loki logging backend. </li> <li> lokistack: Forwards logs to the logging supported combination of Loki and web proxy with OpenShift Container Platform authentication integration. LokiStack’s proxy uses OpenShift Container Platform authentication to enforce multi-tenancy </li> <li> otlp: Forwards logs using the OpenTelemetry Protocol. </li> <li> splunk: Forwards logs to Splunk. </li> <li> syslog: Forwards logs to an external syslog server. </li> </ul> Each output type has its own configuration fields. |
| loggingConfig.outputs[0].lokiStack.authentication | object | `{"token":{"from":"serviceAccount"}}` | Authentication sets credentials for authenticating the requests. |
| loggingConfig.outputs[0].lokiStack.authentication.token | object | `{"from":"serviceAccount"}` | Token specifies a bearer token to be used for authenticating requests. |
| loggingConfig.outputs[0].lokiStack.authentication.token.from | string | `"serviceAccount"` | From is the source from where to find the token. Either serviceAccount or secret. |
| loggingConfig.outputs[0].lokiStack.target | object | `{"name":"logging-loki","namespace":"openshift-logging"}` | Target points to the LokiStack resources that should be used as a target for the output. |
| loggingConfig.outputs[0].lokiStack.target.name | string | `"logging-loki"` | Name of the in-cluster LokiStack resource. |
| loggingConfig.outputs[0].lokiStack.target.namespace | string | openshift-logging | Namespace of the in-cluster LokiStack resource. |
| loggingConfig.outputs[0].lokiStack.tuning | object | `{"compression":"gzip","deliveryMode":"AtLeastOnce","maxRetryDuration":5,"minRetryDuration":5}` | Tuning specs tuning for the output |
| loggingConfig.outputs[0].lokiStack.tuning.compression | string | `"gzip"` | The compression algorithm to use to compress the data before sending over the network.<br /> *NOTE*: An output type may not support all available compression options or compression. |
| loggingConfig.outputs[0].lokiStack.tuning.deliveryMode | string | `"AtLeastOnce"` | The mode for log forwarding.<br /> <b>AtLeastOnce</b> (default): The forwarder will block in an attempt to deliver all messages. When the tuning spec is added to an output, this additionally configures an internal, durable buffer so the collector can attempt to forward any logs read before it restarted<br /> <b>AtMostOnce</b>: The forwarder may provide better throughput but also may drop logs in the event of spikes in volume and backpressure from the output. Undelivered, collected logs will be lost on collector restart.<br /> <b>NOTE</b>: Log collection and forwarding is best effort. AtLeastOnce delivery mode does not guarantee logs will not be lost. |
| loggingConfig.outputs[0].lokiStack.tuning.maxRetryDuration | int | `5` | The maximum time to wait between retry attempts after a delivery failure. |
| loggingConfig.outputs[0].lokiStack.tuning.minRetryDuration | int | `5` | The minimum time to wait between attempts to retry after a delivery failure. |
| loggingConfig.outputs[0].tls | object | `{"ca":{"configMapName":"openshift-service-ca.crt","key":"service-ca.crt"}}` | Define TLS to connect to the (internal) Loki store. |
| loggingConfig.outputs[0].type | string | `"lokiStack"` | Type of output sink. |

### OpenShift Logging 6.0 - Pipelines

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| loggingConfig.pipelines | list | `[{"filterRefs":["detectexception","parse-json"],"inputRefs":["application","infrastructure","audit"],"name":"default-lokistack","outputRefs":["default-lokistack"]}]` | Define the path logs take from inputs, through filters, to outputs. Pipelines have a unique name and consist of a list of input, output and filter names. |
| loggingConfig.pipelines[0] | object | `{"filterRefs":["detectexception","parse-json"],"inputRefs":["application","infrastructure","audit"],"name":"default-lokistack","outputRefs":["default-lokistack"]}` | Name of the pipeline |
| loggingConfig.pipelines[0].filterRefs | list | `["detectexception","parse-json"]` | Filters lists the names of filters to be applied to records going through this pipeline. |
| loggingConfig.pipelines[0].inputRefs | list | `["application","infrastructure","audit"]` | InputRefs lists the names (`input.name`) of inputs to this pipeline.  The following built-in input names are always available:<br/> <ul> <li>`application` selects all logs from application pods.</li> <li>`infrastructure` selects logs from openshift and kubernetes pods and some node logs.</li> <li>`audit` selects node logs related to security audits.</li> |
| loggingConfig.pipelines[0].outputRefs | list | `["default-lokistack"]` | OutputRefs lists the names (`output.name`) of outputs from this pipeline. |

## Example values OpenShift Logging 6.0

```yaml
---
loggingConfig:
  enabled: true

  syncwave: '4'

  operatorVersion: '6.0'

  managementState: Managed

  collectorServiceAccount:
    name: cluster-logging-operator
    create: false
    bindings:
      - collect-audit-logs
      - collect-application-logs
      - collect-infrastructure-logs

  additionalClusterRoles:
    - type: application
      name: cluster-logging-write-application-logs
      enabled: true
    - type: audit
      name: cluster-logging-write-audit-logs
      enabled: true
    - type: infrastructure
      name: cluster-logging-write-infrastructure-logs
      enabled: true
    - type: editor
      name: clusterlogforwarder-editor-role
      enabled: true

  outputs:
    - name: default-lokistack
      type: lokiStack
      tls:
        ca:
          configMapName: openshift-service-ca.crt
          key: service-ca.crt
     
      lokiStack:
        authentication:
          token:
            from: serviceAccount

        target:
          name: logging-loki
          namespace: openshift-logging

  pipelines:
    - name: default-lokistack
      inputRefs:
        - application
        - infrastructure
        - audit
      outputRefs:
        - default-lokistack
      filterRefs:
        - detectexception
        - parse-json

  filters:
  - name: detectexception
    type: detectMultilineException
  - name: parse-json
    type: parse
```

## Example values OpenShift Logging 5.0

```yaml
---
loggingConfig:
  enabled: true

  logStore:
    type: lokistack
    lokistack: logging-loki

    visualization:
      type: ocp-console   

    collection:
      type: vector
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
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
