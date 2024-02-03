[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

# DEMO Pipeline using OpenShift Pipelines/Tekton

This straightforward Chat is simply used to demonstrate OpenShift Pipelines. The task is to perform a Helm linting on my Helm repository. It can be used as basis for more sophisticated Charts. 

It is best used with a GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops

It only comes with one parameter `demo_pipelines` and requires the configuration of a Webhook in GitHub to trigger the Pipeline accordingly. 

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
helm install my-release tjungbauer/pipeline-example
```

The command deploys the chart on the Kubernetes cluster in the default configuration.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters
The following table lists the configurable parameters of the chart and their default values.


| Parameter                                 | Description                                   | Default                                                 |
|-------------------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `demo_pipelines` | Namespace where the Demo shall be deployed | `` |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

# Required manual Settings: 

To automatically trigger a PipelineRun when a git push even happens, do the following: 

1. Create a Secret like the following

```yaml
kind: Secret
apiVersion: v1
metadata:
  name: github-secret
  namespace: pipeline-lint-demo
data:
  secretToken: XXXX
type: Opaque
```

NOTE: Change the `secretToken` to whatever password you like

2. Configure github repository at: 
Settings > Webhooks > Create new Webhook 

Enter the following 3 parameters:

- Event Listener URL (oc get routes... )
- Content Type -> application/json
- Secret: your secure password from Step #1
