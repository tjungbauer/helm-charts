{{/*
Render Argo CD metadata annotations for GitOps-managed resources.

Pass a dict:
  type: resource (default) | hook
  syncWave: int or string (default 0)
  syncOptions: optional string (resource default: SkipDryRunOnMissingResource=true)
  hook: optional (hook type default: Sync)
  hookDeletePolicy: optional (hook type default: HookSucceeded)
  compareOptions: optional string
  extra: optional map merged via tpl.additionalAnnotations

Example (operator CR):
metadata:
  annotations:
    {{- include "tpl.argocdMetadata" (dict "syncWave" .Values.central.syncwave "extra" .Values.central.additionalAnnotations) | nindent 4 }}

Example (hook Job):
metadata:
  annotations:
    {{- include "tpl.argocdMetadata" (dict "type" "hook" "syncWave" 5) | nindent 4 }}
*/}}
{{- define "tpl.argocdMetadata" }}
{{- $type := .type | default "resource" }}
{{- if eq $type "hook" }}
argocd.argoproj.io/hook: {{ .hook | default "Sync" | quote }}
argocd.argoproj.io/hook-delete-policy: {{ .hookDeletePolicy | default "HookSucceeded" | quote }}
{{- end }}
argocd.argoproj.io/sync-wave: {{ .syncWave | default 0 | quote }}
{{- if .syncOptions }}
argocd.argoproj.io/sync-options: {{ .syncOptions | quote }}
{{- else if ne $type "hook" }}
argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true
{{- end }}
{{- if .compareOptions }}
argocd.argoproj.io/compare-options: {{ .compareOptions | quote }}
{{- end }}
{{- include "tpl.additionalAnnotations" (.extra | default dict) }}
{{- end }}
