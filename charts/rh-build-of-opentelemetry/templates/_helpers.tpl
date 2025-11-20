{{/*
=======================================================
Validation Helpers for OpenTelemetry
=======================================================
These helpers validate configuration values and fail
with clear error messages if invalid values are provided.
*/}}

{{/*
Validate OpenTelemetry Collector mode
Validates that the mode is one of the supported values.

Supported modes:
- deployment: Deploy as Kubernetes Deployment
- daemonset: Deploy as Kubernetes DaemonSet (one pod per node)
- statefulset: Deploy as Kubernetes StatefulSet
- sidecar: Deploy as sidecar container

Usage: include "otel.collectorMode" ".collector.mode"
*/}}
{{- define "otel.collectorMode" -}}
{{- $mode := . -}}
{{- if $mode -}}
  {{- $validModes := list "deployment" "daemonset" "statefulset" "sidecar" -}}
  {{- if not (has $mode $validModes) -}}
    {{- fail (printf "Invalid collector mode: '%s'. Must be one of: %s" $mode (join ", " $validModes)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate OpenTelemetry Collector management state
Validates that the managementState is one of the supported values.

Supported states:
- managed: Operator manages the collector
- unmanaged: Operator does not manage the collector

Usage: include "otel.managementState" ".collector.managementState"
*/}}
{{- define "otel.managementState" -}}
{{- $state := . -}}
{{- if $state -}}
  {{- $validStates := list "managed" "unmanaged" -}}
  {{- if not (has $state $validStates) -}}
    {{- fail (printf "Invalid management state: '%s'. Must be one of: %s" $state (join ", " $validStates)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate OpenTelemetry Instrumentation sampler type
Validates that the sampler type is one of the supported values.

Supported types:
- always_on: Always sample
- always_off: Never sample
- traceidratio: Sample based on trace ID ratio
- parentbased_always_on: Parent-based always on
- parentbased_always_off: Parent-based always off
- parentbased_traceidratio: Parent-based trace ID ratio
- jaeger_remote: Jaeger remote sampler
- xray: AWS X-Ray sampler

Usage: include "otel.samplerType" ".instrumentation.sampler.type"
*/}}
{{- define "otel.samplerType" -}}
{{- $samplerType := . -}}
{{- if $samplerType -}}
  {{- $validTypes := list "always_on" "always_off" "traceidratio" "parentbased_always_on" "parentbased_always_off" "parentbased_traceidratio" "jaeger_remote" "xray" -}}
  {{- if not (has $samplerType $validTypes) -}}
    {{- fail (printf "Invalid sampler type: '%s'. Must be one of: %s" $samplerType (join ", " $validTypes)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate Target Allocator allocation strategy
Validates that the allocation strategy is one of the supported values.

Supported strategies:
- consistent-hashing: Consistent hashing strategy
- least-weighted: Least weighted strategy

Usage: include "otel.allocationStrategy" ".targetallocator.allocationStrategy"
*/}}
{{- define "otel.allocationStrategy" -}}
{{- $strategy := . -}}
{{- if $strategy -}}
  {{- $validStrategies := list "consistent-hashing" "least-weighted" -}}
  {{- if not (has $strategy $validStrategies) -}}
    {{- fail (printf "Invalid allocation strategy: '%s'. Must be one of: %s" $strategy (join ", " $validStrategies)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

