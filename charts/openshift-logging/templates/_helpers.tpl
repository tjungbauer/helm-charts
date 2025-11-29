{{/*
=======================================================
Validation Helpers for Logging
=======================================================
These helpers validate configuration values and fail
with clear error messages if invalid values are provided.
*/}}

{{/*
Validate Logging NetworkPolicy Ruleset
Validates that the Ruleset is one of the supported values.

Supported ruleset:
- RestrictIngressEgress: Deploy a set of Policies that restrict the communication to and from the logging components.

Usage: include "logging.netpolruleset" ".netpol.ruleset"
*/}}
{{- define "logging.netpolruleset" -}}
{{- $ruleset := . -}}
{{- if $ruleset -}}
  {{- $validRulesets := list "RestrictIngressEgress" "AllowAllIngressEgress" -}}
  {{- if not (has $ruleset $validRulesets) -}}
    {{- fail (printf "Invalid networkpolicy ruleset: '%s'. Must be one of: %s" $ruleset (join ", " $validRulesets)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}