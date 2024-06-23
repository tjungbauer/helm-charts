
{{/*
Create the name of the service account to use
*/}}
{{- define "rhacs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rhacs.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the role and rolebinding for the serviceaccount
*/}}
{{- define "rhacs.rolename" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rhacs.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}