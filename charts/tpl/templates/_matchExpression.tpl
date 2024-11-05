{{/*
Return matchExpressions definition that can be used for example in AdminNetworkPolicy object.

Example for an expression that would match namespaces when they are not kube-system, openshift*, default, kube-info etc.
      matchExpressions:    
        - key: kubernetes.io/metadata.name
          operator: NotIn
          values:
            - "kube-system"
            - "openshift*"
            - "default"
            - "kubde-info"  
     
{{ include "tpl.matchExpressions" . -}}
*/}}

{{- define "tpl.matchExpressions" }}
    - key: {{ .key }}
      operator: {{ .operator }}
      {{- if .values }}
      values:
        {{- range .values }}
        - {{ . | quote }}
        {{- end }}
      {{- end }}
{{- end }}