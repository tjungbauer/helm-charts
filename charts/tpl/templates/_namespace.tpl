{{/*
Create a Namespace

Example for resources in the values-file:
namespace:
  create: true
  name: "test-namespace"
  description: "Test Namespace"
  displayName: "Test Namespace"
  additionalAnnotations:
    test-annotation: "test-annotation"
  additionalLabels:
    test-label: "test-label"

Example include:
{{- if .Values.namespace }}
{{- if include "tpl.isEnabled" .Values.namespace.create }}
{{ include "tpl.namespace" .Values.namespace }}
{{- end }}
{{- end }}

OpenShift description and display-name annotations are emitted only when description or displayName are set.
*/}}

{{- define "tpl.namespace" -}}
kind: Namespace
apiVersion: v1
metadata:
  name: {{ .name }}
  labels:
    {{- include "tpl.additionalLabels" .additionalLabels | indent 4 }}
  {{- if or .description .displayName (not (empty .additionalAnnotations)) }}
  annotations:
    {{- with .description }}
    openshift.io/description: {{ . | quote }}
    {{- end }}
    {{- with .displayName }}
    openshift.io/display-name: {{ . | quote }}
    {{- end }}
    {{- if not (empty .additionalAnnotations) }}
    {{- include "tpl.additionalAnnotations" .additionalAnnotations | indent 4 }}
    {{- end }}
  {{- end }}
spec: {}
{{- end }}
