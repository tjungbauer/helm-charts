{{/*
=======================================================
Validation Helpers for Dev Spaces
=======================================================
These helpers validate configuration values and fail
with clear error messages if invalid values are provided.
*/}}

{{/*
Validate Che server log level ... This component supports DEBUG and INFO only
Usage: include "devspaces.validateCheServerLogLevel" "INFO"
*/}}
{{- define "devspaces.validateCheServerLogLevel" -}}
{{- $logLevelCheServer := . -}}
{{- if $logLevelCheServer -}}
  {{- if not (has $logLevelCheServer (list "DEBUG" "INFO")) -}}
    {{- fail (printf "Invalid log level: %s. For Che server it must be one of: DEBUG, INFO" $logLevelCheServer) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate log level for Dashboarc
Usage: include "devspaces.validateDashboardLogLevel" "INFO"
*/}}
{{- define "devspaces.validatevalidateDashboardLogLevel" -}}
{{- $logLevelDashboard := . -}}
{{- if $logLevelDashboard -}}
  {{- if not (has $logLevelDashboard (list "DEBUG" "INFO" "WARN" "ERROR" "FATAL" "TRACE" "SILENT")) -}}
    {{- fail (printf "Invalid log level: %s. Must be one of: DEBUG, INFO, WARN, ERROR, FATAL, TRACE, SILENT" $logLevelDashboard) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate log level
Usage: include "devspaces.validateLogLevel" "INFO"
*/}}
{{- define "devspaces.validateTraeficLogLevel" -}}
{{- $logLevelTraefic := . -}}
{{- if $logLevelTraefic -}}
  {{- if not (has $logLevelTraefic (list "FATAL" "INFO" "WARN" "ERROR" "PANIC")) -}}
    {{- fail (printf "Invalid log level: %s. Must be one of: FATAL, INFO, WARN, ERROR, PANIC" $logLevelTraefic) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate image pull policy
Usage: include "devspaces.validateImagePullPolicy" "IfNotPresent"
*/}}
{{- define "devspaces.validateImagePullPolicy" -}}
{{- $policy := . -}}
{{- if $policy -}}
  {{- if not (has $policy (list "Always" "IfNotPresent" "Never")) -}}
    {{- fail (printf "Invalid image pull policy: %s. Must be one of: Always, IfNotPresent, Never" $policy) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate deployment strategy
Usage: include "devspaces.validateDeploymentStrategy" "Recreate"
*/}}
{{- define "devspaces.validateDeploymentStrategy" -}}
{{- $strategy := . -}}
{{- if $strategy -}}
  {{- if not (has $strategy (list "Recreate" "RollingUpdate")) -}}
    {{- fail (printf "Invalid deployment strategy: %s. Must be one of: Recreate, RollingUpdate" $strategy) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate PVC strategy
Usage: include "devspaces.validatePvcStrategy" "per-user"
*/}}
{{- define "devspaces.validatePvcStrategy" -}}
{{- $strategy := . -}}
{{- if $strategy -}}
  {{- if not (has $strategy (list "common" "per-workspace" "per-user" "ephemeral")) -}}
    {{- fail (printf "Invalid PVC strategy: %s. Must be one of: common, per-workspace, per-user, ephemeral" $strategy) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate timeout value (must be positive integer)
Usage: include "devspaces.validateTimeout" 300
*/}}
{{- define "devspaces.validateTimeout" -}}
{{- $timeout := . | int -}}
{{- if and (ne $timeout 0) (lt $timeout 1) -}}
  {{- fail (printf "Invalid timeout value: %d. Must be a positive integer" $timeout) -}}
{{- end -}}
{{- end -}}

{{/*
Validate namespace template
Usage: include "devspaces.validateNamespaceTemplate" "<username>-devspaces"
*/}}
{{- define "devspaces.validateNamespaceTemplate" -}}
{{- $template := . -}}
{{- if $template -}}
  {{- if not (or (contains "<username>" $template) (contains "<userid>" $template) (contains "<workspaceid>" $template)) -}}
    {{- fail (printf "Invalid namespace template: %s. Must contain one of: <username>, <userid>, <workspaceid>" $template) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate Kubernetes quantity (for storage sizes)
Usage: include "devspaces.validateQuantity" "10Gi"
*/}}
{{- define "devspaces.validateQuantity" -}}
{{- $quantity := . -}}
{{- if $quantity -}}
  {{- if not (regexMatch "^[0-9]+(\\.[0-9]+)?(Ki|Mi|Gi|Ti|Pi|Ei|K|M|G|T|P|E)?$" $quantity) -}}
    {{- fail (printf "Invalid quantity format: %s. Must be a valid Kubernetes quantity (e.g., 10Gi, 100Mi)" $quantity) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

