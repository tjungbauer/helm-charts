{{/*
Argo CD hook Job metadata annotations (convenience wrapper for tpl.argocdMetadata type hook).

Example:
metadata:
  name: my-job
  annotations:
    {{- include "tpl.jobHookMetadata" (dict "syncWave" 5 "extra" .additionalAnnotations) | nindent 4 }}
  labels:
    {{- include "tpl.labels" $ | nindent 4 }}
*/}}
{{- define "tpl.jobHookMetadata" -}}
{{- $args := dict "type" "hook" -}}
{{- if .syncWave }}{{- $_ := set $args "syncWave" .syncWave -}}{{- end -}}
{{- if .hook }}{{- $_ := set $args "hook" .hook -}}{{- end -}}
{{- if .hookDeletePolicy }}{{- $_ := set $args "hookDeletePolicy" .hookDeletePolicy -}}{{- end -}}
{{- if .extra }}{{- $_ := set $args "extra" .extra -}}{{- end -}}
{{- include "tpl.argocdMetadata" $args -}}
{{- end -}}

{{/*
Shared pod spec fields for batch/v1 hook Jobs (after the containers block).

Pass a dict:
  serviceAccountName: required
  dnsPolicy: optional (default ClusterFirst)
  terminationGracePeriodSeconds: optional (default 30)
  tolerations: optional slice (tpl.tolerations format)
  nodeSelector: optional dict with key and value
  podSecurityContext: optional dict (tpl.podSecurityContext format)

Example:
spec:
  {{- include "tpl.ttlSecondsAfterFinished" 600 | nindent 2 }}
  template:
    spec:
      containers:
        - name: task
          image: ...
      {{- include "tpl.jobPodSpec" (dict "serviceAccountName" "my-sa" "tolerations" .Values.tolerations) | nindent 6 }}
*/}}
{{- define "tpl.jobPodSpec" -}}
restartPolicy: Never
serviceAccountName: {{ required "tpl.jobPodSpec requires serviceAccountName" .serviceAccountName | quote }}
dnsPolicy: {{ .dnsPolicy | default "ClusterFirst" }}
terminationGracePeriodSeconds: {{ .terminationGracePeriodSeconds | default 30 }}
{{- with .tolerations }}
{{ include "tpl.tolerations" . | indent 0 }}
{{- end }}
{{- with .nodeSelector }}
nodeSelector:
  {{ .key }}: {{ .value | quote }}
{{- end }}
{{- with .podSecurityContext }}
{{ include "tpl.podSecurityContext" . | indent 0 }}
{{- end }}
{{- end -}}
