

# tpl

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.19](https://img.shields.io/badge/Version-1.0.19-informational?style=flat-square)

 

  ## Description

  A library that shall collect certain templates to reuse them among different charts.

The tpl chart is a Helm library chart that provides reusable templates for common Kubernetes configurations. It currently includes templates for:

* Tolerations
* Resource requests/limits
* Node selectors
* Service accounts
* Labels and selectors
* Namespace annotations
* Additional annotations/labels
* Match expressions/labels
* Sleep timer for jobs
* security context
* Pod security context

Instead of defining them in other Charts multiple times, it is possible to simply include the template.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|

No dependencies

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/tpl

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| matchExpressions | list | `[{"key":"kubernetes.io/metadata.name","operator":"NotIn","values":["kube-system","openshift*","default","kubde-info"]}]` | Deine a metchExpression to use key, oeprator, value pairs. <br /> Example include (used in chart admin-networkpolicies)  spec:  subject:    {{- if .subject.namespaces }}    namespaces:      {{- if .subject.namespaces.matchExpressions }}      matchExpressions:        {{- range .subject.namespaces.matchExpressions }}        {{- include "tpl.matchExpressions" . | indent 4 }}        {{- end }}      {{- end }}      {{- if .subject.namespaces.matchLabels }}      {{- include "tpl.matchLabels" .subject.namespaces.matchLabels | indent 4 }}      {{- end }}    {{- end }} |
| namespace | object | `{"additionalAnnotations":{"additionalAnnotation1":"My Annotation","additionalAnnotation2":"My Annotation 2"},"additionalLabels":{"myLabel1":"My Label","myLabel2":"My Labe 2"},"bindtoNode":{"role":"infra"}}` | If you want to annotate a namespace to run on a specific node configure the following annotations <br /> Example include:    {{- if .Values.namespace.bindtoNode }}    {{- if .Values.namespace.bindtoNode.role }}    {{- include "tpl.bindtoNode" .Values.namespace.bindtoNode | nindent 4 }}    {{- end }}    {{- end }}    {{- include "tpl.additionalAnnotations" .Values.namespace.additionalAnnotations | indent 4 }}    {{- include "tpl.additionalLabels" .Values.namespace.additionalLabels | indent 4 }} |
| namespaceSelector | object | `{"matchLabels":{"kubernetes.io/metadata.name":"openshift-dns"}}` | Define a NamespaceSelector and the required labels <br /> Example include (used in chart admin-networkpolicies)  spec:  subject:    {{- if .subject.namespaces }}    namespaces:      {{- if .subject.namespaces.matchExpressions }}      matchExpressions:        {{- range .subject.namespaces.matchExpressions }}        {{- include "tpl.matchExpressions" . | indent 4 }}        {{- end }}      {{- end }}      {{- if .subject.namespaces.matchLabels }}      {{- include "tpl.matchLabels" .subject.namespaces.matchLabels | indent 4 }}      {{- end }}    {{- end }} |
| nodeSelector.key | string | `"node-role.kubernetes.io/infra"` |  |
| nodeSelector.value | string | `""` |  |
| podSecurityContext | object | `{"fsGroup":2001,"runAsGroup":3001,"runAsNonRoot":true,"runAsUser":1001}` | Pod-level security context <br /> Example include: {{- if .Values.podSecurityContext }} {{ include "tpl.podSecurityContext" .Values.podSecurityContext | indent 2 }} {{- end }} |
| resources | object | `{"limits":{"cpu":8,"ephemeral-storage":500,"memory":16},"requests":{"cpu":4,"ephemeral-storage":50,"memory":8}}` | If you want to define resources <br /> Example include: {{- if .Values.resources }} {{ include "tpl.resources" .Values.resources  | indent 0 }} {{- end }} |
| securityContext | object | `{"fsGroup":2000,"readOnlyRootFilesystem":true,"runAsGroup":3000,"runAsNonRoot":true,"runAsUser":1000}` | Security context configuration for containers <br /> Example include: {{- if .Values.securityContext }} {{ include "tpl.securityContext" .Values.securityContext | indent 2 }} {{- end }} |
| tolerations | list | `[{"effect":"NoSchedule","key":"infra","operator":"Equal","tolerationSeconds":600,"value":"reserved"},{"effect":"NoSchedule","key":"infra","operator":"Equal","tolerationSeconds":600,"value":"reserved"}]` | If you want this component to only run on specific nodes, you can configure tolerations of tainted nodes. <br /> Example include: {{- if .Values.tolerations }} {{ include "tpl.tolerations" .Values.tolerations  | indent 0 }} {{- end }} |

## Example values

```yaml
---
# Examples values file

tolerations:
  - effect: NoSchedule
    key: infra
    operator: Equal
    value: reserved
    tolerationSeconds: 600
  - effect: NoSchedule
    key: infra
    operator: Equal
    value: reserved
    tolerationSeconds: 600

resources:
  requests:
    cpu: 4
    memory: 8
    ephemeral-storage: 50
  limits:
    cpu: 8
    memory: 16
    ephemeral-storage: 500

nodeSelector:
  key: node-role.kubernetes.io/infra
  value: ''

namespace:
  bindtoNode:
    role: infra
  additionalAnnotations:
    additionalAnnotation1: "My Annotation"
    additionalAnnotation2: "My Annotation 2"
  additionalLabels:
    myLabel1: "My Label"
    myLabel2: "My Labe 2"

namespaceSelector:         
  matchLabels:
    kubernetes.io/metadata.name: "openshift-dns"

matchExpressions:   
  - key: kubernetes.io/metadata.name
    operator: NotIn
    values:
      - "kube-system"
      - "openshift*"
      - "default"
      - "kubde-info" 

```

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release tjungbauer/<chart-name>>
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
