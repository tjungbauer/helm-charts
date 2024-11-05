{{- define "include.podsConfig" }}
    - pods:
        {{- if .namespaceSelector }}
        namespaceSelector:
          matchLabels:
            {{- range .namespaceSelector.labels }}
            {{ .key }}: {{ .value }}
            {{- end }}
        {{- end }}
        {{- if .podSelector }}
        podSelector:
          matchLabels:
            {{- range .podSelector.labels }}
            {{ .key }}: {{ .value }}
            {{- end }}
        {{- end }}
{{- end }}

{{- /* 
  Define rules based on namespace labels
  If a match is found, then the Namespace will be allowed, denied or passed to project Networkpolcies
*/}}
{{- define "include.namespaceRule" }}
  - namespaces:
      {{- include "tpl.matchLabels" .labels | indent 4 }}
{{- end }}

{{- /* 
  Define rules based on IP addresses
  A list of CIDRs can be defined here
*/}}
{{- define "include.networkRule" }}
  - networks:
      {{- range .ips }}
      - {{ . }}
      {{- end }}
{{- end }}

{{- /* 
  Define rules the will match to certain nodes using matchExpression
*/}}
{{- define "include.nodeRule" }}
  - nodes:
      matchExpressions:
        {{- range .expr }}
        {{- include "tpl.matchExpressions" . | indent 4 }}
        {{- end }}
{{- end }}

{{- /* 
  Define rules to match pods and or namespaces
*/}}
{{- define "include.podRule" }}
  - pods:
      {{- if .podSelector }}
      {{- if .podSelector.matchLabels }}
      podSelector:
        {{- include "tpl.matchLabels" .podSelector.matchLabels | indent 6 }}
      {{- end }}
      {{- end }}

      {{- if eq ( .type | toString ) "pods" }}
      {{- if .namespaceSelector }}
      {{- if .namespaceSelector.matchLabels }}
      namespaceSelector:
        {{- include "tpl.matchLabels" .namespaceSelector.matchLabels | indent 6 }}
      {{- end }}
      {{- end }}
      {{- end }}
{{- end }}

{{- /* 
  Define rules based on domainnames
  Only ALLOW action is possible for domainnames
*/}}
{{- define "include.domainRule" }}
  - domainNames:
      {{- range .domains }}
      - {{ . | quote }}
      {{- end }}
{{- end }}

{{- /* 
  Knitting the rules together
*/}}
{{- define "include.rule" }}
    {{- /* NAMESPACE RULE */}}
    {{- if eq ( .type | toString ) "namespaces" }}
    {{- include "include.namespaceRule" . | indent 4 }}
    {{- end }}
    {{- /* NODE RULE */}}
    {{- if eq ( .type | toString ) "nodes" }}
    {{- include "include.nodeRule" . | indent 4 }}
    {{- end }}
    {{- /* NETWORK-IP RULE */}}
    {{- if eq ( .type | toString ) "networks" }}
    {{- include "include.networkRule" . | indent 4 }}
    {{- end }}
    {{- /* DOMAINNAMES RULE */}}
    {{- if eq ( .type | toString ) "domainNames" }}
    {{- include "include.domainRule" . | indent 4 }}
    {{- end }}
    {{- /* PODS RULE */}}
    {{- if eq ( .type | toString ) "pods" }}
    {{- include "include.podRule" . | indent 4 }}
    {{- end }}
{{- end }}

{{- /* 
  The port specification
*/}}
{{- define "include.ports" }}
  {{- /* PORT BY NUMBER */}}
  {{- if .portNumber }}    
  - portNumber:
      protocol: {{ .protocol }}
      port: {{ .portNumber }}
  {{- end }}
  {{- /* PORT BY NAME */}}
  {{- if .portName }}
  - portName: {{ .portName | quote }}
  {{- end }}
{{- end }}