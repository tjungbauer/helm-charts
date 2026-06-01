{{/*
Render an OpenShift Route (route.openshift.io/v1).

Pass a dict:
  root: chart root context (for tpl.labels)
  route:
    name: required
    namespace: required
    serviceName: optional (defaults to name)
    weight: optional (default 100)
    targetPort: required (name or number)
    host: optional
    path: optional
    tls: optional map (termination, insecureEdgeTerminationPolicy, ...)
    wildcardPolicy: optional (default None)
    additionalLabels: optional
    additionalAnnotations: optional

Example:
{{- if include "tpl.isEnabled" .Values.route.enabled }}
{{ include "tpl.openshiftRoute" (dict "root" $ "route" .Values.route) }}
{{- end }}
*/}}
{{- define "tpl.openshiftRoute" -}}
{{- $root := .root -}}
{{- $route := .route -}}
kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: {{ required "tpl.openshiftRoute.route.name is required" $route.name }}
  namespace: {{ required "tpl.openshiftRoute.route.namespace is required" $route.namespace | quote }}
  labels:
    {{- include "tpl.labels" $root | nindent 4 }}
    {{- include "tpl.additionalLabels" ($route.additionalLabels | default dict) | indent 4 }}
  {{- $routeAnn := $route.additionalAnnotations | default $route.annotations | default dict }}
  {{- if not (empty $routeAnn) }}
  annotations:
    {{- include "tpl.additionalAnnotations" $routeAnn | indent 4 }}
  {{- end }}
spec:
  {{- with $route.host }}
  host: {{ . | quote }}
  {{- end }}
  {{- with $route.path }}
  path: {{ . | quote }}
  {{- end }}
  to:
    kind: {{ $route.toKind | default "Service" }}
    name: {{ ($route.serviceName | default $route.name) | quote }}
    weight: {{ $route.weight | default 100 }}
  port:
    targetPort: {{ required "tpl.openshiftRoute.route.targetPort is required" $route.targetPort }}
  {{- with $route.tls }}
  tls:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  wildcardPolicy: {{ $route.wildcardPolicy | default "None" }}
{{- end -}}
