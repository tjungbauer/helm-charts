{{/*
Set a podSecurityContext

Example for resources in the values-file:
podDisruptionBudget:
  name: "test-pdb"
  namespace: "test-namespace"
  additionalAnnotations:
    test-annotation: "test-annotation"
  additionalLabels:
    test-label: "test-label"
  minAvailable: 1
  maxUnavailable: 1
  matchLabels:
    app: test-app
    vendor: test-vendor
  matchExpressions:
    - key: app
      operator: In
      values:
        - test-app
        - test-app-2
    - key: vendor
      operator: In
      values:
        - test-vendor
  unhealthyPodEvictionPolicy: "IfHealthyBudget"

# Example Deployment:
--------------------------------
{{- if .Values.podDisruptionBudget }}
{{ include "tpl.podDisruptionBudget" .Values.podDisruptionBudget }}
{{- end }}
*/}}

{{- define "tpl.podDisruptionBudget" -}}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ .name }}
  namespace: {{ .namespace | default "default" }}
  annotations:
    {{- include "tpl.additionalAnnotations" .additionalAnnotations | indent 4 }}
  labels:
    {{- include "tpl.additionalLabels" .additionalLabels | indent 4 }}
spec:
  {{- if .minAvailable }}
  minAvailable: {{ .minAvailable }}
  {{- end }}
  {{- if .maxUnavailable }}
  maxUnavailable: {{ .maxUnavailable }}
  {{- end }}
  selector:
    {{- if .matchLabels }}
    {{- include "tpl.matchLabels" .matchLabels | nindent 2 }}
    {{- end }}
    {{- if .matchExpressions }}
    matchExpressions:
    {{- range .matchExpressions }}
    {{- include "tpl.matchExpressions" . | nindent 4 }}
    {{- end }}
    {{- end }}
  unhealthyPodEvictionPolicy: {{ .unhealthyPodEvictionPolicy | default "AlwaysAllow" }}
{{- end }}