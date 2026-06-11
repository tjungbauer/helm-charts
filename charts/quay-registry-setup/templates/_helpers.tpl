{{/*
Labels: standard chart labels plus optional additionalLabels map.
Usage: {{- include "quay.labels" (dict "root" $ "additionalLabels" .additionalLabels) | nindent 4 }}
*/}}
{{- define "quay.labels" -}}
{{- include "tpl.labels" .root }}
{{- include "tpl.additionalLabels" (.additionalLabels | default dict) }}
{{- end -}}

{{/*
Hook annotations without forcing hook-delete-policy (preserves legacy Role/SA behavior).
*/}}
{{- define "quay.hookAnnotations" -}}
argocd.argoproj.io/hook: {{ .hook | default "Sync" | quote }}
{{- if .hookDeletePolicy }}
argocd.argoproj.io/hook-delete-policy: {{ .hookDeletePolicy | quote }}
{{- end }}
argocd.argoproj.io/sync-wave: {{ .syncWave | quote }}
{{- include "tpl.additionalAnnotations" (.extra | default dict) }}
{{- end -}}

{{/*
Sync annotations only (no default sync-options). For ConfigMap / Secret metadata.
*/}}
{{- define "quay.syncAnnotations" -}}
argocd.argoproj.io/sync-wave: {{ .syncWave | quote }}
{{- if .syncOptions }}
argocd.argoproj.io/sync-options: {{ .syncOptions | quote }}
{{- end }}
{{- if .compareOptions }}
argocd.argoproj.io/compare-options: {{ .compareOptions | quote }}
{{- end }}
{{- include "tpl.additionalAnnotations" (.extra | default dict) }}
{{- end -}}
