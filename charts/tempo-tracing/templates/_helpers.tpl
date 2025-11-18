{{/*
=======================================================
Validation Helpers for Tempo
=======================================================
These helpers validate configuration values and fail
with clear error messages if invalid values are provided.
*/}}

{{/*
Validate TempoStack storage credential mode
Validates that the credentialMode is one of the supported values.

Supported modes:
- static: Static credentials (username/password or access key/secret key)
- token: Token-based authentication
- tokenCCO: Token-based authentication with Cloud Credential Operator (OpenShift)

Usage: include "tempostack.storageCredentialMode" ".credentialMode"
*/}}
{{- define "tempostack.storageCredentialMode" -}}
{{- $credentialMode := . -}}
{{- if $credentialMode -}}
  {{- $validModes := list "static" "token" "tokenCCO" -}}
  {{- if not (has $credentialMode $validModes) -}}
    {{- fail (printf "Invalid credentialMode: '%s'. Must be one of: %s" $credentialMode (join ", " $validModes)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate TempoStack storage type
Validates that the storage backend type is one of the supported values.

Supported types:
- s3: Amazon S3 or S3-compatible storage (MinIO, Ceph, etc.)
- azure: Azure Blob Storage
- gcs: Google Cloud Storage

Usage: include "tempostack.storageType" ".storage.secret.type"
*/}}
{{- define "tempostack.storageType" -}}
{{- $storageType := . -}}
{{- if $storageType -}}
  {{- $validTypes := list "s3" "azure" "gcs" -}}
  {{- if not (has $storageType $validTypes) -}}
    {{- fail (printf "Invalid storage type: '%s'. Must be one of: %s" $storageType (join ", " $validTypes)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate TempoStack ingress type
Validates that the ingress type is one of the supported values.

Supported types:
- ingress: Kubernetes Ingress
- route: OpenShift Route

Usage: include "tempostack.ingressType" ".template.gateway.ingress.type"
*/}}
{{- define "tempostack.ingressType" -}}
{{- $ingressType := . -}}
{{- if $ingressType -}}
  {{- $validTypes := list "ingress" "route" -}}
  {{- if not (has $ingressType $validTypes) -}}
    {{- fail (printf "Invalid ingress type: '%s'. Must be one of: %s" $ingressType (join ", " $validTypes)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate TempoStack ingress termination type
Validates that the termination type is one of the supported values for OpenShift Routes.

Supported types:
- insecure: No TLS termination
- edge: TLS termination at the router (default)
- passthrough: TLS termination at the backend pod
- reencrypt: TLS termination at the router, then re-encrypted to the backend

Usage: include "tempostack.ingressTermination" ".template.gateway.ingress.termination"
*/}}
{{- define "tempostack.ingressTermination" -}}
{{- $termination := . -}}
{{- if $termination -}}
  {{- $validTerminations := list "insecure" "edge" "passthrough" "reencrypt" -}}
  {{- if not (has $termination $validTerminations) -}}
    {{- fail (printf "Invalid ingress termination: '%s'. Must be one of: %s" $termination (join ", " $validTerminations)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate the managementState of the TempoStack resource.

Supported types:
- managed
- unmanaged

Usage: include "tempostack.managementState" ".managementState"
*/}}
{{- define "tempostack.managementState" -}}
{{- $managementState := . -}}
{{- if $managementState -}}
  {{- $validManagementStates := list "Managed" "Unmanaged" -}}
  {{- if not (has $managementState $validManagementStates) -}}
    {{- fail (printf "Invalid managementState: '%s'. Must be one of: %s" $managementState (join ", " $validManagementStates)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate TempoStack multitenancy mode
Validates that the tenants mode is one of the supported values.

Supported modes:
- openshift: Multi-tenancy mode for OpenShift with authentication via OAuth
- static: Static tenant configuration with explicit tenant definitions

Usage: include "tempostack.tenantsMode" ".tenants.mode"
*/}}
{{- define "tempostack.tenantsMode" -}}
{{- $tenantsMode := . -}}
{{- if $tenantsMode -}}
  {{- $validModes := list "openshift" "static" -}}
  {{- if not (has $tenantsMode $validModes) -}}
    {{- fail (printf "Invalid tenants mode: '%s'. Must be one of: %s" $tenantsMode (join ", " $validModes)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate TempoStack authorization role permissions
Validates that each permission is one of the supported values.

Supported permissions:
- read: Read-only access to traces
- write: Write access to traces (ingestion)

Usage: include "tempostack.rolePermissions" (dict "roleName" .name "permissions" .permissions)
*/}}
{{- define "tempostack.rolePermissions" -}}
{{- $roleName := .roleName -}}
{{- $permissions := .permissions -}}
{{- if $permissions -}}
  {{- $validPermissions := list "read" "write" -}}
  {{- range $permissions -}}
    {{- if not (has . $validPermissions) -}}
      {{- fail (printf "Invalid permission '%s' in role '%s'. Must be one of: %s" . $roleName (join ", " $validPermissions)) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate TempoStack authorization subject kind
Validates that the subject kind is one of the supported values.

Supported kinds:
- user: Individual user subject
- group: Group of users subject

Usage: include "tempostack.subjectKind" (dict "subjectName" .name "kind" .kind)
*/}}
{{- define "tempostack.subjectKind" -}}
{{- $subjectName := .subjectName -}}
{{- $kind := .kind -}}
{{- if $kind -}}
  {{- $validKinds := list "user" "group" -}}
  {{- if not (has $kind $validKinds) -}}
    {{- fail (printf "Invalid subject kind '%s' for subject '%s'. Must be one of: %s" $kind $subjectName (join ", " $validKinds)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate TempoStack hash ring instance address type
Validates that the instanceAddrType is one of the supported values.

Supported types:
- default: Use the default instance address type (default behavior)
- podIP: Use the pod IP address for the instance address

Usage: include "tempostack.instanceAddrType" ".hashRing.memberlist.instanceAddrType"
*/}}
{{- define "tempostack.instanceAddrType" -}}
{{- $instanceAddrType := . -}}
{{- if $instanceAddrType -}}
  {{- $validTypes := list "default" "podIP" -}}
  {{- if not (has $instanceAddrType $validTypes) -}}
    {{- fail (printf "Invalid instanceAddrType: '%s'. Must be one of: %s" $instanceAddrType (join ", " $validTypes)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate TempoStack tenants authorization in OpenShift mode
Validates that authorization is not enabled when tenants mode is openshift.

In OpenShift mode, authorization is handled by OpenShift OAuth and should not be configured separately.

Usage: include "tempostack.validateAuthorizationMode" (dict "mode" .tenants.mode "authorizationEnabled" .tenants.authorization.enabled)
*/}}
{{- define "tempostack.validateAuthorizationMode" -}}
{{- $mode := .mode -}}
{{- $authorizationEnabled := .authorizationEnabled -}}
{{- if and (eq $mode "openshift") (eq ($authorizationEnabled | toString) "true") -}}
  {{- fail "Invalid value: true: spec.tenants.authorization should not be defined in openshift mode" -}}
{{- end -}}
{{- end -}}

{{/*
Validate TempoStack tenant permissions in authentication block
Validates that each permission in a tenant's permissions list is valid.

Supported permissions:
- read: Read-only access to traces (query operations)
- write: Write access to traces (ingestion operations)

Usage: include "tempostack.tenantPermissions" (dict "tenantName" .tenantName "permissions" .permissions)
*/}}
{{- define "tempostack.tenantPermissions" -}}
{{- $tenantName := .tenantName -}}
{{- $permissions := .permissions -}}
{{- if $permissions -}}
  {{- $validPermissions := list "read" "write" -}}
  {{- range $permissions -}}
    {{- if not (has . $validPermissions) -}}
      {{- fail (printf "Invalid permission '%s' for tenant '%s'. Must be one of: %s" . $tenantName (join ", " $validPermissions)) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}