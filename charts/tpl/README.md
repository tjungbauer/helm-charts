

# tpl

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.31](https://img.shields.io/badge/Version-1.0.31-informational?style=flat-square)

 

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
* Topology spread, image pull secrets, env / envFrom
* OpenShift Route and NetworkPolicy helpers

Instead of defining them in other Charts multiple times, it is possible to simply include the template.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|

No dependencies

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <dev@stdin.at> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/tpl

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchLabels":{"app":"test-app"}},"topologyKey":"kubernetes.io/hostname"},"weight":100}]}}` | Pod affinity rules <br /> Example include: {{- if .Values.affinity }} {{ include "tpl.affinity" .Values.affinity | indent 6 }} {{- end }} |
| argocdMetadata | object | `{"extra":{"my-annotation":"example"},"syncOptions":"SkipDryRunOnMissingResource=true","syncWave":3}` | Argo CD sync metadata for any GitOps-managed resource (not Application CRs). <br /> Example include (operator CR): metadata:   annotations:     {{- include "tpl.argocdMetadata" (dict "syncWave" .Values.central.syncwave "extra" .Values.central.additionalAnnotations) | nindent 4 }} <br /> Example include (hook Job): metadata:   annotations:     {{- include "tpl.argocdMetadata" (dict "type" "hook" "syncWave" 5) | nindent 4 }} |
| argocd_applications | object | `{"example-app":{"annotations":{},"destination":{"namespace":"guestbook","server":"https://kubernetes.default.svc"},"enabled":false,"finalizers":null,"ignoreDifferences":{},"info":[],"labels":{},"namespace":"openshift-gitops","project":"default","source":{"chart":"","helm":{"apiVersions":["traefik.io/v1alpha1/TLSOption","v1/Service"],"fileParameters":[{"name":"config","path":"files/config.json"}],"ignoreMissingValueFiles":false,"kubeVersion":"1.30.0","namespace":"custom-namespace","parameters":[{"forceString":true,"name":"nginx-ingress.enabled","value":"true"},{"name":"replicas","value":"3"}],"passCredentials":false,"releaseName":"my-release","skipCrds":false,"skipSchemaValidation":false,"valueFiles":["values.yaml","values-customyaml"],"values":"ingress:\n  enabled: true\n  path: /\n  hosts:\n    - mydomain.example.com\n  annotations:\n    kubernetes.io/ingress.class: nginx\n    kubernetes.io/tls-acme: \"true\"\n  labels: {}\n  tls:\n    - secretName: mydomain-tls\n      hosts:\n        - mydomain.example.com\n","valuesObject":{"ingress":{"annotations":{"kubernetes.io/ingress.class":"nginx","kubernetes.io/tls-acme":"true"},"enabled":true,"hosts":["mydomain.example.com"],"labels":{},"path":"/","tls":[{"hosts":["mydomain.example.com"],"secretName":"mydomain-tls"}]}},"version":"v3"},"path":"guestbook","repositoryURL":"https://github.com/argoproj/argocd-example-apps.git","targetRevision":"HEAD"},"syncPolicy":{"automated":{"allowEmpty":false,"prune":false,"selfHeal":false},"managedNamespaceMetadata":{},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":[]}}}` | ArgoCD Application <br /> Example include: {{- if .Values.argocd_applications }} {{ include "tpl.argocdApplication" .Values.argocd_applications | indent 2 }} {{- end }} |
| argocd_applications.example-app.annotations | object | `{}` | Add annotations to your application object. @default: {}       |
| argocd_applications.example-app.destination | object | `{"namespace":"guestbook","server":"https://kubernetes.default.svc"}` | Destination configuration |
| argocd_applications.example-app.destination.namespace | string | `"guestbook"` | The namespace will only be set for namespace-scoped resources that have not set a value for .metadata.namespace @default: "" |
| argocd_applications.example-app.destination.server | string | `"https://kubernetes.default.svc"` | Use either server OR name, not both cluster API URL @default: "https://kubernetes.default.svc" |
| argocd_applications.example-app.enabled | bool | `false` | Enable this application @default: false |
| argocd_applications.example-app.finalizers | string | `nil` | Add this finalizer ONLY if you want these to cascade delete. @default: [] |
| argocd_applications.example-app.ignoreDifferences | object | `{}` | Will ignore differences between live and desired states during the diff. Note that these configurations are not used during the sync process unless the `RespectIgnoreDifferences=true` sync option is enabled. default: {} |
| argocd_applications.example-app.info | list | `[]` | Extra information to show in the Argo CD Application details tab @default: [] |
| argocd_applications.example-app.labels | object | `{}` | Add labels to your application object. @default: {} |
| argocd_applications.example-app.namespace | string | `"openshift-gitops"` | Basic application metadata @default: "openshift-gitops" |
| argocd_applications.example-app.project | string | `"default"` | Alternatively, you can use background cascading deletion - resources-finalizer.argocd.argoproj.io/background  -- Argo CD Project the application belongs to @default: "default" |
| argocd_applications.example-app.source.chart | string | `""` | Set this when pulling directly from a Helm repo. DO NOT set for git-hosted Helm charts. @default: "" |
| argocd_applications.example-app.source.helm | object | `{"apiVersions":["traefik.io/v1alpha1/TLSOption","v1/Service"],"fileParameters":[{"name":"config","path":"files/config.json"}],"ignoreMissingValueFiles":false,"kubeVersion":"1.30.0","namespace":"custom-namespace","parameters":[{"forceString":true,"name":"nginx-ingress.enabled","value":"true"},{"name":"replicas","value":"3"}],"passCredentials":false,"releaseName":"my-release","skipCrds":false,"skipSchemaValidation":false,"valueFiles":["values.yaml","values-customyaml"],"values":"ingress:\n  enabled: true\n  path: /\n  hosts:\n    - mydomain.example.com\n  annotations:\n    kubernetes.io/ingress.class: nginx\n    kubernetes.io/tls-acme: \"true\"\n  labels: {}\n  tls:\n    - secretName: mydomain-tls\n      hosts:\n        - mydomain.example.com\n","valuesObject":{"ingress":{"annotations":{"kubernetes.io/ingress.class":"nginx","kubernetes.io/tls-acme":"true"},"enabled":true,"hosts":["mydomain.example.com"],"labels":{},"path":"/","tls":[{"hosts":["mydomain.example.com"],"secretName":"mydomain-tls"}]}},"version":"v3"}` | Helm source configuration @default: {} |
| argocd_applications.example-app.source.helm.apiVersions | list | `["traefik.io/v1alpha1/TLSOption","v1/Service"]` | You can specify the Kubernetes resource API versions to pass to Helm when templating manifests. By default, Argo CD uses the API versions of the target cluster. The format is [group/]version/kind. @default: [] |
| argocd_applications.example-app.source.helm.kubeVersion | string | `"1.30.0"` | You can specify the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD uses the Kubernetes version of the target cluster. The value must be semver formatted. Do not prefix with `v`. @default: "" |
| argocd_applications.example-app.source.helm.namespace | string | `"custom-namespace"` | Optional namespace to template with. If left empty, defaults to the app's destination namespace. @default: "" |
| argocd_applications.example-app.source.helm.parameters | list | `[{"forceString":true,"name":"nginx-ingress.enabled","value":"true"},{"name":"replicas","value":"3"}]` | Extra parameters to set (same as setting through values.yaml, but these take precedence) @default: [] |
| argocd_applications.example-app.source.helm.releaseName | string | `"my-release"` | Release name override (defaults to application name) @default: "" |
| argocd_applications.example-app.source.helm.valueFiles | list | `["values.yaml","values-customyaml"]` | Value files to use for the Helm release @default: [] |
| argocd_applications.example-app.source.path | string | `"guestbook"` | This has no meaning for Helm charts pulled directly from a Helm repo instead of git. |
| argocd_applications.example-app.source.repositoryURL | string | `"https://github.com/argoproj/argocd-example-apps.git"` | Can point to either a Helm chart repo or a git repo. |
| argocd_applications.example-app.source.targetRevision | string | `"HEAD"` | revision, For Helm, this refers to the chart version. |
| argocd_applications.example-app.syncPolicy | object | `{"automated":{"allowEmpty":false,"prune":false,"selfHeal":false},"managedNamespaceMetadata":{},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":[]}` | Sync policy configuration |
| argocd_applications.example-app.syncPolicy.automated | object | `{"allowEmpty":false,"prune":false,"selfHeal":false}` | automated sync by default retries failed attempts 5 times with following delays between attempts ( 5s, 10s, 20s, 40s, 80s ); retry controlled using `retry` field. @default: {} |
| argocd_applications.example-app.syncPolicy.automated.allowEmpty | bool | `false` | Allows deleting all application resources during automatic syncing ( false by default ). @default: false |
| argocd_applications.example-app.syncPolicy.automated.prune | bool | `false` | # Specifies if resources should be pruned during auto-syncing ( false by default ). @default: false |
| argocd_applications.example-app.syncPolicy.automated.selfHeal | bool | `false` | Specifies if partial app sync should be executed when resources are changed only in  target Kubernetes cluster and no git change detected ( false by default ). @default: false |
| argocd_applications.example-app.syncPolicy.managedNamespaceMetadata | object | `{}` | Sets the metadata for the application namespace. Only valid if CreateNamespace=true (see above), otherwise it is ignored. @default: {} |
| argocd_applications.example-app.syncPolicy.retry | object | `{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5}` | Retry configuration for failed syncs. @default: {} |
| argocd_applications.example-app.syncPolicy.retry.backoff | object | `{"duration":"5s","factor":2,"maxDuration":"3m"}` | Backoff configuration for failed sync attempts @default: {} |
| argocd_applications.example-app.syncPolicy.retry.backoff.duration | string | `"5s"` | the amount to back off. Default unit is seconds, but could also be a duration (e.g. "2m", "1h")# duration between retries |
| argocd_applications.example-app.syncPolicy.retry.backoff.factor | int | `2` | a factor to multiply the base duration after each failed retry |
| argocd_applications.example-app.syncPolicy.retry.backoff.maxDuration | string | `"3m"` | the maximum amount of time allowed for the backoff strategy |
| argocd_applications.example-app.syncPolicy.retry.limit | int | `5` | Number of failed sync attempt retries; unlimited number of attempts if less than 0 @default: 0 |
| argocd_applications.example-app.syncPolicy.syncOptions | list | `[]` | Sync options which modifies sync behavior <br /> The following can be set (see: https://argo-cd.readthedocs.io/en/stable/operator-manual/sync-options/)<br /> <ul> <li>- Validate=true ... disables resource validation (equivalent to 'kubectl apply --validate=false') ( true by default ).</li> <li>- CreateNamespace=true ... Namespace Auto-Creation ensures that namespace specified as the application destination exists in the destination cluster.</li> <li>- PrunePropagationPolicy=foreground ... Supported policies are background, foreground and orphan.</li> <li>- PruneLast=true ... Allow the ability for resource pruning to happen as a final, implicit wave of a sync operation</li> <li>- RespectIgnoreDifferences=true ... When syncing changes, respect fields ignored by the ignoreDifferences configuration</li> <li>- ApplyOutOfSyncOnly=true ... Only sync out-of-sync resources, rather than applying every object in the application </li> </ul> @default: [] |
| env | list | `[{"name":"EXAMPLE","value":"true"}]` | Container environment variables <br /> Example include: {{ include "tpl.env" .Values.env | indent 4 }} |
| envFrom | list | `[]` | Container envFrom <br /> Example include: {{ include "tpl.envFrom" .Values.envFrom | indent 4 }} |
| imagePullSecrets | list | `["my-registry-pull-secret"]` | Pod image pull secrets (list of secret names) <br /> Example include: {{- if .Values.imagePullSecrets }} {{ include "tpl.imagePullSecrets" .Values.imagePullSecrets | indent 6 }} {{- end }} |
| matchExpressions | list | `[{"key":"kubernetes.io/metadata.name","operator":"NotIn","values":["kube-system","openshift*","default","kubde-info"]}]` | Deine a metchExpression to use key, oeprator, value pairs. <br /> Example include (used in chart admin-networkpolicies)  spec:  subject:    {{- if .subject.namespaces }}    namespaces:      {{- if .subject.namespaces.matchExpressions }}      matchExpressions:        {{- range .subject.namespaces.matchExpressions }}        {{- include "tpl.matchExpressions" . | indent 4 }}        {{- end }}      {{- end }}      {{- if .subject.namespaces.matchLabels }}      {{- include "tpl.matchLabels" .subject.namespaces.matchLabels | indent 4 }}      {{- end }}    {{- end }} |
| namespace | object | `{"additionalAnnotations":{"test-annotation":"test-annotation"},"additionalLabels":{"test-label":"test-label"},"create":true,"description":"Test Namespace","displayName":"Test Namespace","name":"test-namespace"}` | Namespace <br /> Example include: {{- if .Values.namespace }} {{- if include "tpl.isEnabled" .Values.namespace.create }} {{ include "tpl.namespace" .Values.namespace }} {{- end }} {{- end }} |
| namespace | object | `{"additionalAnnotations":{"additionalAnnotation1":"My Annotation","additionalAnnotation2":"My Annotation 2"},"additionalLabels":{"myLabel1":"My Label","myLabel2":"My Labe 2"},"bindtoNode":{"role":"infra"}}` | If you want to annotate a namespace to run on a specific node configure the following annotations <br /> Example include:    {{- if .Values.namespace.bindtoNode }}    {{- if .Values.namespace.bindtoNode.role }}    {{- include "tpl.bindtoNode" .Values.namespace.bindtoNode | nindent 4 }}    {{- end }}    {{- end }}    {{- include "tpl.additionalAnnotations" .Values.namespace.additionalAnnotations | indent 4 }}    {{- include "tpl.additionalLabels" .Values.namespace.additionalLabels | indent 4 }} |
| namespaceSelector | object | `{"matchLabels":{"kubernetes.io/metadata.name":"openshift-dns"}}` | Define a NamespaceSelector and the required labels <br /> Example include (used in chart admin-networkpolicies)  spec:  subject:    {{- if .subject.namespaces }}    namespaces:      {{- if .subject.namespaces.matchExpressions }}      matchExpressions:        {{- range .subject.namespaces.matchExpressions }}        {{- include "tpl.matchExpressions" . | indent 4 }}        {{- end }}      {{- end }}      {{- if .subject.namespaces.matchLabels }}      {{- include "tpl.matchLabels" .subject.namespaces.matchLabels | indent 4 }}      {{- end }}    {{- end }} |
| networkPolicy | object | `{"ingress":[{"from":[{"podSelector":{}}]}],"name":"allow-from-same-namespace","namespace":"my-namespace","podSelector":{"matchLabels":{"app":"my-app"}},"policyTypes":["Ingress"]}` | NetworkPolicy <br /> Example include: {{ include "tpl.networkPolicy" (dict "root" $ "policy" .Values.networkPolicy) }} |
| nodeSelector | object | key/value example below | nodeSelector for workloads. Use key/value for one label, or a label map for multiple (do not mix both shapes). |
| podDisruptionBudget | object | `{"additionalAnnotations":{"test-annotation":"test-annotation"},"additionalLabels":{"test-label":"test-label"},"matchExpressions":[{"key":"app","operator":"In","values":["test-app","test-app-2"]},{"key":"vendor","operator":"In","values":["test-vendor"]}],"matchLabels":{"app":"test-app","vendor":"test-vendor"},"minAvailable":1,"name":"test-pdb","namespace":"test-namespace","unhealthyPodEvictionPolicy":"AlwaysAllow"}` | PodDisruptionBudget <br /> Example include: {{- if .Values.podDisruptionBudget }} {{ include "tpl.podDisruptionBudget" .Values.podDisruptionBudget | indent 2 }} {{- end }} |
| podSecurityContext | object | `{"fsGroup":2001,"runAsGroup":3001,"runAsNonRoot":true,"runAsUser":1001}` | Pod-level security context <br /> Example include: {{- if .Values.podSecurityContext }} {{ include "tpl.podSecurityContext" .Values.podSecurityContext | indent 2 }} {{- end }} |
| resources | object | `{"limits":{"cpu":8,"ephemeral-storage":"500Mi","extendedResources":{"nvidia.com/gpu":1},"memory":"16Gi"},"requests":{"cpu":4,"ephemeral-storage":"50Mi","memory":"8Gi"}}` | Container resources (requests and limits). Bare numbers for memory or ephemeral-storage get a "Gi" suffix unless the value already ends with Gi or Mi (see tpl.appendUnit). Prefer explicit units (8Gi, 512Mi) in production values. <br /> Example include: {{- if .Values.resources }} {{ include "tpl.resources" .Values.resources  | indent 0 }} {{- end }} |
| resources.limits.extendedResources | object | {} | Extended resources (full Kubernetes resource names as keys). |
| resources.requests.ephemeral-storage | string | 50Mi | Ephemeral storage request. Prefer explicit Mi/Gi; bare integers get a Gi suffix. |
| resources.requests.memory | string | 8Gi | Memory request. Prefer explicit Gi/Mi; bare integers get a Gi suffix via tpl.appendUnit. |
| route | object | `{"enabled":false,"name":"my-app","namespace":"my-namespace","targetPort":"http","tls":{"insecureEdgeTerminationPolicy":"Redirect","termination":"edge"}}` | OpenShift Route (route.openshift.io/v1) <br /> Example include: {{- if include "tpl.isEnabled" .Values.route.enabled }} {{ include "tpl.openshiftRoute" (dict "root" $ "route" .Values.route) }} {{- end }} |
| securityContext | object | `{"readOnlyRootFilesystem":true,"runAsGroup":3000,"runAsNonRoot":true,"runAsUser":1000}` | Security context configuration for containers <br /> Example include: {{- if .Values.securityContext }} {{ include "tpl.securityContext" .Values.securityContext | indent 2 }} {{- end }} |
| tolerations | list | `[{"effect":"NoSchedule","key":"infra","operator":"Equal","tolerationSeconds":600,"value":"reserved"},{"effect":"NoSchedule","key":"infra","operator":"Equal","tolerationSeconds":600,"value":"reserved"}]` | If you want this component to only run on specific nodes, you can configure tolerations of tainted nodes. <br /> Example include: {{- if .Values.tolerations }} {{ include "tpl.tolerations" .Values.tolerations  | indent 0 }} {{- end }} |
| topologySpreadConstraints | list | `[]` | Pod topology spread constraints <br /> Example include: {{- if .Values.topologySpreadConstraints }} {{ include "tpl.topologySpreadConstraints" .Values.topologySpreadConstraints | indent 6 }} {{- end }} |

**`tpl.resources`:** Bare numbers on `memory` or `ephemeral-storage` receive a **Gi** suffix unless the value already ends with **Gi** or **Mi** (for example `memory: 8` becomes `8Gi`). Prefer explicit units in values. Extended resources use `limits.extendedResources` / `requests.extendedResources` with full Kubernetes resource names (e.g. `nvidia.com/gpu`).

**`tpl.nodeSelector`:** Supports one label via `key` / `value`, or multiple labels as a Kubernetes label map (without `key` / `value` fields). Do not mix both shapes in the same block.

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
    memory: 8Gi
    ephemeral-storage: 50Mi
  limits:
    cpu: 8
    memory: 16Gi
    ephemeral-storage: 500Mi
    extendedResources:
      nvidia.com/gpu: 1

nodeSelector:
  key: node-role.kubernetes.io/infra
  value: ''

# Or multiple labels (map form; do not combine with key/value):
# nodeSelector:
#   node-role.kubernetes.io/infra: ""
#   topology.kubernetes.io/zone: eu-west-1

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
