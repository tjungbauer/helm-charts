{{/*
Render a PodDisruptionBudget manifest.

Required fields:
  name
  minAvailable OR maxUnavailable (mutually exclusive; minAvailable may be 0)
  matchLabels and/or matchExpressions (selector must not be empty)

Example for resources in the values-file:
podDisruptionBudget:
  name: "test-pdb"
  namespace: "test-namespace"
  additionalAnnotations:
    test-annotation: "test-annotation"
  additionalLabels:
    test-label: "test-label"
  minAvailable: 1
  matchLabels:
    app: test-app
    vendor: test-vendor
  matchExpressions:
    - key: app
      operator: In
      values:
        - test-app
  unhealthyPodEvictionPolicy: "IfHealthyBudget"

Example include:
{{- if .Values.podDisruptionBudget }}
{{ include "tpl.podDisruptionBudget" .Values.podDisruptionBudget }}
{{- end }}
*/}}

{{- define "tpl.podDisruptionBudget" -}}
{{- $hasMinAvailable := hasKey . "minAvailable" -}}
{{- $hasMaxUnavailable := hasKey . "maxUnavailable" -}}
{{- if and $hasMinAvailable $hasMaxUnavailable -}}
{{- fail "tpl.podDisruptionBudget: minAvailable and maxUnavailable are mutually exclusive" -}}
{{- end -}}
{{- if not (or $hasMinAvailable $hasMaxUnavailable) -}}
{{- fail "tpl.podDisruptionBudget: set minAvailable or maxUnavailable" -}}
{{- end -}}
{{- if not (or .matchLabels .matchExpressions) -}}
{{- fail "tpl.podDisruptionBudget: set matchLabels and/or matchExpressions for spec.selector" -}}
{{- end -}}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ required "tpl.podDisruptionBudget.name is required" .name }}
  namespace: {{ .namespace | default "default" }}
  annotations:
    {{- include "tpl.additionalAnnotations" .additionalAnnotations | indent 4 }}
  labels:
    {{- include "tpl.additionalLabels" .additionalLabels | indent 4 }}
spec:
  {{- if $hasMinAvailable }}
  minAvailable: {{ .minAvailable }}
  {{- end }}
  {{- if $hasMaxUnavailable }}
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
