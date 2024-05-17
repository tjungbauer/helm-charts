{{/*
Get the password to use to access MinIO&reg;
*/}}
{{- define "minio.secret.passwordValue" -}}
{{- if .Values.auth.rootPassword }}
    {{- .Values.auth.rootPassword -}}
{{/* {{- else if (not .Values.auth.forcePassword) }}
    {{- include "getValueFromSecret" (dict "Namespace" .Release.Namespace "Name" (include "common.names.fullname" .) "Length" 10 "Key" "root-password")  -}}
*/}}
{{- else -}}
    {{ required "A root password is required!" .Values.auth.rootPassword }}
{{- end -}}
{{- end -}}

{{/*
Get the credentials secret.
*/}}
{{- define "minio.secretName" -}}
{{- if .Values.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.auth.existingSecret $) -}}
{{/* {{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
*/}}
{{- end -}}
{{- end -}}

{{/*
Get the root user key.
*/}}
{{- define "minio.rootUserKey" -}}
{{- if and (.Values.auth.existingSecret) (.Values.auth.rootUserSecretKey) -}}
    {{- printf "%s" (tpl .Values.auth.rootUserSecretKey $) -}}
{{- else -}}
    {{- "root-user" -}}
{{- end -}}
{{- end -}}

{{/*
Get the root password key.
*/}}
{{- define "minio.rootPasswordKey" -}}
{{- if and (.Values.auth.existingSecret) (.Values.auth.rootPasswordSecretKey) -}}
    {{- printf "%s" (tpl .Values.auth.rootPasswordSecretKey $) -}}
{{- else -}}
    {{- "root-password" -}}
{{- end -}}
{{- end -}}


{{- define "provisioner.randomString" -}}
{{ randAlphaNum . }}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "common.labels" -}}
helm.sh/chart: {{ include "common.chart" . }}
{{ include "common.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "helper.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "common.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the role and rolebinding for the serviceaccount
*/}}
{{- define "helper.rolename" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "common.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}