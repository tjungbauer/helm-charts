{{/*
Render a container resources block (requests and limits).

IMPORTANT — memory and ephemeral-storage units:
  tpl.appendUnit appends "Gi" to values that do not already end with "Gi" or "Mi".
  Prefer explicit quantities in values (8Gi, 512Mi) to avoid surprises.
  Example: memory: 8 renders as 8Gi; ephemeral-storage: 50 renders as 50Gi (not 50Mi).

CPU values are passed through unchanged (e.g. 500m, 2).

Extended resources (GPUs, etc.): use limits.extendedResources / requests.extendedResources
with full Kubernetes resource names as keys, e.g. "nvidia.com/gpu": 1

Example for resources in the values-file:
      resources:
        requests:
          cpu: 4
          memory: 8Gi
          ephemeral-storage: 50Mi
        limits:
          cpu: 8
          memory: 16Gi
          ephemeral-storage: 500Mi
          extendedResources:
            nvidia.com/gpu: 1

{{ include "tpl.resources" . -}}
*/}}

{{- define "tpl.resources" -}}
resources:
  {{- if .limits }}
  limits:
    {{- if .limits.cpu }}
    cpu: {{ .limits.cpu }}
    {{- end }}
    {{- if .limits.memory }}
    {{- $memory := include "tpl.appendUnit" .limits.memory }}
    memory: {{ $memory }}
    {{- end }}
    {{- if index .limits "ephemeral-storage" }}
    {{- $ephemeral_storage := include "tpl.appendUnit" (index .limits "ephemeral-storage") }}
    ephemeral-storage: {{ $ephemeral_storage }}
    {{- end }}
    {{- with .limits.extendedResources }}
    {{- range $name, $qty := . }}
    {{ $name }}: {{ $qty }}
    {{- end }}
    {{- end }}
  {{- end }}
  {{- if .requests }}
  requests:
    {{- if .requests.cpu }}
    cpu: {{ .requests.cpu }}
    {{- end }}
    {{- if .requests.memory }}
    {{- $memory := include "tpl.appendUnit" .requests.memory }}
    memory: {{ $memory }}
    {{- end }}
    {{- if index .requests "ephemeral-storage" }}
    {{- $ephemeral_storage := include "tpl.appendUnit" (index .requests "ephemeral-storage") }}
    ephemeral-storage: {{ $ephemeral_storage }}
    {{- end }}
    {{- with .requests.extendedResources }}
    {{- range $name, $qty := . }}
    {{ $name }}: {{ $qty }}
    {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/*
Append "Gi" when memory or ephemeral-storage has no Gi/Mi suffix.

Only Gi and Mi are treated as complete units; use explicit Ki, G, etc. in values if needed.
*/}}
{{- define "tpl.appendUnit" -}}
{{- $val := printf "%v" . -}}
{{- if or (hasSuffix "Gi" $val) (hasSuffix "Mi" $val) -}}
{{ $val -}}
{{- else -}}
{{- printf "%sGi" $val -}}
{{- end -}}
{{- end -}}
