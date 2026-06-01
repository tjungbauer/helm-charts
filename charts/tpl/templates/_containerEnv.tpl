{{/*
Render container env or envFrom blocks from values (pass-through YAML).

Example:
containers:
  - name: app
    image: my/image:tag
{{- if .Values.env }}
{{ include "tpl.env" .Values.env | indent 4 }}
{{- end }}
{{- if .Values.envFrom }}
{{ include "tpl.envFrom" .Values.envFrom | indent 4 }}
{{- end }}
*/}}
{{- define "tpl.env" -}}
{{- if . }}
env:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}

{{- define "tpl.envFrom" -}}
{{- if . }}
envFrom:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
