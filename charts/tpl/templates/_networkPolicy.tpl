{{/*
Render a Kubernetes NetworkPolicy (networking.k8s.io/v1).

Pass a dict:
  root: chart root context (for tpl.labels)
  policy:
    name: required
    namespace: required
    podSelector: optional map (matchLabels); default selects all pods in namespace
    policyTypes: optional list (e.g. Ingress, Egress)
    ingress: optional list (NetworkPolicy ingress rules)
    egress: optional list (NetworkPolicy egress rules)
    additionalLabels: optional
    additionalAnnotations: optional

Example:
{{- range .Values.networkPolicies }}
{{- if include "tpl.isEnabled" .enabled }}
{{ include "tpl.networkPolicy" (dict "root" $ "policy" .) }}
---
{{- end }}
{{- end }}
*/}}
{{- define "tpl.networkPolicy" -}}
{{- $root := .root -}}
{{- $p := .policy -}}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ required "tpl.networkPolicy.policy.name is required" $p.name | quote }}
  namespace: {{ required "tpl.networkPolicy.policy.namespace is required" $p.namespace | quote }}
  labels:
    {{- include "tpl.labels" $root | nindent 4 }}
    {{- include "tpl.additionalLabels" ($p.additionalLabels | default dict) | indent 4 }}
  {{- $policyAnn := $p.additionalAnnotations | default $p.annotations | default dict }}
  {{- if not (empty $policyAnn) }}
  annotations:
    {{- include "tpl.additionalAnnotations" $policyAnn | indent 4 }}
  {{- end }}
spec:
  {{- if $p.podSelector }}
  podSelector:
    {{- toYaml $p.podSelector | nindent 4 }}
  {{- else }}
  podSelector: {}
  {{- end }}
  {{- with $p.policyTypes }}
  policyTypes:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $p.ingress }}
  ingress:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $p.egress }}
  egress:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
