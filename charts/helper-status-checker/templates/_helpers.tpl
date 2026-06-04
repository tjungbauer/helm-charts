{{/*
Argo CD hook metadata for status-checker resources (wraps tpl.argocdMetadata type hook).
Pass dict: values (chart values), check (checks[] item for syncwave).
*/}}
{{- define "helper-status-checker.hookAnnotations" -}}
{{- $values := .values | default dict -}}
{{- $check := .check | default dict -}}
{{- $args := dict
      "type" "hook"
      "syncWave" ($check.syncwave | default 0)
      "extra" ($values.additionalAnnotations | default dict) -}}
{{- with $values.syncOptions }}
{{- $_ := set $args "syncOptions" . }}
{{- end }}
{{- include "tpl.argocdMetadata" $args -}}
{{- end }}

{{/*
Additional labels shared by all status-checker hook resources.
Pass the chart values object.
*/}}
{{- define "helper-status-checker.labels" -}}
{{- include "tpl.additionalLabels" (.additionalLabels | default dict) -}}
{{- end }}
