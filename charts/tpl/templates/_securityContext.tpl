{{/*

Set a securityContext

Example for resources in the values-file:
podSecurityContext:
  runAsUser: 1001
  runAsGroup: 3001
  fsGroup: 2001
  runAsNonRoot: true

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
      containers:
      - name: test-container
        image: nginx:latest
{{- if .Values.securityContext }}
{{ include "tpl.securityContext" .Values.securityContext | indent 8 }}
{{- end }}
*/}}

{{- define "tpl.securityContext" -}}
securityContext:
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
  readOnlyRootFilesystem: {{ .readOnlyRootFilesystem | default true }}
{{- end }}
