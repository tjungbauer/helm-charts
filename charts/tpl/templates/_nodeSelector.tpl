{{/*
Render a pod or workload nodeSelector block.

Pass the parent values object that contains a nodeSelector field (not the nodeSelector map alone).

Legacy single-label shape (unchanged):
  nodeSelector:
    key: node-role.kubernetes.io/infra
    value: ""

Multi-label shape (Kubernetes map; do not mix with key/value in the same block):
  nodeSelector:
    node-role.kubernetes.io/infra: ""
    topology.kubernetes.io/zone: eu-west-1

Example include:
{{ include "tpl.nodeSelector" .Values | indent 2 }}
*/}}
{{- define "tpl.nodeSelector" -}}
{{- with .nodeSelector }}
nodeSelector:
{{- if .key }}
  {{ .key }}: {{ .value | default "" | quote }}
{{- else }}
{{ toYaml . | indent 2 }}
{{- end }}
{{- end }}
{{- end -}}
