{{/*
Expand the name of the chart.
*/}}
{{- define "helper-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helper-operator.fullname" -}}
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
{{- define "helper-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common ArgoCD annotations for operators
*/}}
{{- define "helper-operator.annotations" -}}
argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true
argocd.argoproj.io/sync-wave: {{ .syncwave | default "0" | quote }}
{{- include "tpl.additionalAnnotations" .additionalAnnotations }}
{{- end }}

{{/*
Common labels for all resources
*/}}
{{- define "helper-operator.labels" -}}
{{- include "tpl.additionalLabels" .additionalLabels }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helper-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helper-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Subscription configuration block
*/}}
{{- define "helper-operator.subscription.config" -}}
{{- if .config }}
config:
  {{- /* Define a nodeSelector if required */}}
  {{- if .config.nodeSelector }}
  nodeSelector:
    {{ .config.nodeSelector.key }}: {{ .config.nodeSelector.value | quote }}
  {{- end }}

  {{- /* Define required tolerations */}}
  {{- if .config.tolerations }}
{{ include "tpl.tolerations" .config.tolerations | indent 2 }}
  {{- end }}

  {{- /* Define additional environment variables */}}
  {{- if .config.env }}
  env:
    {{- toYaml .config.env | nindent 4 }}
  {{- end }}

  {{- /* mount additional volumes for certificates */}}
  {{- if .config.trustedCA }}
  {{- if eq ( .config.trustedCA.enabled | toString) "true" }}
  volumeMounts:
    - name: {{ .config.trustedCA.configMap | default "trusted-ca-bundle" }}
      mountPath: /etc/pki/ca-trust/extracted/pem
      readOnly: true
  volumes:
    - name: {{ .config.trustedCA.configMap | default "trusted-ca-bundle" }}
      configMap:
        name: {{ .config.trustedCA.configMap | default "trusted-ca-bundle" }}
        items:
          - key: {{ .config.trustedCA.configMapKey | default "ca-bundle.crt" }}
            path: {{ .config.trustedCA.configMapPath | default "ca-bundle.crt" }}
  {{- end }}
  {{- end }}

  {{- /* Define resource limits and requests */}}
  {{- if .config.resources }}
{{ include "tpl.resources" .config.resources | indent 2 }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Generate namespace labels with monitoring enabled
*/}}
{{- define "helper-operator.namespace.labels" -}}
openshift.io/cluster-monitoring: "true"
{{- include "tpl.additionalLabels" .additionalLabels }}
{{- end }}

{{/*
Generate namespace annotations
*/}}
{{- define "helper-operator.namespace.annotations" -}}
{{- include "tpl.additionalAnnotations" .additionalAnnotations }}
{{- if or .descr .displayname }}
{{- if .descr }}
openshift.io/description: {{ .descr }}
{{- end }}
{{- if .displayname }}
openshift.io/display-name: {{ .displayname }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common ArgoCD annotations for jobs
*/}}
{{- define "helper-operator.job.annotations" -}}
argocd.argoproj.io/hook: Sync
argocd.argoproj.io/hook-delete-policy: HookSucceeded
argocd.argoproj.io/sync-wave: {{ .syncwave | default "5" | quote }}
{{- include "tpl.additionalAnnotations" .additionalAnnotations }}
{{- end }}

{{/*
Console plugin helper functions
*/}}
{{- define "helper-operator.console.job.name" -}}
enable-console-plugin-{{ randAlphaNum 5 | lower }}
{{- end }}

{{- define "helper-operator.console.serviceAccount" -}}
{{- .Values.console_plugins.job_service_account | default "enable-console-plugin-sa" }}
{{- end }}

{{- define "helper-operator.console.role" -}}
{{- .Values.console_plugins.job_service_account_role | default "enable-console-plugin-role" }}
{{- end }}

{{- define "helper-operator.console.clusterRoleBinding" -}}
{{- .Values.console_plugins.job_service_account_crb | default "enable-console-plugin-crb" }}
{{- end }}

{{- define "helper-operator.console.namespace" -}}
{{- .Values.console_plugins.job_namespace | default "kube-system" }}
{{- end }}

{{/*
Operator name standardization
*/}}
{{- define "helper-operator.operatorName" -}}
{{- . | default "demo-operator" }}
{{- end }}
