

# rhacs-setup

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.36](https://img.shields.io/badge/Version-1.0.36-informational?style=flat-square)

 

  ## Description

  Master chart to deploy RHACS operator, initialize it and do some configuration using API Calls

This Helm Chart is installing and configuring Advanced Cluster Security, using the following workflow:

1. Create required Namespace for the operator.
2. Installing the ACS operator by applying the Subscription and OperatorGroup object. (In addition, the InstallPlan can be approved if required)
3. Verifying if the operator is ready to use Install and configure the compliance operator.
4. Create the Namespace for Stackrox instance.
5. Deploy the Central
6. Create an init-Bundle for the Secured Cluster
7. Deploy the Secured Cluster instance on the Central cluster.
8. Job: Create a ConsoleLink for eady access of ACS.
9. Job: Configure ACS with OpenShift Authentication for the user kubeadmin

The whole process has multiple hooks and waves, which are illustrated in the image:

![GitOps Flow](docs/img/RHACS-Deployment-Waves.png)

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.22 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (folder: clusters/management-cluster/setup-acs)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/rhacs-setup

## Parameters

Verify the subcharts for additional settings:

* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clustername | string | `"local-cluster"` |  |
| helper-operator.operators.rhacs-operator.enabled | bool | `false` |  |
| helper-operator.operators.rhacs-operator.namespace.create | bool | `false` |  |
| helper-operator.operators.rhacs-operator.namespace.name | string | `"rhacs-operator"` |  |
| helper-operator.operators.rhacs-operator.operatorgroup.create | bool | `true` |  |
| helper-operator.operators.rhacs-operator.operatorgroup.notownnamespace | bool | `true` |  |
| helper-operator.operators.rhacs-operator.subscription.approval | string | `"Automatic"` |  |
| helper-operator.operators.rhacs-operator.subscription.channel | string | `"stable"` |  |
| helper-operator.operators.rhacs-operator.subscription.operatorName | string | `"rhacs-operator"` |  |
| helper-operator.operators.rhacs-operator.subscription.source | string | `"redhat-operators"` |  |
| helper-operator.operators.rhacs-operator.subscription.sourceNamespace | string | `"openshift-marketplace"` |  |
| helper-operator.operators.rhacs-operator.syncwave | string | `"0"` |  |
| helper-status-checker.checks[0].namespace.name | string | `"rhacs-operator"` |  |
| helper-status-checker.checks[0].operatorName | string | `"rhacs-operator"` |  |
| helper-status-checker.checks[0].serviceAccount.name | string | `"status-checker-acs"` |  |
| helper-status-checker.checks[0].syncwave | int | `3` |  |
| helper-status-checker.enabled | bool | `false` |  |
| operatornamespace | string | `"rhacs-operator"` |  |
| override-rhacs-operator-version | string | `"stable"` |  |
| rhacs.basic_acs_settings | object | `{"auth_provider":"OpenShift","auth_provider_type":"openshift","min_access_role":"None","syncwave":5}` | Basic settings for ACS authentication This configuration is done by a Job, that will configure the OpenShift oauth for ACS. |
| rhacs.central.db | object | `{"resources":{"requests":{"cpu":4}}}` | Settings for Central DB, which is responsible for data persistence. |
| rhacs.central.db.resources | object | `{"requests":{"cpu":4}}` | Set Central DB resources.requests and resources.limits. Per default this block can be omitted. |
| rhacs.central.db.resources.requests.cpu | int | 4 | CPU requests. |
| rhacs.central.egress | object | `{"connectivityPolicy":"Online"}` | Configures whether Red Hat Advanced Cluster Security should run in online or offline (disconnected) mode. In offline mode, automatic updates of vulnerability definitions and kernel modules are disabled. This parameter is MANDATORY default -- Online |
| rhacs.central.enabled | bool | false | Enabled yes or not. Typically, a Central is installed only once (maybe on the management cluster) and will manage different external clusters. |
| rhacs.central.syncwave | string | 3 | Syncwave for Argo CD to create the Central |
| rhacs.consolelink | object | `{"enabled":false,"location":"ApplicationMenu","section":"Observability","syncwave":"3","text":"Advanced Cluster Security"}` | Job that creates a console link in OpenShift |
| rhacs.consolelink.enabled | bool | false | Enable this Job |
| rhacs.consolelink.location | string | `"ApplicationMenu"` | Location of the ConsoleLink |
| rhacs.consolelink.section | string | `"Observability"` | Section of the ConsoleLink |
| rhacs.consolelink.syncwave | string | 3 | Syncwave for Argo CD to create this Job. |
| rhacs.consolelink.text | string | `"Advanced Cluster Security"` | Text of the ConsoleLink |
| rhacs.job_init_bundle | object | `{"enabled":false,"syncwave":"3"}` | Run the Job to initialze an ACS secrued cluster and creates a init bundle. |
| rhacs.job_init_bundle.enabled | bool | false | Enable this Job |
| rhacs.job_init_bundle.syncwave | string | 3 | Syncwave for Argo CD to create this Job. |
| rhacs.job_vars | object | `{"max_attempts":20}` | Variables for Jobs |
| rhacs.job_vars.max_attempts | int | 20 | Maximum retries for Jobs that need to check a certain state. |
| rhacs.namespace.descr | string | `"Red Hat Advanced Cluster Security"` | Description of the Namespace. |
| rhacs.namespace.name | string | `"stackrox"` | Namespace where ACS shall be deployed. Typicall, this is stackrox. This is not the Operator itself, that is usually deployed in "rhacs-operator". |
| rhacs.namespace.syncwave | string | 0 | Syncwave to deploy the ACS namespace. |
| rhacs.scanner.analyzer | object | Disabled | Expose the monitoring endpoint. A new service, "monitoring", with port 9090, will be created as well as a network policy allowing inbound connections to the port. monitoring: Disabled |
| rhacs.scanner.analyzer.autoscaling | object | `{"max":3,"min":2,"replicas":3,"status":"Enabled"}` | Automatically scale the Scanner |
| rhacs.scanner.analyzer.autoscaling.max | int | 3 | Max number of Pods |
| rhacs.scanner.analyzer.autoscaling.min | int | 2 | Minimum number of Pods |
| rhacs.scanner.analyzer.autoscaling.replicas | int | 3 | When autoscaling is disabled, the number of replicas will always be configured to match this value. |
| rhacs.scanner.analyzer.autoscaling.status | string | Enabled | Is austoscaling enabled? |
| rhacs.scanner.db.tolerations | list | `[{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"},{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"}]` | If you want this component to only run on specific nodes, you can configure tolerations of tainted nodes. |
| rhacs.scanner.enabled | bool | false | If you do not want to deploy the Red Hat Advanced Cluster Security Scanner, you can disable it here (not recommended). |
| rhacs.scannerV4 | string | Default | Enable scanner V4. Valid settings are: Default, Enabled, Disabled NOTE: In ACS 4.8 scannerV4 will be enabled by default. |
| rhacs.secured_cluster.admissioncontrol | object | `{"listenOn":{"creates":true,"events":true,"updates":true},"tolerations":[{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"},{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"}]}` | Settings for AdmissionControl |
| rhacs.secured_cluster.admissioncontrol.listenOn.creates | bool | `true` | Set this to true to enable preventive policy enforcement for object creations. |
| rhacs.secured_cluster.admissioncontrol.listenOn.events | bool | `true` | Set this to 'true' to enable monitoring and enforcement for Kubernetes events (port-forward and exec). |
| rhacs.secured_cluster.admissioncontrol.listenOn.updates | bool | `true` | Set this to 'true' to enable preventive policy enforcement for object updates. Note: this will not have any effect unless 'Listen On Creates' is set to 'true' as well. |
| rhacs.secured_cluster.admissioncontrol.tolerations | list | `[{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"},{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"}]` | If you want this component to only run on specific nodes, you can configure tolerations of tainted nodes. |
| rhacs.secured_cluster.centralEndpoint | string | empty | URL of the Central (without https://, with port :443) |
| rhacs.secured_cluster.clustername | string | local-cluster" | Name of the cluster |
| rhacs.secured_cluster.enabled | bool | false | Enable SecuredCluster yes or no ... typically yes |
| rhacs.secured_cluster.scannerV4 | string | Default | Enable Scanner V4 for the Secured Cluster. Valid values are: Default, AutoSense, Disabled NOTE: In ACS 4.8 scannerV4 will be enabled by default. |
| rhacs.secured_cluster.sensor | object | `{"tolerations":[{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"},{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"}]}` | Settings for Sensor |
| rhacs.secured_cluster.sensor.tolerations | list | `[{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"},{"effect":"NoSchedule","key":"infra","operator":"Equal","value":"reserved"}]` | If you want this component to only run on specific nodes, you can configure tolerations of tainted nodes. |
| rhacs.secured_cluster.syncwave | string | 4 | Syncwave for Argo CD to deploy the SecureCluster |
| serviceAccount | object | `{"create":false,"name":"create-cluster-init"}` | Service account name used in Jobs |

## Example

```yaml
---
override-rhacs-operator-version: &rhacsversion stable
operatornamespace: &operatornamespace rhacs-operator
clustername: &clustername local-cluster

rhacs-setup:
  rhacs:

    job_vars:
      max_attempts: 20  # How otften shall the status of the operator be checked (Default 20)

    # Namespace where ACS shall be deployed
    namespace:
      name: stackrox
      syncwave: '0'
      descr: 'Red Hat Advanced Cluster Security'

    ################
    # CENTRAL
    ################
    # Settings for the Central of ACS
    central:

      # Enabled yes or no ... typically yes
      enabled: true
      syncwave: '3'

      # -- Define ConfigMaps with DeclerativeConfiguration
      # @default -- emtpy
      declarativeConfiguration:
        configMaps: []

      # Configures monitoring endpoint for Central.
      # The monitoring endpoint allows other services to collect metrics from
      # Central, provided in Prometheus compatible format.
      # Can bei either:
      #  - Enabled
      #  - Disabled (default)
      # monitoring: Enabled

      # EXPOSURE
      # Here you can configure if you want to expose central through a node port,
      # a load balancer, or an OpenShift route.
      # Per default OpenShift route will be used.
      # Expose Central through a load balancer service.
      # loadBalancer:
      #  enabled: false
      #  port: 443
      #  ip: 127.0.0.1

      # Expose Central through a node port.
      # nodePort:
      #  enabled: false

      # Expose Central through an OpenShift route.
      # This is the default setting
      # route:
      #  enabled: true

      # DEFAULTTLSSECRET
      # By default, Central will only serve an internal TLS certificate,
      # which means that you will need to handle TLS termination at the
      # ingress or load balancer level.
      # If you want to terminate TLS in Central and serve a custom server
      # certificate, you can specify a secret containing the certificate
      # and private key here.
      #
      # Define here the name of the secret If you would like to set it.
      # defaultsslsecret: secretname

      # ADMINISTRATOR PASSWORD
      # Specify a secret that contains the administrator password in the
      # "password" data item. If omitted, the operator will auto-generate a
      # password and store it in the "password" item in the "central-htpasswd" secret.
      # Default: omitted
      # adminPasswordSecret: secretname

      # Configures whether Red Hat Advanced Cluster Security should run in online or
      # offline (disconnected) mode. In offline mode, automatic updates of
      # vulnerability definitions and kernel modules are disabled.
      # Default: Online
      # This parameter is MANDATORY
      egress:
        connectivityPolicy: Online

      # PERSISTENCE
      # The name of the PVC to manage persistent data. If no PVC with the given name
      # exists, it will be created. Defaults to "stackrox-db" if not set.
      # Default: stackrox-db
      # pvc: stackrox-db

      # The size of the persistent volume when created through the claim.
      # If a claim was automatically created, this can be used after the initial
      # deployment to resize (grow) the volume (only supported by some storage class
      # controllers).
      # pvc_size: 100

      # The name of the storage class to use for the PVC. If your cluster is not
      # configured with a default storage class, you must select a value here.
      # Default: default storage class will be used
      # pvc_storageclass: storageclass

      # CENTRAL RESOURCES
      # Allows overriding the default resource settings for the central
      # You can set requests and limits.
      # Parameters (examples):
      #   - requests:
      #        - cpu: 500m
      #        - memory: 50Mi
      #        - ephemeral-storage: 50Mi
      #   - limits:
      #        - cpu: 500m
      #        - memory: 50Mi
      #        - ephemeral-storage: 50Mi

      # ONLY set this if you know what you are doing.
      # per default this block can be omitted.
      # Default values are:
      #   - limits cpu 4, memory 8Gi
      #   - requests: cpu: 1500m, memory 4Gi
      # resources:
      #   requests:
      #     cpu: 500m
      #     memory: 1Gi
      #     ephemeral-storage: 50Mi
      #   limits:
      #     cpu: 500m
      #     memory: 10Gi
      #     ephemeral-storage: 500Mi

      # If you want this component to only run on specific nodes, you can
      # configure tolerations of tainted nodes.
      tolerations:
        - effect: NoSchedule
          key: infra
          operator: Equal
          value: reserved

      ###############
      # CENTRAL DB
      ###############
      # Settings for Central DB, which is responsible for data persistence.
      db:

        # ADMINISTRATOR PASSWORD FOR CENTRAL DATABASE
        # Specify a secret that contains the password in the "password" data item.
        # This can only be used when specifying a connection string manually.
        # When omitted, the operator will auto-generate a DB password and store it
        # in the "password" item in the "central-db-password" secret.
        # Default: omitted
        # passwordSecret: secretname

        # PERSISTENCE
        # Configures how Central DB should store its persistent data.
        # The name of the PVC to manage persistent data.
        # If no PVC with the given name exists, it will be created. Defaults
        # to "central-db" if not set.
        # pvc: central-db

        # The size of the persistent volume when created through the claim.
        # If a claim was automatically created, this can be used after the initial
        # deployment to resize (grow) the volume (only supported by some storage
        # class controllers).
        # pvc_size: 100

        # The name of the storage class to use for the PVC. If your cluster is not
        # configured with a default storage class, you must select a value here.
        # pvc_storageclass: storageclass

        # resources for Central DB ...
        # Default values are:
        #   - limits cpu 8, memory 16Gi
        #   - requests: cpu: 4, memory 8Gi
        # limit it to have more resourcen on demo systems (not suitable for production environments)

        resources:
          requests:
            cpu: '1'
            memory: '1Gi'
      #      ephemeral-storage: 500Mi
      #    limits:
      #      cpu: '1'
      #      memory: '1Gi'
      #      ephemeral-storage: 500Mi

        # If you want this component to only run on specific nodes, you can
        # configure tolerations of tainted nodes.
        tolerations:
          - effect: NoSchedule
            key: infra
            operator: Equal
            value: reserved

    ###############
    # SCANNER
    ###############
    scanner:
      # If you do not want to deploy the Red Hat Advanced Cluster Security Scanner,
      # you can disable it here (not recommended). By default, the scanner is enabled.
      # If you do so, all the settings in this section will have no effect.
      enabled: true

      # Expose the monitoring endpoint. A new service, "monitoring", with port 9090,
      # will be created as well as a network policy allowing inbound connections to
      # the port.
      # monitoring: Disabled

      analyzer:
        # Controls the number of analyzer replicas and autoscaling.
        # If nothing is set, the operator will create a default configuration
        # Parameters:
        #   - status: Enabled
        #   - min: 2
        #   - max: 5
        #   - replicas: 3

        # The following settings are not suitable for a production environment
        autoscaling:
          status: "Disabled"
          max: 1
          min: 1
          # When autoscaling is disabled, the number of replicas will always be
          # configured to match this value.
          replicas: 1

        # If you want this component to only run on specific nodes, you can
        # configure tolerations of tainted nodes.
        tolerations:
          - effect: NoSchedule
            key: infra
            operator: Equal
            value: reserved

        # ONLY set this if you know what you are doing.
        # per default this block can be omitted.
        # Default values are:
        #   - limits cpu 2, memory 4Gi
        #   - requests: cpu: 1, memory 1500Mi
        # resources:
        #  requests:
        #    cpu: 500m
        #    memory: 1Gi
        #    ephemeral-storage: 50Mi
        #  limits:
        #    cpu: 500m
        #    memory: 10Gi
        #    ephemeral-storage: 500Mi

      ###############
      # SCANNER DB
      ###############
      db:
        # If you want this component to only run on specific nodes, you can
        # configure tolerations of tainted nodes.
        tolerations:
          - effect: NoSchedule
            key: infra
            operator: Equal
            value: reserved

        # ONLY set this if you know what you are doing.
        # per default this block can be omitted.
        # Default values are:
        #   - limits cpu 2, memory 4Gi
        #   - requests: cpu: 200m, memory 200Mi
        # resources:
        #  requests:
        #    cpu: 1
        #    memory: 1Gi
        #    ephemeral-storage: 50Mi
        #  limits:
        #    cpu: 500m
        #    memory: 10Gi
        #    ephemeral-storage: 500Mi

    # Run the Job to initialze an ACS secrued cluster
    job_init_bundle:
      enabled: true
      syncwave: '3'

    # Create a console link in OpenShift
    consolelink:
      enabled: true
      syncwave: '4'
      location: ApplicationMenu
      text: Advanced Cluster Security
      section: Observability

    #################
    # SECURED CLUSTER
    #################
    secured_cluster:
      # Enabled yes or no ... typically yes
      enabled: true
      syncwave: '4'
      clustername: *clustername

      # in case tolerations are required
      sensor:
        # If you want this component to only run on specific nodes, you can
        # configure tolerations of tainted nodes.
        tolerations:
          - effect: NoSchedule
            key: infra
            operator: Equal
            value: reserved

      admissioncontrol:
        listenOn:
          # Set this to 'true' to enable preventive policy enforcement for object creations.
          creates: true
          # Set this to 'true' to enable monitoring and enforcement for Kubernetes events (port-forward and exec).
          events: true
          # Set this to 'true' to enable preventive policy enforcement for object updates.
          # Note: this will not have any effect unless 'Listen On Creates' is set to 'true' as well.
          updates: true

        # If you want this component to only run on specific nodes, you can
        # configure tolerations of tainted nodes.
        tolerations:
          - effect: NoSchedule
            key: infra
            operator: Equal
            value: reserved

    basic_acs_settings:
      auth_provider: 'OpenShift'
      auth_provider_type: 'openshift'
      min_access_role: 'None'
      syncwave: 5

# Service account name used in Jobs
serviceAccount:
  create: true
  name: "create-cluster-init"

# Subchart helper-operator
# Simply installs the operator
# Install Operator RHACS
# Deploys Operator --> Subscription and Operatorgroup
# Syncwave: 0
helper-operator:
  operators:
    rhacs-operator:
      enabled: true
      syncwave: '0'
      namespace:
        name: *operatornamespace
        create: true
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

# Subchart helper-status-checker
# checks if ACS operator is ready
helper-status-checker:
  enabled: true

  # use the value of the currentCSV (packagemanifest) but WITHOUT the version !!
  operatorName: rhacs-operator

  # where operator is installed
  namespace:
    name: rhacs-operator

  serviceAccount:
    create: true
    name: "status-checker-acs"
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
