[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# Install & configure Red Hat Advanced Cluster Security (ACS)

This will install RHACS in Full Stack mode, which means Operator, RHACS, Secured Cluster, ConsoleLink and a final ansible script which performs some configuration actions.

The following Subcharts are used as dependency:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): to create the required Operator resources

The whole process has multiple hooks and waves, which are illustrated in the image: 

![GitOps Flow](docs/img/RHACS-Deployment-Waves.png)

It is best used with a GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-cluster-bootstrap

## TL;DR 

```console
helm repo add --force-update tjungbauer https://charts.stderr.at
helm repo update
```

## Prerequisites

* Kubernetes 1.12+
* Helm 3

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release tjungbauer/rhacs-full-stack
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
The following table lists the configurable parameters of the chart and their default values. Only variables of this specific Helm Chart are listed. For the values of the Subchart read the appropriate README of the Subcharts. 

| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `override-rhacs-operator-version` | Set the Operatorto a specific version | `latest` |
| `rhacs.job_vars.max_attempts` | How otften shall the status of the operator be checked (Default 20) | `` |
| `rhacs.job_vars.wait_time` | If the Deployments are not ready yet, how long shall I wait in addition (Default 20) | `` |
| `rhacs.job_vars.crd_check_time` | Time to sleep before I verify that the CRDs have been created | `20` |
| `rhacs.namespace.name` | Name of the Namespace where ACS central shall be deployed | `20` |
| `rhacs.namespace.syncwave` | Syncwave when the Namespace shall be created (usually 0) | `5` |
| `rhacs.namespace.descr` | Description of the Namespace | `` |
| `rhacs.central.syncwave` | Syncwave when Central shall be created | `3` |
| `rhacs.central.pvc` | Name of the PVC | `stackrox-db` |
| `rhacs.central.egress.connectivityPolicy` | Can ACS connect to the internet or not? (Online or Offline) | `Online` |
| `rhacs.central.scannerautoscaling` | Automatically scale the Scanner when needed | `Disabled` |
| `rhacs.job_init_bundle.syncwave` | Syncwave when Job to create the init-bundle shall be started | `3` |
| `rhacs.consolelink.syncwave` | Syncwave when the console link shall be created | `3` |
| `rhacs.consolelink.location` | Location of the console link | `ApplicationMenu` |
| `rhacs.consolelink.text` | Text of the console link | `Advanced Cluster Security` |
| `rhacs.consolelink.section` | Section of the console link | `Observability` |
| `rhacs.secured_cluster.syncwave` | Syncwave when the Secured Cluster instance shall be created (must be AFTER init-bundle creation) | `4` |
| `serviceAccount.create` | Create a ServiceAccount to verify the status of the Operator | `true` |
| `serviceAccount.name` | Name of the ServiceAccount that shall be created | `create-cluster-init` |

## Example

```yaml
---
---
override-rhacs-operator-version: &rhacsversion rhacs-3.72

# Install Operator RHACS
# Deploys Operator --> Subscription and Operatorgroup
# Syncwave: 0
operators:
  rhacs_operator:
    enabled: true
    syncwave: '0'
    namespace: rhacs-operator
    subscription:
      channel: *rhacsversion
      approval: Automatic
      operatorName: rhacs-operator
      source: redhat-operators
      sourceNamespace: openshift-marketplace
    operatorgroup:
      create: true
      # rhacs does not support to monitor own namespace,
      # therefor the spec in the OperatorGroup must be empty
      notownnamespace: true


rhacs:

  job_vars:
    max_attempts: 20  # How otften shall the status of the operator be checked (Default 20)
    wait_time: 20  # If the Deployments are not ready yet, how long shall I wait in addition (Default 20)
    crd_check_time: 5  # Time to sleep before I verify that the CRDs have been created

  namespace:
    name: stackrox
    syncwave: '0'
    descr: 'Red Hat Advanced Cluster Security'

  central:
    syncwave: '3'
    pvc: stackrox-db
    egress:
      connectivityPolicy: Online
    scannerautoscaling: Disabled

  job_init_bundle:
    syncwave: '3'

  consolelink:
    syncwave: '3'
    location: ApplicationMenu
    text: Advanced Cluster Security
    section: Observability

  secured_cluster:
    syncwave: '4'

serviceAccount:
  create: true
  name: "create-cluster-init"
```
