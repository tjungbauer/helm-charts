# My Helm Chart Collection

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
[![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

This Helm Chart repository contains Charts, which I use to deploy my Demos on OpenShift/Kubernetes. 
It is mainly used by [Cluster Bootstrap](https://github.com/tjungbauer/openshift-cluster-bootstrap) but it can be used individually as well.

Charts in this repo contains for example are:

* Red Hat Advanced Cluster Security Deployment and Initialization
* Pipeline Demo
* Compliance Operator Deployment and Configuration

## Add Helm Repository locally
```
helm repo add tjungbauer https://tjungbauer.github.io/helm-charts/
```

## Update your repository
```
helm repo update
```

## To list what is in the repository
```
helm search repo tjungbauer
```

## Run a chart
To install an individual Chart: 
```
helm install $NAME tjungbauer/$CHART_NAME
```
Where:
* $NAME - is the name you want to give the installed Helm App
* $CHART_NAME - name of the chart found in `charts` directory

## Linting
All Charts in this repository must pass the linting process. Use [`helm lint`](https://helm.sh/docs/helm/helm_lint/) and [`chart testing`](https://github.com/helm/chart-testing/blob/master/doc/ct_lint.md) tools.

## CI/CD of this Repo 
This Repo is using two Github Actions to validate the Charts and to create the Helm repository:

* Lint and Test Charts: Uses Chart Tester to automatically verify all NEW (updated) Charts. This means that the version of a Chart must be incremented in order to be found by this action.
* Release Charts: Uses Chart Releaser to build the helm repository on Github Pages. This page is automatically created in the branch "gh-pages" and can be found at: https://tjungbauer.github.io/helm-charts/ 

## Thanks
For all the inspiration: https://github.com/redhat-cop/helm-charts 
