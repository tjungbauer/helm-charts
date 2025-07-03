

# network-observability

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 2.0.2](https://img.shields.io/badge/Version-2.0.2-informational?style=flat-square)

 

  ## Description

  Installs and configures OpenShift Network Observability Operator.

This Helm Chart is installing and configuring the Network Observability Operator.
This operator requires some storage to make the logs persistent. This might be Loki (for example using an existing Loki or the Loki Operator) or Kafka.
This charts currently supports the settings for Loki due to my lack of possibility to test with Kafka.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.0 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (for example in the folder clusters/management-cluster/setup-network-observability)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/network-observability

## Parameters

## Values

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| netobserv.additionalAnnotations | object | {} | Additional labels to add to the Keycloak instance as key: value pairs. |
| netobserv.additionalLabels | object | {} | Additional labels to add to the Keycloak instance as key: value pairs. |
| netobserv.deploymentModel | string | Direct | Defines the desired type of deployment for flow processing. Possible values: <br /> <ul> <li>Direct</li> <li>Kafka</li> </ul> |
| netobserv.enabled | bool | false | Enable Network Observability configuration? This will also create the reader/writer rolebanding for multi-tenancy |
| netobserv.namespace | object | `{"create":true,"name":"netobserv"}` | Namespace where Network Observability FlowCollector shall be installed. |
| netobserv.namespace.create | bool | true | Create the namespace if it does not exist. |
| netobserv.namespace.name | string | netobserv | Name of the namespace |
| netobserv.syncwave | int | 10 | Syncwave for the FlowCollector resource. |

### Agent

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| netobserv.agent | object | {} | Agent configuration for flows extraction |
| netobserv.agent.ebpf | object | {} | Settings related to the eBPF-based flow reporter. |
| netobserv.agent.ebpf.cacheActiveTimeout | string | 5s | Active timeout for cache. Is the max period during which the reporter aggregates flows before sending. Increasing `cacheMaxFlows` and `cacheActiveTimeout` can decrease the network traffic overhead and the CPU load, however you can expect higher memory consumption and an increased latency in the flow collection. |
| netobserv.agent.ebpf.cacheMaxFlows | int | 100000 | Maximum number of flows to cache. Is the max number of flows in an aggregate; when reached, the reporter sends the flows. Increasing `cacheMaxFlows` and `cacheActiveTimeout` can decrease the network traffic overhead and the CPU load, however you can expect higher memory consumption and an increased latency in the flow collection. |
| netobserv.agent.ebpf.excludeInterfaces | list | ['lo'] | Interfaces to exclude from the eBPF agent. |
| netobserv.agent.ebpf.features | list | [] | Features to enable for the eBPF agent.<br /> Possible values: <br /> <ul> <li>PacketDrop: Enable the packets drop flows logging feature. This feature requires mounting the kernel debug filesystem, so the eBPF agent pods must run as privileged. If the spec.agent.ebpf.privileged parameter is not set, an error is reported.</li> <li>DNSTracking: Enable the DNS tracking feature.</li> <li>FlowRTT: Enable flow latency (sRTT) extraction in the eBPF agent from TCP traffic.</li> <li>NetworkEvents: Enable the network events monitoring feature, such as correlating flows and network policies. This feature requires mounting the kernel debug filesystem, so the eBPF agent pods must run as privileged. It requires using the OVN-Kubernetes network plugin with the Observability feature. IMPORTANT: This feature is available as a Technology Preview.</li> <li>PacketTranslation: Enable enriching flows with packet translation information, such as Service NAT.</li> <li>EbpfManager: [Unsupported (*)]. Use eBPF Manager to manage network observability eBPF programs. Pre-requisite: the eBPF Manager operator (or upstream bpfman operator) must be installed.</li> <li>UDNMapping: [Unsupported (*)]. Enable interfaces mapping to User Defined Networks (UDN). This feature requires mounting the kernel debug filesystem, so the eBPF agent pods must run as privileged. It requires using the OVN-Kubernetes network plugin with the Observability feature.</li> </ul> |
| netobserv.agent.ebpf.imagePullPolicy | string | IfNotPresent | Image pull policy for the eBPF agent. Can either be:<br /> <ul> <li>Always</li> <li>IfNotPresent</li> <li>Never</li> </ul> |
| netobserv.agent.ebpf.interfaces | list | [] | Interfaces to include for the eBPF agent. If empty, the agent fetches all the interfaces |
| netobserv.agent.ebpf.kafkaBatchSize | int | 0 | Batch size for Kafka. |
| netobserv.agent.ebpf.logLevel | string | info | Log level for the eBPF agent. Can be:<br /> <ul> <li>trace</li> <li>debug</li> <li>info</li> <li>warn</li> <li>error</li> <li>fatal</li> <li>panic</li> </ul> |
| netobserv.agent.ebpf.metrics | object | {} | Defines the eBPF agent configuration regarding metrics. |
| netobserv.agent.ebpf.metrics.disableAlerts | list | [] | Disable alerts for the eBPF agent. Possible values: <br /> <ul> <li>NetObservDroppedFlows: which is triggered when the eBPF agent is missing packets or flows, such as when the BPF hashmap is busy or full, or the capacity limiter is being triggered.</li> </ul> |
| netobserv.agent.ebpf.metrics.server | object | {} | Metrics server endpoint configuration for the Prometheus scraper |
| netobserv.agent.ebpf.metrics.server.port | int | 9400 | The metrics server HTTP port. |
| netobserv.agent.ebpf.metrics.server.tls | object | {} | TLS configuration for the metrics server. |
| netobserv.agent.ebpf.metrics.server.tls.insecureSkipVerify | bool | false | Skip client-side verification of the provided certificate. If set to `true`, the `providedCaFile` field is ignored. |
| netobserv.agent.ebpf.metrics.server.tls.provided | object | {} | TLS configuration when `type` is set to `Provided`. |
| netobserv.agent.ebpf.metrics.server.tls.provided.certFile | string | '' | Path to the certificate file name within the configmap or secret. |
| netobserv.agent.ebpf.metrics.server.tls.provided.certKey | string | '' | Path to the certificate private key within the configmap or secret. |
| netobserv.agent.ebpf.metrics.server.tls.provided.name | string | '' | The name of the secret or configmap containing the certificate and key files. |
| netobserv.agent.ebpf.metrics.server.tls.provided.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.agent.ebpf.metrics.server.tls.provided.type | string | '' | The type for the certificate. Can either be configmap or secret. |
| netobserv.agent.ebpf.metrics.server.tls.providedCaFile | object | {} | Reference to the CA file when `type` is set to `Provided`. |
| netobserv.agent.ebpf.metrics.server.tls.providedCaFile.file | string | '' | File name within the config map or secret. |
| netobserv.agent.ebpf.metrics.server.tls.providedCaFile.name | string | '' | The name of the secret or configmap containing the CA file. |
| netobserv.agent.ebpf.metrics.server.tls.providedCaFile.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.agent.ebpf.metrics.server.tls.providedCaFile.type | string | '' | The type for the CA file. Can either be configmap or secret. |
| netobserv.agent.ebpf.metrics.server.tls.type | string | Disabled | Select the type of TLS configuration for the metrics server. Possible values: <br /> <ul> <li>Disabled: No TLS configuration is provided.</li> <li>Provided: Manually provide cert and key file</li> <li>Auto to use OpenShift auto generated certificate using annotations.</li> </ul> |
| netobserv.agent.ebpf.privileged | bool | false | Enable privileged mode for the eBPF agent. |
| netobserv.agent.ebpf.resources | object | {} | Resources for the eBPF agent. |
| netobserv.agent.ebpf.sampling | int | 50 | Sampling rate for the eBPF agent. Sampling rate of the flow reporter. 100 means one flow on 100 is sent. 0 or 1 means all flows are sampled. |
| netobserv.agent.type | string | eBPF | Type of the agent. |
| netobserv.networkPolicy | object | `{"additionalNamespaces":[],"enable":false}` | NetworkPolicy defines ingress network policy settings for network observability components isolation. |
| netobserv.networkPolicy.additionalNamespaces | list | [] | A list of additional namespaces allowed to connect to the network observability namespace. |
| netobserv.networkPolicy.enable | bool | false | Deploy network polices for the network observability components. |

### Console Plugin

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| netobserv.consolePlugin | object | {} | Console Plugin configuration related to the OpenShift Console integration. |
| netobserv.consolePlugin.advanced | object | {} | Advanced Parameters for the Console Plugin |
| netobserv.consolePlugin.advanced.register | bool | true | Automatically register the Console Plugin with the OpenShift Console |
| netobserv.consolePlugin.advanced.scheduling | object | `{"nodeSelector":{},"tolerations":[]}` | Set placement and tolerations for the consolePlugin |
| netobserv.consolePlugin.advanced.scheduling.nodeSelector | object | {} | Set nodeSelector to place the consolePlugin on specific nodes<br /> nodeSelector:<br />   key: node-role.kubernetes.io/infra<br />   value: '' |
| netobserv.consolePlugin.advanced.scheduling.tolerations | list | [] | Set tolerations for the consolePlugin<br /> tolerations: []<br />   - effect: NoSchedule<br />     key: node-role.kubernetes.io/infra<br />     operator: Equal<br />     value: reserved<br />   - effect: NoExecute<br />     key: node-role.kubernetes.io/infra<br />     operator: Equal<br />     value: reserved<br /> |
| netobserv.consolePlugin.autoscaler | object | {} | Autoscaler configuration for Console Plugin |
| netobserv.consolePlugin.autoscaler.maxReplicas | int | 3 | Maximum number of replicas for the Console Plugin |
| netobserv.consolePlugin.autoscaler.metrics | list | using CPU utilization | Metrics used by the pod autoscaler. See: https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2/ |
| netobserv.consolePlugin.autoscaler.minReplicas | int | 1 | Minimum number of replicas for the Console Plugin |
| netobserv.consolePlugin.autoscaler.status | string | Disabled | Status of the autoscaler, either Disabled or Enabled |
| netobserv.consolePlugin.enabled | bool | true | Enable the console plugin. |
| netobserv.consolePlugin.imagePullPolicy | string | IfNotPresent | Image pull policy Can either be:<br /> <ul> <li>Always</li> <li>IfNotPresent</li> <li>Never</li> </ul> |
| netobserv.consolePlugin.logLevel | string | info | Loglevel for the console plugin backend |
| netobserv.consolePlugin.portNaming | object | {} | Portnameing defines the configuration of the port-to-service name translation |
| netobserv.consolePlugin.portNaming.enable | bool | true | Enable the console plugin port-to-service name translation |
| netobserv.consolePlugin.portNaming.portNames | object | {'3100': loki} | defines additional port names to use in the console, for example, `portNames: {"3100": "loki"}`. |
| netobserv.consolePlugin.quickFilters | list | [] | Quick filters configures quick filters presents for the console plugin. You can define any filter you like, but the following filters are available by default: <ul> <li>Applications: filter flows by the application layer</li> <li>Infrastructure: filter flows by the infrastructure layer</li> <li>Pods network: filter flows by the source and destination kind of Pod</li> <li>Services network: filter flows by the destination kind of Service</li> </ul> It is not recommended to remove the default filters. |
| netobserv.consolePlugin.replicas | int | 1 | Replicas defines the number of replicas (pods) to start. |
| netobserv.consolePlugin.resources | object | {} | Resource requirements for the Console Plugin in terms of compute resources, required by this container. |

### Exporters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| netobserv.exporters | list | [] | additional optional exporters for custom consumption or storage. |
| netobserv.exporters[0] | object | {} | OpenTelemetry configuration, such as the IP address and port to send enriched logs or metrics to. |
| netobserv.exporters[0].openTelemetry.fieldsMapping | list | [] | Custom fields mapping to an OpenTelemetry conformant format. |
| netobserv.exporters[0].openTelemetry.logs | object | `{"enable":true}` | OpenTelemetry configuration for logs. |
| netobserv.exporters[0].openTelemetry.logs.enable | bool | true | Set `enable` to `true` to send logs to an OpenTelemetry receiver. |
| netobserv.exporters[0].openTelemetry.metrics | object | `{"enable":true,"pushTimeInterval":"20s"}` | OpenTelemetry configuration for metrics. |
| netobserv.exporters[0].openTelemetry.metrics.enable | bool | true | Set `enable` to `true` to send metrics to an OpenTelemetry receiver. |
| netobserv.exporters[0].openTelemetry.metrics.pushTimeInterval | string | 20s | Specify how often metrics are sent to a collector. |
| netobserv.exporters[0].openTelemetry.protocol | string | `"grpc"` | Protocol of the OpenTelemetry connection. The available options are `http` and `grpc`. |
| netobserv.exporters[0].openTelemetry.targetHost | string | `""` | Address of the OpenTelemetry receiver. |
| netobserv.exporters[0].openTelemetry.targetPort | string | `""` | Port for the OpenTelemetry receiver. |
| netobserv.exporters[0].openTelemetry.tls | object | {} | TLS configuration for. |
| netobserv.exporters[0].openTelemetry.tls.caCert | object | {} | defines the reference of the certificate for the Certificate Authority. |
| netobserv.exporters[0].openTelemetry.tls.caCert.file | string | 'service-ca.crt' | File name within the config map or secret. |
| netobserv.exporters[0].openTelemetry.tls.caCert.name | string | loki-gateway-ca-bundle | The name of the secret or configmap containing the CA file. |
| netobserv.exporters[0].openTelemetry.tls.caCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.exporters[0].openTelemetry.tls.caCert.type | string | '' | The type for the CA file. Can either be configmap or secret. |
| netobserv.exporters[0].openTelemetry.tls.enable | bool | false | Enable TLS for Loki. |
| netobserv.exporters[0].openTelemetry.tls.insecureSkipVerify | bool | false | Skip verification of the TLS certificate. |
| netobserv.exporters[0].openTelemetry.tls.userCert | object | {} | defines the user certificate reference and is used for mTLS. When you use one-way TLS, you can ignore this property. |
| netobserv.exporters[0].openTelemetry.tls.userCert.certFile | string | '' | defines the path to the certificate file name within the config map or secret. |
| netobserv.exporters[0].openTelemetry.tls.userCert.certKey | string | '' | Path to the certificate private key within the configmap or secret. |
| netobserv.exporters[0].openTelemetry.tls.userCert.name | string | '' | The name of the secret or configmap containing the certificate and key files. |
| netobserv.exporters[0].openTelemetry.tls.userCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.exporters[0].openTelemetry.tls.userCert.type | string | '' | The type for the certificate. Can either be configmap or secret. |
| netobserv.exporters[0].type | string | OpenTelemetry | selects the type of exporters. The available options are `Kafka`, `IPFIX`, and `OpenTelemetry`. NOTE: This chart currently supports OpenTelemetry ONLY |

### loki

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| netobserv.loki | object | {} | Loki client settings |
| netobserv.loki.enable | bool | true | Enable storing flows in Loki. Loki and/or Prometheus can be used. However, not everything is transposable from Loki to Prometheus. Therefor some features of the plugin are disabled as well, if Loki is disabled. If Prometheus and Loki are enabled, then Prometheus will take precedence and Loki is used as a fallback. |
| netobserv.loki.lokiStack | object | `{"name":"netobserv-loki","namespace":""}` | Configuration for LOKI STACK MODE |
| netobserv.loki.lokiStack.name | string | netobserv-loki | Name of an existing LokiStack resource to use. |
| netobserv.loki.lokiStack.namespace | string | '' | Namespace where this `LokiStack` resource is located. If omitted, it is assumed to be the same as `spec.namespace`. |
| netobserv.loki.manual | object | {} | Configuration for MANUAL MODE Loki configuration for `Manual` mode. This is the most flexible configuration. It is ignored for other modes. |
| netobserv.loki.manual.authtoken | string | Disabled | Authtoken describes the way to get a token to authenticate to Loki. Possible values: <br /> <ul> <li>Disabled: No authentication is used.</li> <li>Forward: forwards the user token for authorization.</li> <li>Host: [deprecated] - uses the local pod service account to authenticate to Loki.</li> </ul> |
| netobserv.loki.manual.ingesterUrl | string | 'http://loki:3100/' | URL of the existing Loki distributor. |
| netobserv.loki.manual.querierUrl | string | 'http://loki:3100/' | URL of the Loki query frontend. |
| netobserv.loki.manual.statusTls | object | {} | TLS client configuration for Loki status URL. |
| netobserv.loki.manual.statusTls.caCert | object | {} | defines the reference of the certificate for the Certificate Authority. |
| netobserv.loki.manual.statusTls.caCert.file | string | '' | File name within the config map or secret. |
| netobserv.loki.manual.statusTls.caCert.name | string | '' | The name of the secret or configmap containing the CA file. |
| netobserv.loki.manual.statusTls.caCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.loki.manual.statusTls.caCert.type | string | '' | The type for the CA file. Can either be configmap or secret. |
| netobserv.loki.manual.statusTls.enable | bool | false | Enable TLS for Loki. |
| netobserv.loki.manual.statusTls.insecureSkipVerify | bool | false | Skip verification of the TLS certificate. |
| netobserv.loki.manual.statusTls.userCert | object | {} | defines the user certificate reference and is used for mTLS. When you use one-way TLS, you can ignore this property. |
| netobserv.loki.manual.statusTls.userCert.certFile | string | '' | defines the path to the certificate file name within the config map or secret. |
| netobserv.loki.manual.statusTls.userCert.certKey | string | '' | Path to the certificate private key within the configmap or secret. |
| netobserv.loki.manual.statusTls.userCert.name | string | '' | The name of the secret or configmap containing the certificate and key files. |
| netobserv.loki.manual.statusTls.userCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.loki.manual.statusTls.userCert.type | string | '' | The type for the certificate. Can either be configmap or secret. |
| netobserv.loki.manual.statusUrl | string | '' | specifies the address of the Loki `/ready`, `/metrics` and `/config` endpoints, in case it is different from the Loki querier URL |
| netobserv.loki.manual.tenantID | string | 'netobserv' | Tenant ID (X-Scope-OrgID) for Loki. |
| netobserv.loki.manual.tls | object | {} | TLS configuration for the Loki URL. |
| netobserv.loki.manual.tls.caCert | object | {} | defines the reference of the certificate for the Certificate Authority. |
| netobserv.loki.manual.tls.caCert.file | string | '' | File name within the config map or secret. |
| netobserv.loki.manual.tls.caCert.name | string | '' | The name of the secret or configmap containing the CA file. |
| netobserv.loki.manual.tls.caCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.loki.manual.tls.caCert.type | string | '' | The type for the CA file. Can either be configmap or secret. |
| netobserv.loki.manual.tls.enable | bool | false | Enable TLS for Loki. |
| netobserv.loki.manual.tls.insecureSkipVerify | bool | false | Skip verification of the TLS certificate. |
| netobserv.loki.manual.tls.userCert | object | {} | defines the user certificate reference and is used for mTLS. When you use one-way TLS, you can ignore this property. |
| netobserv.loki.manual.tls.userCert.certFile | string | '' | defines the path to the certificate file name within the config map or secret. |
| netobserv.loki.manual.tls.userCert.certKey | string | '' | Path to the certificate private key within the configmap or secret. |
| netobserv.loki.manual.tls.userCert.name | string | '' | The name of the secret or configmap containing the certificate and key files. |
| netobserv.loki.manual.tls.userCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.loki.manual.tls.userCert.type | string | '' | The type for the certificate. Can either be configmap or secret. |
| netobserv.loki.microservices | object | {} | Configuration for MICROSERVICES MODE |
| netobserv.loki.microservices.ingesterUrl | string | 'http://loki-distributor:3100/' | URL of the existing Loki distributor. |
| netobserv.loki.microservices.querierUrl | string | 'http://loki-query-frontend:3100/' | URL of the Loki query frontend. |
| netobserv.loki.microservices.tenantID | string | 'netobserv' | Tenant ID (X-Scope-OrgID) for Loki. |
| netobserv.loki.microservices.tls | object | {} | TLS configuration for the Loki URL. |
| netobserv.loki.microservices.tls.caCert | object | {} | defines the reference of the certificate for the Certificate Authority. |
| netobserv.loki.microservices.tls.caCert.file | string | '' | File name within the config map or secret. |
| netobserv.loki.microservices.tls.caCert.name | string | '' | The name of the secret or configmap containing the CA file. |
| netobserv.loki.microservices.tls.caCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.loki.microservices.tls.caCert.type | string | '' | The type for the CA file. Can either be configmap or secret. |
| netobserv.loki.microservices.tls.enable | bool | false | Enable TLS for Loki. |
| netobserv.loki.microservices.tls.insecureSkipVerify | bool | false | Skip verification of the TLS certificate. |
| netobserv.loki.microservices.tls.userCert | object | {} | defines the user certificate reference and is used for mTLS. When you use one-way TLS, you can ignore this property. |
| netobserv.loki.microservices.tls.userCert.certFile | string | '' | defines the path to the certificate file name within the config map or secret. |
| netobserv.loki.microservices.tls.userCert.certKey | string | '' | Path to the certificate private key within the configmap or secret. |
| netobserv.loki.microservices.tls.userCert.name | string | '' | The name of the secret or configmap containing the certificate and key files. |
| netobserv.loki.microservices.tls.userCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.loki.microservices.tls.userCert.type | string | '' | The type for the certificate. Can either be configmap or secret. |
| netobserv.loki.mode | string | Monolithic | Mode must be set according to the deployment mode of Loki. Possible values: <br /> <ul> <li>LokiStack: when Loki is managed using the Loki Operator</li> <li>Microservices: when Loki is installed as a microservice, but without the Loki Operator</li> <li>Monolithic: when Loki is installed as a monolithic workload</li> <li>Manual: if none of the options above match</li> </ul> |
| netobserv.loki.monolithic | object | {} | Configuration for MICROSERVICES MODE |
| netobserv.loki.monolithic.tenantID | string | 'netobserv' | Tenant ID (X-Scope-OrgID) for Loki. |
| netobserv.loki.monolithic.tls | object | {} | TLS configuration for the Loki URL. |
| netobserv.loki.monolithic.tls.caCert | object | {} | defines the reference of the certificate for the Certificate Authority. |
| netobserv.loki.monolithic.tls.caCert.file | string | 'service-ca.crt' | File name within the config map or secret. |
| netobserv.loki.monolithic.tls.caCert.name | string | loki-gateway-ca-bundle | The name of the secret or configmap containing the CA file. |
| netobserv.loki.monolithic.tls.caCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.loki.monolithic.tls.caCert.type | string | '' | The type for the CA file. Can either be configmap or secret. |
| netobserv.loki.monolithic.tls.enable | bool | false | Enable TLS for Loki. |
| netobserv.loki.monolithic.tls.insecureSkipVerify | bool | false | Skip verification of the TLS certificate. |
| netobserv.loki.monolithic.tls.userCert | object | {} | defines the user certificate reference and is used for mTLS. When you use one-way TLS, you can ignore this property. |
| netobserv.loki.monolithic.tls.userCert.certFile | string | '' | defines the path to the certificate file name within the config map or secret. |
| netobserv.loki.monolithic.tls.userCert.certKey | string | '' | Path to the certificate private key within the configmap or secret. |
| netobserv.loki.monolithic.tls.userCert.name | string | '' | The name of the secret or configmap containing the certificate and key files. |
| netobserv.loki.monolithic.tls.userCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.loki.monolithic.tls.userCert.type | string | '' | The type for the certificate. Can either be configmap or secret. |
| netobserv.loki.monolithic.url | string | 'http://loki.netobserv.svc:3100/' | URL of the existing Loki distributor. |
| netobserv.loki.readTimeout | string | 30s | Is the maximum console plugin loki query total time limit. A timeout of zero means no timeout. |
| netobserv.loki.writeBatchSize | int | 10485760 | The maximum batch size (in bytes) of Loki logs to accumulate before sending. |
| netobserv.loki.writeBatchWait | string | 1s | The maximum time to wait before sending a Loki batch. |
| netobserv.loki.writeTimeout | string | 10s | The maximum Loki time connection / request limit. A timeout of zero means no timeout. |

### Processor

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| netobserv.processor.addZone | bool | false | Availability zones allows availability zone awareness by labelling flows with their source and destination zones. |
| netobserv.processor.clusterName | string | '' | Cluster name is the name of the cluster to appear in the flows data. This is useful in a multi-cluster context. When using OpenShift, leave empty to make it automatically determined. |
| netobserv.processor.deduper | object | {} | Deduper allows you to sample or drop flows identified as duplicates, in order to save on resource usage. |
| netobserv.processor.deduper.mode | string | Disabled | Set the Processor de-duplication mode. It comes in addition to the Agent-based deduplication because the Agent cannot de-duplicate same flows reported from different nodes.<br /> Possible values: <br /> <ul> <li>Disabled: No de-duplication is performed.</li> <li>Sample: Randomly sample flows to reduce the flow volume.</li> <li>Drop: Drop flows identified as duplicates.</li> </ul> |
| netobserv.processor.filters | list | [] | UNSUPPORTED: Filters lets you define custom filters to limit the amount of generated flows. These filters provide more flexibility than the eBPF Agent filters (in `spec.agent.ebpf.flowFilter`), such as allowing to filter by Kubernetes namespace, but with a lesser improvement in performance |
| netobserv.processor.imagePullPolicy | string | IfNotPresent | Image pull policy Can either be:<br /> <ul> <li>Always</li> <li>IfNotPresent</li> <li>Never</li> </ul> |
| netobserv.processor.logLevel | string | info | Loglevel for the console plugin backend. Can either be:<br /> <ul> <li>trace</li> <li>debug</li> <li>info</li> <li>warn</li> <li>error</li> <li>fatal</li> <li>panic</li> </ul> |
| netobserv.processor.logTypes | string | Flows | Log types defines the desired record types to generate. Possible values are:<br> <ul> <li>Flows to export regular network flows. This is the default.</li> <li>Conversations to generate events for started conversations, ended conversations as well as periodic "tick" updates.</li> <li>EndedConversations to generate only ended conversations events.</li> <li>All to generate both network flows and all conversations events. It is not recommended due to the impact on resources footprint.</li> </ul> |
| netobserv.processor.metrics | object | {} | Metrics define the processor configuration regarding metrics |
| netobserv.processor.metrics.disableAlerts | list | [] | disableAlerts is a list of alerts that should be disabled. Possible values are:<br> <ul> <li>NetObservNoFlows: triggered when no flows are being observed for a certain period.</li> <li>NetObservLokiError: triggered when flows are being dropped due to Loki errors.</li> </ul> |
| netobserv.processor.metrics.includeList | list | [] | s a list of metric names to specify which ones to generate.<br /> The names correspond to the names in Prometheus without the prefix. For example:<br> <ul> <li>namespace_egress_packets_total: shows up as netobserv_namespace_egress_packets_total in Prometheus.</li> </ul> Note that the more metrics you add, the bigger is the impact on Prometheus workload resources. Metrics enabled by default are: `namespace_flows_total`, `node_ingress_bytes_total`, `node_egress_bytes_total`, `workload_ingress_bytes_total`, `workload_egress_bytes_total`, `namespace_drop_packets_total` (when `PacketDrop` feature is enabled), `namespace_rtt_seconds` (when `FlowRTT` feature is enabled), `namespace_dns_latency_seconds` (when `DNSTracking` feature is enabled), `namespace_network_policy_events_total` (when `NetworkEvents` feature is enabled). |
| netobserv.processor.metrics.server | object | {} | Metrics server endpoint configuration for the Prometheus scraper |
| netobserv.processor.metrics.server.port | int | 9401 | The metrics server HTTP port. |
| netobserv.processor.metrics.server.tls | object | {} | TLS configuration for the metrics server. |
| netobserv.processor.metrics.server.tls.insecureSkipVerify | bool | false | Skip client-side verification of the provided certificate. If set to `true`, the `providedCaFile` field is ignored. |
| netobserv.processor.metrics.server.tls.provided | object | {} | TLS configuration when `type` is set to `Provided`. |
| netobserv.processor.metrics.server.tls.provided.certFile | string | '' | Path to the certificate file name within the configmap or secret. |
| netobserv.processor.metrics.server.tls.provided.certKey | string | '' | Path to the certificate private key within the configmap or secret. |
| netobserv.processor.metrics.server.tls.provided.name | string | '' | The name of the secret or configmap containing the certificate and key files. |
| netobserv.processor.metrics.server.tls.provided.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.processor.metrics.server.tls.provided.type | string | '' | The type for the certificate. Can either be configmap or secret. |
| netobserv.processor.metrics.server.tls.providedCaFile | object | {} | Reference to the CA file when `type` is set to `Provided`. |
| netobserv.processor.metrics.server.tls.providedCaFile.file | string | '' | File name within the config map or secret. |
| netobserv.processor.metrics.server.tls.providedCaFile.name | string | '' | The name of the secret or configmap containing the CA file. |
| netobserv.processor.metrics.server.tls.providedCaFile.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.processor.metrics.server.tls.providedCaFile.type | string | '' | The type for the CA file. Can either be configmap or secret. |
| netobserv.processor.metrics.server.tls.type | string | Disabled | Select the type of TLS configuration for the metrics server. Possible values: <br /> <ul> <li>Disabled: No TLS configuration is provided.</li> <li>Provided: Manually provide cert and key file</li> <li>Auto to use OpenShift auto generated certificate using annotations.</li> </ul> |
| netobserv.processor.multiClusterDeployment | bool | false | Multi-cluster deployment. If enabled a clusterName lable will be added to the flow data. |
| netobserv.processor.resources | object | {} | Resource requirements |
| netobserv.processor.subnetLabels | object | `{"customLabels":[]}` | Subnetlabel allows to define custom labels on subnets and IPs or to enable automatic labelling of recognized subnets in OpenShift, which is used to identify cluster external traffic. When a subnet matches the source or destination IP of a flow, a corresponding field is added: `SrcSubnetLabel` or `DstSubnetLabel`. |
| netobserv.processor.subnetLabels.customLabels | list | [] | allows to customize subnets and IPs labelling, such as to identify cluster-external workloads or web services. If you enable `openShiftAutoDetect`, `customLabels` can override the detected subnets in case they overlap. <br />Example<br /> - cidrs:     - "1.2.3.4/32"   name: some-name |

### Prometheus

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| netobserv.prometheus | object | {} | Prometheus defines Prometheus settings, such as querier configuration used to fetch metrics from the Console plugin. |
| netobserv.prometheus.querier | object | {} | Prometheus querying configuration, such as client settings, used in the Console plugin. |
| netobserv.prometheus.querier.enable | bool | true | When `enable` is `true`, the Console plugin queries flow metrics from Prometheus instead of Loki whenever possible. It is enbaled by default: set it to `false` to disable this feature. <br /> The Console plugin can use either Loki or Prometheus as a data source for metrics (see also `spec.loki`), or both.<br /> Not all queries are transposable from Loki to Prometheus. Hence, if Loki is disabled, some features of the plugin are disabled as well,<br /> such as getting per-pod information or viewing raw flows. If both Prometheus and Loki are enabled, Prometheus takes precedence and Loki is used as a fallback for queries that Prometheus cannot handle. If they are both disabled, the Console plugin is not deployed. |
| netobserv.prometheus.querier.manual | object | {} | Prometheus configuration for Manual mode. |
| netobserv.prometheus.querier.manual.forwardUserToken | bool | false | Set `true` to forward logged in user token in queries to Prometheus |
| netobserv.prometheus.querier.manual.tls | object | {} | TLS configuration for. |
| netobserv.prometheus.querier.manual.tls.caCert | object | {} | defines the reference of the certificate for the Certificate Authority. |
| netobserv.prometheus.querier.manual.tls.caCert.file | string | 'service-ca.crt' | File name within the config map or secret. |
| netobserv.prometheus.querier.manual.tls.caCert.name | string | loki-gateway-ca-bundle | The name of the secret or configmap containing the CA file. |
| netobserv.prometheus.querier.manual.tls.caCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.prometheus.querier.manual.tls.caCert.type | string | '' | The type for the CA file. Can either be configmap or secret. |
| netobserv.prometheus.querier.manual.tls.enable | bool | false | Enable TLS for Loki. |
| netobserv.prometheus.querier.manual.tls.insecureSkipVerify | bool | false | Skip verification of the TLS certificate. |
| netobserv.prometheus.querier.manual.tls.userCert | object | {} | defines the user certificate reference and is used for mTLS. When you use one-way TLS, you can ignore this property. |
| netobserv.prometheus.querier.manual.tls.userCert.certFile | string | '' | defines the path to the certificate file name within the config map or secret. |
| netobserv.prometheus.querier.manual.tls.userCert.certKey | string | '' | Path to the certificate private key within the configmap or secret. |
| netobserv.prometheus.querier.manual.tls.userCert.name | string | '' | The name of the secret or configmap containing the certificate and key files. |
| netobserv.prometheus.querier.manual.tls.userCert.namespace | string | '' | Namespace of the configmap or secret. |
| netobserv.prometheus.querier.manual.tls.userCert.type | string | '' | The type for the certificate. Can either be configmap or secret. |
| netobserv.prometheus.querier.manual.url | string | 'http://prometheus:9090' | `url` is the address of an existing Prometheus service to use for querying metrics. |
| netobserv.prometheus.querier.mode | string | Auto | must be set according to the type of Prometheus installation that stores network observability metrics: <ul> <li>Auto: Try to configure it autoamtically</li> <li>Manual: for manual setup</li> </ul> |
| netobserv.prometheus.querier.timeout | string | 30s | Timeout  is the read timeout for console plugin queries to Prometheus. A timeout of zero means no timeout. |

## Example values

The following shows the values for the Network Pbservability operator itself.

```yaml
---
namespace: &namespace netobserv

# Network Observability settings.
netobserv:
  # -- Enable Network Observability configuration?
  # This will also create the reader/writer rolebanding for multi-tenancy
  # @default -- false
  enabled: true

  # -- Namespace where Network Observability FlowCollector shall be installed.
  # @default -- 'netobserv'
  namespace: *namespace

  # -- Defines the desired type of deployment for flow processing.
  deploymentModel: Direct

  # -- Loki client settings
  loki:
    # -- Enable storing flows in Loki.
    enable: true

    # -- Mode must be set according to the deployment mode of Loki.
    mode: LokiStack

    # -- Configuration for LOKI STACK MODE
    lokiStack:
      name: netobserv-loki

  # -- Console Plugin configuration related to the OpenShift Console integration.
  consolePlugin:
    enable: true

    # -- Quick filters configures quick filters presents for the console plugin.
    quickFilters:
      - default: true
        filter:
          flow_layer: '"app"'
        name: Applications
      - filter:
          flow_layer: '"infra"'
        name: Infrastructure
      - default: true
        filter:
          dst_kind: '"Pod"'
          src_kind: '"Pod"'
        name: Pods network
      - filter:
          dst_kind: '"Service"'
        name: Services network

    # -- Advanced Parameters for the Console Plugin
    advanced:
      # -- Set placement and tolerations for the consolePlugin
      scheduling:
        # -- Set nodeSelector to place the consolePlugin on specific nodes
        # @default -- {}
        # nodeSelector:
        #   key: node-role.kubernetes.io/infra
        #   value: ''

        # -- Set tolerations for the consolePlugin
        # @default -- []
        # tolerations:
        #   - effect: NoSchedule
        #     key: node-role.kubernetes.io/infra
        #     operator: Equal
        #     value: reserved
        #   - effect: NoExecute
        #     key: node-role.kubernetes.io/infra
        #     operator: Equal
        #     value: reserved
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
