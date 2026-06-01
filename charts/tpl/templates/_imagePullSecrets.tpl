{{/*
Render pod imagePullSecrets.

Pass a list of secret names (strings) or objects with a name field.

Example:
{{- if .Values.imagePullSecrets }}
{{ include "tpl.imagePullSecrets" .Values.imagePullSecrets | indent 6 }}
{{- end }}
*/}}
{{- define "tpl.imagePullSecrets" -}}
{{- if . }}
imagePullSecrets:
{{- range . }}
  - name: {{ if kindIs "string" . }}{{ . | quote }}{{ else }}{{ required "imagePullSecret entry requires name" .name | quote }}{{ end }}
{{- end }}
{{- end }}
{{- end -}}
