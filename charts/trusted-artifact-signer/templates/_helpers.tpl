{{/*
=======================================================
Validation Helpers
=======================================================
These helpers validate configuration values and fail
with clear error messages if invalid values are provided.
*/}}

{{/*
Validate replica count
Usage: include "securesign.validateReplicas" .replicas
*/}}
{{- define "securesign.validateReplicas" -}}
{{- $replicas := . | int -}}
{{- if or (lt $replicas 1) (gt $replicas 100) -}}
  {{- fail (printf "Replica count must be between 1 and 100, got %d" $replicas) -}}
{{- end -}}
{{- end -}}

{{/*
Validate port number
Usage: include "securesign.validatePort" $port
*/}}
{{- define "securesign.validatePort" -}}
{{- $port := . | int -}}
{{- if or (lt $port 1) (gt $port 65535) -}}
  {{- fail (printf "Port must be between 1 and 65535, got %d" $port) -}}
{{- end -}}
{{- end -}}

{{/*
Validate email format (basic check)
Usage: include "securesign.validateEmail" $email
*/}}
{{- define "securesign.validateEmail" -}}
{{- $email := . -}}
{{- if $email -}}
  {{- if not (regexMatch "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$" $email) -}}
    {{- fail (printf "Invalid email format: %s" $email) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate PVC size format
Usage: include "securesign.validateSize" $size
*/}}
{{- define "securesign.validateSize" -}}
{{- $size := . -}}
{{- if $size -}}
  {{- if not (regexMatch "^[0-9]+(\\.[0-9]+)?(Ki|Mi|Gi|Ti|Pi|Ei|K|M|G|T|P|E)?$" $size) -}}
    {{- fail (printf "Invalid size format: %s. Must be a valid Kubernetes quantity (e.g., 5Gi, 100Mi)" $size) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate URL format
Usage: include "securesign.validateURL" $url
*/}}
{{- define "securesign.validateURL" -}}
{{- $url := . -}}
{{- if $url -}}
  {{- if not (regexMatch "^(https?|file|s3|gs|azblob|mem)://.+" $url) -}}
    {{- fail (printf "Invalid URL format: %s. Must start with a valid protocol (http://, https://, file://, s3://, gs://, azblob://, mem://)" $url) -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Validate common name is not empty
Usage: include "securesign.validateCommonName" $commonName
*/}}
{{- define "securesign.validateCommonName" -}}
{{- $name := . -}}
{{- if not $name -}}
  {{- fail "commonName cannot be empty" -}}
{{- end -}}
{{- end -}}
