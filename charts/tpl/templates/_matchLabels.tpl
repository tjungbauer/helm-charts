{{/*
Return matching labels, for example used in AdminNetworkPolicy

  namespaceSelector:          
    matchLabels:
      kubernetes.io/metadata.name: "openshift-dns"
     
{{ include "tpl.matchLabels" . -}}
*/}}

{{- define "tpl.matchLabels" }}
  matchLabels:
    {{- range $key, $value := . }}
    {{ $key }}: {{ $value | quote }}
    {{- end -}}
{{- end -}}
