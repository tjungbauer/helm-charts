{{- define "tpl.tolerations.override" -}}
tolerations:
{{- range . }}
- effect: {{ .effect }}
  key: {{ .key }}
  operator: {{ .operator }}
  value: {{ .value }}
  {{- if .tolerationSeconds }}
  tolerationSeconds: {{ .tolerationSeconds }}
  {{- end }}
{{- end }}
{{- end -}}
