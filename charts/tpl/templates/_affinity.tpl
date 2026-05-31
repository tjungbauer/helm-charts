{{/*
Render a pod affinity block from values.

Example for values:
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app: my-app
          topologyKey: kubernetes.io/hostname

Example include:
{{- if .Values.affinity }}
{{ include "tpl.affinity" .Values.affinity | indent 6 }}
{{- end }}
*/}}
{{- define "tpl.affinity" -}}
{{- if . }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
