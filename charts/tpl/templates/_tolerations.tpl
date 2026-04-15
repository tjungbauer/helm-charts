{{/*
Return the range of tolerations if defined.

Example for infrastructure nodes in the values-file:
      tolerations:
        - effect: NoSchedule
          key: infra
          operator: Equal
          value: reserved
        - effect: NoSchedule
          key: dedicated
          operator: Exists
          # value omitted for operator Exists (and when value is empty)

{{ include "tpl.tolerations" . -}}
*/}}

{{- define "tpl.tolerations" -}}
tolerations:
{{- range . }}
- effect: "{{ .effect }}"
  key: "{{ .key }}"
  operator: "{{ .operator }}"
  {{- if and (ne (default "Equal" .operator) "Exists") .value }}
  value: "{{ .value }}"
  {{- end }}
  {{- if .tolerationSeconds }}
  tolerationSeconds: {{ .tolerationSeconds }}
  {{- end }}
{{- end }}
{{- end -}}
