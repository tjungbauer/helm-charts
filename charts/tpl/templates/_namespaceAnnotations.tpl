{{/*
Configure a Namespace to be bound to a specific node.

Example for values files:
      bindtoNode:
        role: infra  # mandatory
        operator: "Exists" # optional, default Exists
        effect: "NoSchedule" # optional, default NoSchedule
        value: "reserverd" # optional, default reserverd
     
{{ include "tpl.bindtoNode" . -}}
*/}}
{{- define "tpl.bindtoNode" -}}
openshift.io/node-selector: node-role.kubernetes.io/{{ .role }}=
scheduler.alpha.kubernetes.io/defaultTolerations: >-
  [{"operator": "{{ .operator | default "Equal" }}", "effect": "{{ .effect | default "NoSchedule" }}", "key":"{{ .role }}", "value": "{{ .value | default "reserverd" }}"}]
{{- end }}

{{- define "tpl.namespaceDescr" -}}
openshift.io/display-name: {{ . | default "" | quote }}
{{- end }}