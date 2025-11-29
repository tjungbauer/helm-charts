{{/*
=======================================================
Validation Helpers for LokiStack
=======================================================
These helpers validate configuration values and fail
with clear error messages if invalid values are provided.
*/}}

{{/*
Validate LokiStack NetworkPolicy Ruleset
Validates that the Ruleset is one of the supported values.

Supported ruleset:
- None: Loki Operator will not deploy any network policy.
- RestrictIngressEgress: Deploy a set of Policies that restrict the communication to and from the Loki components.

Usage: include "loki.netpolruleset" ".netpol.ruleset"
*/}}
{{- define "loki.netpolruleset" -}}
{{- $ruleset := . -}}
{{- if $ruleset -}}
  {{- $validRulesets := list "None" "RestrictIngressEgress" -}}
  {{- if not (has $ruleset $validRulesets) -}}
    {{- fail (printf "Invalid networkpolicy ruleset: '%s'. Must be one of: %s" $ruleset (join ", " $validRulesets)) -}}
  {{- end -}}
{{- end -}}
{{- end -}}