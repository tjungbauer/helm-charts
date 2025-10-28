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

# Example Deployment:
--------------------------------
{{- if .Values.namespace }}
{{- if eq (.Values.namespace.create | toString) "true" }}
{{ include "tpl.namespace" .Values.namespace }}
{{- end }}
{{- end }}
*/}}

{{- define "tpl.namespace" -}}
kind: Namespace
apiVersion: v1
metadata:
  name: {{ .name }}
  labels:
    {{- include "tpl.additionalLabels" .additionalLabels | indent 4 }}
  annotations:
    openshift.io/description: {{ .description | quote }}
    openshift.io/display-name: {{ .displayName | quote }}
    {{- include "tpl.additionalAnnotations" .additionalAnnotations | indent 4 }}
spec: {}
{{- end }}
