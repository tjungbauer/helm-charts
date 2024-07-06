

# quay-registry-setup

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.15](https://img.shields.io/badge/Version-1.0.15-informational?style=flat-square)

 

  ## Description

  Chart to deploy and configure Quay

This Chart is used to configure the Quay Enterprise registry on an OpenShift cluster. While it can be used as a standalone,
it should actually be called using a full GitOps approach defined at: https://github.com/tjungbauer/openshift-clusterconfig-gitops/tree/main/clusters/management-cluster/setup-quay
which also allows you to configure the Quay instance in every detail and will generate the required Secret for you.

This chart will not configure Quay itself but deploys the Operator and the CRD. Without generating the configuration Secret,
this means that Quay will be deployed with all selected components and will expect that either all components are managed by the Operator
or that the configuration is already in place. (Therefore, use the link above to configure Quay also :) )

In addition to deploying and configuring the Operator, this Chart also starts a so-called
init-Job to configure the initial administrator.
Again the password for such an initial user is created at https://github.com/tjungbauer/openshift-clusterconfig-gitops/tree/main/clusters/management-cluster/setup-quay.
(Did I mention already that you will need that repo? :) )

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.0 |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/quay-registry-setup

## Parameters

Verify the subcharts for additional settings:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| quay.components.clair.managed | bool | true | Let Operator manage clair |
| quay.components.clair.overrides | object | `{"replicas":2}` | Override the number of replicas (default: 2) |
| quay.components.clairpostgres.managed | string | true | Let Operator manage PostgresDB of Clair |
| quay.components.hpa.managed | string | true | Let Operator manage Auto Scaling |
| quay.components.mirror.managed | string | true | Let Operator manage Mirror instances |
| quay.components.mirror.overrides | object | `{"replicas":2}` | Override the number of replicas (default: 2) |
| quay.components.monitoring.managed | string | true | Let Operator manage Monitoring configuration |
| quay.components.objectstore.managed | string | true | Let Operator manage Objectstorage |
| quay.components.postgres.managed | bool | true | Let Operator manage Quay Postgres database |
| quay.components.postgres.overrides | object | `{"replicas":1}` | Override the number of replicas (default: 1) |
| quay.components.quay.managed | string | true | Let Operator manage the Quay Application |
| quay.components.quay.overrides | object | `{"replicas":2}` | Override the number of replicas (default: 2) |
| quay.components.redis.managed | string | true | Let Operator manage Redis |
| quay.components.route.managed | string | true | Let Operator manage Route creation |
| quay.components.tls.managed | string | true | Let Operator manage Certificates |
| quay.config_bundle | string | `"config-bundle-secret"` | Name of the Secret of the Quay configuration. This should be configured by the chart used by GitOps approach. |
| quay.enabled | bool | false | Enable configuration of Quay Operator |
| quay.job_init_quay.enabled | bool | false | Enable the init-Job |
| quay.job_init_quay.quay_basename | string | `"quay-registry-quay-app"` |  |
| quay.job_init_quay.serviceAccount | string | `"quay-initiator"` | Name of the ServiceAccount |
| quay.job_init_quay.sleeptimer | int | `30` |  |
| quay.job_init_quay.syncwave | int | `10` |  |
| quay.namespace.create | bool | false | Create the Namespace for Quay Enterprise. Should be "true" if it is a new namespace. |
| quay.namespace.name | string | `"quay-enterprise"` | Name of the Namespace |
| quay.namespace.syncwave | int | 0 | Syncwave to create the Namespace |
| quay.syncwave | int | 3 | Syncwave for the quay CRD |

## Example values

This will configure the Quay Operator the start/manage Quay Enterprise with all components, except:

. Horizontal Pod Autoscaler (HPA)
. Objectstorage
. Mirroring

These components are either not used at all, or must be prepared upfront.

In addition, the replicas of Clair and Quay have been reduced to 1 (default 2) to save resources.

```yaml
---
quay:
  enabled: false

  config_bundle: config-bundle-secret

  namespace:
    create: true

    # -- Name of the Namespace
    name: quay-enterprise

  # Quay comes with several components that might be managed by the Operator or managed by the customer.
  # Some might have an "overrides" settings that can manage the number of replicas. This is useful for for testing purposes.
  components:
    clair:
      overrides:
        replicas: 1
    clairpostgres: {}
    objectstore:
      managed: "false"
    redis: {}
    hpa:
      managed: "false"
    route: {}
    mirror:
      managed: "false"
    monitoring: {}
    tls: {}
    postgres: {}
    quay:
      overrides:
        replicas: 1

  job_init_quay:
    enabled: false
    serviceAccount: quay-initiator
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
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
