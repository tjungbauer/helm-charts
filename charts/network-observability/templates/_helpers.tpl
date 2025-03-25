{{- /* ──────────────────── RENDER TLS Configuration ──────────────────── */}}
{{- define "tlsConfig" -}}
tls:
  enable: {{ .tls.enable | default false }}
  insecureSkipVerify: {{ .tls.insecureSkipVerify | default false }}
  {{- if eq (.tls.enable | toString ) "true" }}
  userCert:
    certFile: {{ .tls.userCert.certFile | default "" }}
    certKey: {{ .tls.userCert.certKey | default "" }}
    name: {{ .tls.userCert.name | default "" }}
    namespace: {{ .tls.userCert.namespace | default "" }}
    type: {{ .tls.userCert.type | default "" }}
  caCert:
    {{- if eq (.mode) "Monolithic" }}
    file: {{ .tls.caCert.file | default "service-ca.crt" }}
    {{- else }}
    file: {{ .tls.caCert.file | default "" }}
    {{- end }}
    {{- if eq (.mode) "Monolithic" }}
    name: {{ .tls.caCert.name | default "loki-gateway-ca-bundle" }}
    {{- else }}
    name: {{ .tls.caCert.name | default "" }}
    {{- end }}
    namespace: {{ .tls.caCert.namespace | default "" }}
    {{- if eq (.mode) "Monolithic" }}
    type: {{ .tls.caCert.type | default "configmap" }}
    {{- else }}
    type: {{ .tls.caCert.type | default "" }}
    {{- end }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── RENDER TLS Configuration (agent and processor) ──────────────────── */}}
{{- define "tlsMetricsConfig" -}}
tls:
  {{- include "validate.TlsType" .tls.type }}
  type: {{ .tls.type | default "Disabled" }}
  insecureSkipVerify: {{ .tls.insecureSkipVerify | default false }}
  {{- if eq (.tls.type | toString ) "Provided" }}
  provided:
    certFile: {{ .tls.provided.certFile | default "" }}
    certKey: {{ .tls.provided.certKey | default "" }}
    name: {{ .tls.provided.name | default "" }}
    namespace: {{ .tls.provided.namespace | default "" }}
    type: {{ .tls.provided.type | default "" }}
  providedCaFile:
    file: {{ .tls.providedCaFile.file | default "" }}
    name: {{ .tls.providedCaFile.name | default "" }}
    namespace: {{ .tls.providedCaFile.namespace | default "" }}
    type: {{ .tls.providedCaFile.type | default "" }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE various logLevel ──────────────────── */}}
{{- define "validate.logLevel" -}}
  {{- if . }}
  {{- if not 
    ( or 
      (eq . "info")
      (eq . "debug")
      (eq . "trace")
      (eq . "warn")
      (eq . "error")
      (eq . "fatal")
      (eq . "panic")
    ) 
  }}
    {{- fail "loglevel must be either trace, debug, info, warn, error, fatal or panic" }}
  {{- end }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE deploymentModel ──────────────────── */}}
{{- define "validate.deploymentModel" -}}
  {{- $deploymentModel := . | default "" }} 
  {{- if not (or (eq $deploymentModel "Direct") (eq $deploymentModel "Kafka")) }}
    {{- fail "deploymentModel must be either 'Direct' or 'Kafka'" }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE loki.mode ──────────────────── */}}
{{- define "validate.lokiMode" -}}
  {{ $lokiMode := . | default "Monolithic" }}
  {{- if not 
    ( or 
      (eq $lokiMode "LokiStack")
      (eq $lokiMode "Microservices")
      (eq $lokiMode "Monolithic")
      (eq $lokiMode "Manual")
    ) 
  }}
    {{- fail "loki.mode must be either LokiStack, Microservices, Monolithic or Manual" }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE various imagePullPolicy ──────────────────── */}}
{{- define "validate.imagePullPolicy" -}}
  {{ $imagePullPolicy := . | default "IfNotPresent" }}
  {{- if not 
    ( or 
      (eq $imagePullPolicy "Always")
      (eq $imagePullPolicy "IfNotPresent")
      (eq $imagePullPolicy "Never")
    ) 
  }}
    {{- fail "imagePullPolicy must be either Always, IfNotPresent or Never" }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE processor.deduper.mode ──────────────────── */}}
{{- define "validate.deduper" -}}
  {{ $deduper := . | default "Disabled" }}
  {{- if not 
    ( or 
      (eq $deduper "Disabled")
      (eq $deduper "Sample")
      (eq $deduper "Drop")
    ) 
  }}
    {{- fail "deduper.mode must be either Disabled, Sample or Drop" }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE tlsTypes (agent and processor) ──────────────────── */}}
{{- define "validate.TlsType" -}}
  {{- if . }}
  {{- if not 
    ( or 
      (eq . "Disabled")
      (eq . "Provided")
      (eq . "Auto")
    ) 
  }}
    {{- fail "TlsType must be either Disabled, Provided or Auto" }}
  {{- end }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE loki.manual.authToken ──────────────────── */}}
{{- define "validate.authToken" -}}
  {{ $authToken := . | default "Disabled" }}
  {{- if not 
    ( or 
      (eq $authToken "Disabled")
      (eq $authToken "Forward")
      (eq $authToken "Host")
    ) 
  }}
    {{- fail "authToken must be either Disabled, Forward or Host" }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE processor.logTypes ──────────────────── */}}
{{- define "validate.logTypes" -}}
  {{ $logType := . | default "Flows" }}
  {{- if not 
    ( or 
      (eq $logType "Flows")
      (eq $logType "Conversations")
      (eq $logType "EndedConversations")
    ) 
  }}
    {{- fail "logTypes must be either Flows, Conversations, EndedConversations or All" }}
  {{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE agent.eBPF.features ──────────────────── */}}
{{- define "validate.eBPF_Features" -}}

{{- $allowedFeatures := list "PacketDrop" "DNSTracking" "FlowRTT" "NetworkEvents" "PacketTranslation" "EbpfManager" "UDNMapping" }}

{{- if . }}
{{- range . }}
  {{- if not (has . $allowedFeatures) }}
    {{- fail (printf "Invalid feature: %s. Allowed values are: PacketDrop, DNSTracking, FlowRTT, NetworkEvents, PacketTranslation, EbpfManager, UDNMapping" .) }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE agent.eBPF.metrics.disabledAlerts ──────────────────── */}}
{{- define "validate.eBPF_disabledMetricAlerts" -}}

{{- $disabledAlerts := list "NetObservDroppedFlows" }}

{{- if . }}
{{- range . }}
  {{- if not (has . $disabledAlerts) }}
    {{- fail (printf "Invalid array: %s. Allowed values are: NetObservDroppedFlows" .) }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE processor.metrics.disabledAlerts ──────────────────── */}}
{{- define "validate.Processor_disabledMetricAlerts" -}}

{{- $disabledAlerts := list "NetObservNoFlows" "NetObservLokiError" }}

{{- if . }}
{{- range . }}
  {{- if not (has . $disabledAlerts) }}
    {{- fail (printf "Invalid array: %s. Allowed values are: NetObservNoFlows or NetObservLokiError" .) }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- /* ──────────────────── VALIDATE prometheus.querier.mode ──────────────────── */}}
{{- define "validate.prometheusQuerierMode" -}}
  {{ $mode := . | default "Auto" }}
  {{- if not 
    ( or 
      (eq $mode "Auto")
      (eq $mode "Manual")
    ) 
  }}
    {{- fail "prometheus.querier.mode must be either Auto or Manual" }}
  {{- end }}
{{- end }}

