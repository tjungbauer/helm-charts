{{/*
Create an ArgoCD Application

Usage:
{{- include "tpl.argocdApplication" (dict "Values" .Values "Chart" .Chart "Release" .Release "name" "my-app" "spec" .Values.myApp) }}

Required parameters:
- name: string - Name of the application
- spec: object - Application specification

The spec object should contain the application configuration as defined in the values structure below.
*/}}

{{- define "tpl.argocdApplication" -}}
{{- $name := .name -}}
{{- $spec := .spec -}}
{{- $root := . -}}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ $name }}
  namespace: {{ $spec.namespace | default "openshift-gitops" }}
  {{- with $spec.labels }}
  labels:
    {{- include "tpl.additionalLabels" . | indent 4 }}
  {{- end }}
  {{- with $spec.annotations }}
  annotations:
    {{- include "tpl.additionalAnnotations" . | indent 4 }}
  {{- end }}
  {{- if $spec.finalizers }}
  finalizers:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  project: {{ $spec.project | default "default" }}

  {{- if $spec.info }}
  # Additional information
  info:
    {{- range $spec.info }}
    - name: {{ .name | required "If additional info list is provided, name and value fields are required" }}
      value: {{ .value | required "If additional info list is provided, name and value fields are required" }}
    {{- end }}
  {{- end }}

  {{- if $spec.sources }}
  {{- else }}
  # Single source configuration
  source:
    repoURL: {{ $spec.source.repositoryURL | required "source.repositoryURL is required" }}
    {{- with $spec.source.targetRevision }}
    targetRevision: {{ . }}
    {{- end }}
    {{- with $spec.source.path }}
    path: {{ . }}
    {{- end }}
    {{- with $spec.source.chart }}
    chart: {{ . }}
    {{- end }}

    {{- if $spec.source.helm }}
    # Helm specific configuration
    helm:
      {{- with $spec.source.helm.releaseName }}
      releaseName: {{ . }}
      {{- end }}
      {{- with $spec.source.helm.valueFiles }}
      valueFiles:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $spec.source.helm.ignoreMissingValueFiles }}
      ignoreMissingValueFiles: {{ . }}
      {{- end }}
      {{- if $spec.source.helm.parameters }}
      parameters:
        {{- range $spec.source.helm.parameters }}
        - name: {{ .name | required "parameter name is required" }}
          value: {{ .value | quote }}
          {{- with .forceString }}
          forceString: {{ . }}
          {{- end }}
        {{- end }}
      {{- end }}
      {{- if $spec.source.helm.fileParameters }}
      fileParameters:
        {{- range $spec.source.helm.fileParameters }}
        - name: {{ .name | required "fileParameter name is required" }}
          path: {{ .path | required "fileParameter path is required" }}
        {{- end }}
      {{- end }}
      {{- with $spec.source.helm.values }}
      values: |
        {{- . | nindent 8 }}
      {{- end }}
      {{- with $spec.source.helm.valuesObject }}
      valuesObject:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $spec.source.helm.passCredentials }}
      passCredentials: {{ . }}
      {{- end }}
      {{- with $spec.source.helm.skipCrds }}
      skipCrds: {{ . }}
      {{- end }}
      {{- with $spec.source.helm.skipSchemaValidation }}
      skipSchemaValidation: {{ . }}
      {{- end }}
      {{- with $spec.source.helm.version }}
      version: {{ . }}
      {{- end }}
      {{- with $spec.source.helm.kubeVersion }}
      kubeVersion: {{ . }}
      {{- end }}
      {{- with $spec.source.helm.apiVersions }}
      apiVersions:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $spec.source.helm.namespace }}
      namespace: {{ . }}
      {{- end }}
    {{- end }}

  {{- end }}
  # Destination cluster and namespace
  destination:
    {{- if and ($spec.destination.server) ($spec.destination.name) }}
    {{ fail "destination.server and destination.name cannot be set at the same time" }}
    {{- else }}
    {{- if $spec.destination.server }}
    server: {{ $spec.destination.server }}
    {{- else if $spec.destination.name }}
    name: {{ $spec.destination.name }}
    {{- else }}
    server: https://kubernetes.default.svc
    {{- end }}
    {{- end }}
    namespace: {{ $spec.destination.namespace | required "destination.namespace is required" }}

  {{- if $spec.syncPolicy }}
  # Sync policy configuration
  syncPolicy:
    {{- if $spec.syncPolicy.automated }}
    automated:
      {{- with $spec.syncPolicy.automated.prune }}
      prune: {{ . }}
      {{- end }}
      {{- with $spec.syncPolicy.automated.selfHeal }}
      selfHeal: {{ . }}
      {{- end }}
      {{- with $spec.syncPolicy.automated.allowEmpty }}
      allowEmpty: {{ . }}
      {{- end }}
    {{- end }}
    {{- if $spec.syncPolicy.syncOptions }}
    syncOptions:
      {{- toYaml $spec.syncPolicy.syncOptions | nindent 6 }}
    {{- end }}

    {{- if and $spec.syncPolicy.syncOptions (not (has "CreateNamespace=false" $spec.syncPolicy.syncOptions)) }}
    {{- if $spec.syncPolicy.managedNamespaceMetadata }}
    managedNamespaceMetadata:
      {{- with $spec.syncPolicy.managedNamespaceMetadata.labels }}
      labels:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $spec.syncPolicy.managedNamespaceMetadata.annotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- end }}
    {{- end }}

    {{- if $spec.syncPolicy.retry }}
    # Sync retry configuration
    retry:
      {{- with $spec.syncPolicy.retry.limit }}
      limit: {{ . }}
      {{- end }}
      {{- if $spec.syncPolicy.retry.backoff }}
      backoff:
        {{- with $spec.syncPolicy.retry.backoff.duration }}
        duration: {{ . }}
        {{- end }}
        {{- with $spec.syncPolicy.retry.backoff.factor }}
        factor: {{ . }}
        {{- end }}
        {{- with $spec.syncPolicy.retry.backoff.maxDuration }}
        maxDuration: {{ . }}
        {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}

  {{- if $spec.ignoreDifferences }}
  # Ignore differences configuration
  ignoreDifferences:
    {{- toYaml $spec.ignoreDifferences | nindent 4 }}
  {{- end }}

{{- end }}
