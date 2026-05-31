{{/*
Render ttlSecondsAfterFinished for batch/v1 Job specs.

Pass seconds as an integer (recommended) or rely on the default when the value is empty.

Example:
spec:
  {{- include "tpl.ttlSecondsAfterFinished" (.ttlSecondsAfterFinished | default 600) | nindent 2 }}
*/}}
{{- define "tpl.ttlSecondsAfterFinished" -}}
ttlSecondsAfterFinished: {{ int (. | default 600) }}
{{- end -}}
