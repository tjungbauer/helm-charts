{{/*
Set a podSecurityContext

Example for resources in the values-file:
securityContext:
  runAsUser: 1000
  runAsGroup: 3000
  fsGroup: 2000
  runAsNonRoot: true
  readOnlyRootFilesystem: true

# Example Deployment:
--------------------------------
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: test
  template:
    metadata:
      labels:
        app: test
    spec:
{{- if .Values.podSecurityContext }}
{{ include "tpl.podSecurityContext" .Values.podSecurityContext | indent 6 }}
{{- end }}
      containers:
      - name: test-container
        image: nginx:latest
{{- if .Values.securityContext }}
{{ include "tpl.securityContext" .Values.securityContext | indent 8 }}
{{- end }}
*/}}

{{- define "tpl.podSecurityContext" -}}
podSecurityContext:
  {{- if .runAsUser }}
  runAsUser: {{ .runAsUser }}
  {{- end }}
  {{- if .runAsGroup }}
  runAsGroup: {{ .runAsGroup }}
  {{- end }}
  {{- if .fsGroup }}
  fsGroup: {{ .fsGroup }}
  {{- end }}
  runAsNonRoot: {{ .runAsNonRoot | default true }}
{{- end }}
