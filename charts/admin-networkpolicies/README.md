

# admin-networkpolicies

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.3](https://img.shields.io/badge/Version-1.0.3-informational?style=flat-square)

 

  ## Description

  Configure AdminNetworkPolicy and BaselineNetworkPolicy resources for a cluster.

This Helm Chart configured *AdminNetworkPolicy* and *BaselineAdminNetworkPolicy* objects. See examples in the values.yaml file and at
https://blog.stderr.at/openshift/2024/11/introducting-adminnetworkpolicies/ for detail information.

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.13 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>
* <https://blog.stderr.at/openshift/2024/11/introducting-adminnetworkpolicies/>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/admin-networkpolicies

## Values

### Generic - ANP

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| anp | list | '' | AdminNetworkPolicy |
| anp[0] | object | N/A | Name of the AdminNetworkPolicy. Only Applicable for ANP. |
| anp[0].enabled | bool | false | Enable this ANP or not. You must explicitly set this to "true" |
| anp[0].priority | int | 50 | Priority is a value from 0 to 1000 (0-99 according to OpenShift documentation). Policies with lower priority values have higher precedence, and are checked before policies with higher priority values. Any ANP should have a unique priority |
| anp[0].syncwave | int | 10 | Syncwave for Argo CD |

### Egress Rules

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| anp[0].egress | list | [] | Egress is the list of Egress rules to be applied to the selected pods. A maximum of 100 rules can be defined per ANP. The priority of the rules will be determined by the order the rule is written. Therefore, the first rule will have the highest precedence. |
| anp[0].egress[0] | object | N/A | Name of the egress rule |
| anp[0].egress[0].enabled | bool | false | Enable of disable this specific rule |
| anp[0].egress[0].peers | list | N/A | Peers is a list of matching rules. This can be: <br /> <ul>  <li> - namespaces: Select namespaces using labels or names</li>  <br />  <li> - pods: Select pods using labels for pods and namespaces </li> <br />  <li> - nodes: Select Nodes using match expressions</li>  <br />  <li> - networks: Select IP addresses using CIDR notation</li>  <br />  <li> - domainNames: Select domains using DNS notation</li>  <br /> </ul> See values.yaml for exmples |
| anp[0].egress[0].ports | list | N/A | Ports is a list of matching rules. This can be: <br /> portNumber: Select a specific port number <br /> portName: Select a specific port name <br /> portEndNumber: if defining a range, set the last port number<br /> |
| banp[0].egress | list | [] | Egress is the list of Egress rules to be applied to the selected pods. Therefore, the first rule will have the highest precedence. |

### Ingress Rules

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| anp[0].egress[0].action | string | Deny | Action for this rule, can be *Allow*, *Pass* or *Deny* for ANPs. For BANP only *Allow* and *Deny* are possible. |
| anp[0].ingress | list | [] | Ingress is the list of Ingress rules to be applied to the selected pods. A maximum of 100 rules can be defined per ANP. The priority of the rules will be determined by the order the rule is written. Therefore, the first rule will have the highest precedence. |
| anp[0].ingress[0] | object | N/A | Name of the ingress rule |
| anp[0].ingress[0].action | string | Deny | Action for this rule, can be *Allow*, *Pass* or *Deny* for ANPs. For BANP only *Allow* and *Deny* are possible. |
| anp[0].ingress[0].enabled | bool | false | Enable of disable this specific rule |
| anp[0].ingress[0].peers | list | N/A | Peers is a list of matching rules. This can be: <br /> <ul>  <li> - namespaces: Select namespaces using labels or names</li>  <br />  <li> - pods: Select pods using labels for pods and namespaces </li> <br />  <li> - nodes: Select Nodes using match expressions</li>  <br />  <li> - networks: Select IP addresses using CIDR notation</li>  <br />  <li> - domainNames: Select domains using DNS notation</li>  <br /> </ul> See values.yaml for exmples |
| anp[0].ingress[2].ports | list | N/A | Ports is a list of matching rules. This can be: <br /> portNumber: Select a specific port number <br /> portName: Select a specific port name <br /> portEndNumber: if defining a range, set the last port number<br /> |
| banp[0].ingress | list | [] | Ingress is the list of Ingress rules to be applied to the selected pods. Therefore, the first rule will have the highest precedence. |

### Subject

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| anp[0].subject | object | N/A | Subject defines the pods to which this Policy applies. Note that host-networked pods are not included in subject selection. Can be namespaces or pods that are selected. If subject is empty (subject: {}, then ALL namespaces, including OpenShift namespaces are selected. Use this with caution.<br /> *NOTE*: Below is a full example used for documentation only. Choose which subject works best for you. |
| anp[0].subject.matchNamespaces.matchLabels | object | N/A | Select Namespaces using matchLabels. The labels must exist on the Namespace |
| banp[0].subject | object | N/A | Subject defines the pods to which this Policy applies. Note that host-networked pods are not included in subject selection. Can be namespaces or pods that are selected. If subject is empty (subject: {}, then ALL namespaces, including OpenShift namespaces are selected. Use this with caution.<br /> *NOTE*: Below is a full example used for documentation only. Choose which subject works best for you. |
| banp[0].subject.matchNamespaces | object | N/A | matchNamespaces is used to select pods via namespace selectors. |
| banp[0].subject.matchNamespaces.matchLabels | object | N/A | Select Namespaces using matchLabels. The labels must exist on the Namespace |

### Generic - BANP

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| banp | list | '' | BaselineAdminNetworkPolicy NOTE: BANP cannot set an object name |
| banp[0] | object | false | Enable this ANP or not. You must explicitly set this to "true" |
| banp[0].syncwave | int | 10 | Syncwave for Argo CD |

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
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
