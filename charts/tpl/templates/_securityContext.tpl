{{/*

Set a securityContext

Example for resources in the values-file:
securityContext:
  runAsUser: 1000
  runAsGroup: 3000
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
  runAsNonRoot: {{ .runAsNonRoot | default true }}
  readOnlyRootFilesystem: {{ .readOnlyRootFilesystem | default true }}
  {{- if ne (.allowPrivilegeEscalation | toString) "" }}
  allowPrivilegeEscalation: {{ .allowPrivilegeEscalation }}
  {{- end }}
  {{- with .capabilities }}
  capabilities:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .seccompProfile }}
  seccompProfile:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
