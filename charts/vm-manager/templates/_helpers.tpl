{{/*
VM Manager Helper Templates
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "vm-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vm-manager.fullname" -}}
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
{{- define "vm-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vm-manager.labels" -}}
helm.sh/chart: {{ include "vm-manager.chart" . }}
{{ include "vm-manager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vm-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vm-manager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
VM common labels
*/}}
{{- define "vm-manager.vmLabels" -}}
{{ include "vm-manager.labels" . }}
app.kubernetes.io/component: virtual-machine
{{- end }}

{{/*
Generate SSH public key configmap data for cloud-init
*/}}
{{- define "vm-manager.sshKeys" -}}
{{- if .Values.global.sshKeys }}
{{- range .Values.global.sshKeys }}
- {{ . }}
{{- end }}
{{- end }}
{{- end }}
