{{/*
Configure generic additional label. Can be used for any object.

Example for values files:
additionalLabels:
  myLabel1: "label 1"
  myLabel2: "label 2"
     
{{ include "tpl.additionalLabels" . -}}
*/}}

{{- define "tpl.additionalLabels" -}}
{{- range $key, $value := . }}
{{ $key }}: {{ $value | quote }}
{{- end -}}
{{- end }}
