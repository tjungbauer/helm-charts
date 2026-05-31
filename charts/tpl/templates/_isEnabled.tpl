{{/*
Return "true" when a Helm value should be treated as enabled.

Accepts bool true/false and string forms such as "true", "True", or "TRUE".
Returns an empty string when disabled or unset — safe for use in {{- if include "tpl.isEnabled" .Values.enabled }}.

Example:
{{- if include "tpl.isEnabled" .Values.enabled }}
...
{{- end }}
*/}}
{{- define "tpl.isEnabled" -}}
{{- $v := . -}}
{{- if or (and (kindIs "bool" $v) $v) (eq (toString $v | lower) "true") -}}true{{- end -}}
{{- end -}}
