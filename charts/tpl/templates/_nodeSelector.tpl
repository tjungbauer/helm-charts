{{/*
Set a nodeSelector

Example for resources in the values-file:
      nodeSelector:
        key: node-role.kubernetes.io/infra
        value: ''
     
{{ include "tpl.nodeSelector" . -}}
*/}}

{{- define "tpl.nodeSelector" -}}
  {{- if .nodeSelector }}
  nodeSelector:
    {{ .nodeSelector.key }}: {{ .nodeSelector.value | quote }}
  {{- end }}
{{- end -}}
