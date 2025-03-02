{{/*
Configure generic additional annotations. Can be used for any object.

Example for values files:
additionalAnnotations:
  myAnnotation1: "annotation 1"
  myAnnotation2: "annotation 2"
     
{{ include "tpl.additionalAnnotations" . -}}
*/}}

{{- define "tpl.additionalAnnotations" -}}
{{- range $key, $value := . }}
{{ $key }}: {{ $value | quote }}
{{- end -}}
{{- end }}
