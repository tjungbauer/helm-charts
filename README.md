# My Helm Chart Collection

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

This Helm Chart repository contains Charts, which I use to deploy my Demos on OpenShift/Kubernetes. 
It is mainly used by [Cluster Bootstrap](https://github.com/tjungbauer/openshift-clusterconfig-gitops) but it can be used individually as well.

The Charts in this repository contain workflows for easy deploy and configure for example:

* Red Hat Advanced Cluster Security Deployment and Initialization
* Red Hat Advanced Cluster Management
* OpenShift Data Foundation
* Pipeline Demo
* Compliance Operator Deployment and Configuration
* OpenShift Logging
* etc.

Each Helm Chart has a detailed README that (I hope) explains all possible settings and how they can be used.

The generate the READMEs (well most of them) I am using using [helm-doc](https://github.com/norwoodj/helm-docs)

## Contribute/Questions

Feel free to open issues and pull requests if you find anything that should be added or does not work as it should. I am happy if someone finds these charts usefull.

## Linting
All Charts in this repository must pass the linting process. Use [`helm lint`](https://helm.sh/docs/helm/helm_lint/) and [`chart testing`](https://github.com/helm/chart-testing/blob/master/doc/ct_lint.md) tools.

## CI/CD of this Repo 
This Repo is using two Github Actions to validate the Charts and to create the Helm repository:

* Lint and Test Charts: Uses Chart Tester to automatically verify all NEW (updated) Charts. This means that the version of a Chart must be incremented in order to be found by this action.
* Release Charts: Uses Chart Releaser to build the helm repository on Github Pages. This page is automatically created in the branch "gh-pages" and can be found at: https://charts.stderr.at/
