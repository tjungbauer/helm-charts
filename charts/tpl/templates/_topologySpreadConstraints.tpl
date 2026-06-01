{{/*
Render pod topologySpreadConstraints from values.

Example:
{{- if .Values.topologySpreadConstraints }}
{{ include "tpl.topologySpreadConstraints" .Values.topologySpreadConstraints | indent 6 }}
{{- end }}
*/}}
{{- define "tpl.topologySpreadConstraints" -}}
{{- if . }}
topologySpreadConstraints:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
