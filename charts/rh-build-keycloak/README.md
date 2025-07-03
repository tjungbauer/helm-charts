

# rh-build-keycloak

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 1.0.4](https://img.shields.io/badge/Version-1.0.4-informational?style=flat-square)

 

  ## Description

  Configure the operator Red Hat Build of Keycloak

This Helm Chart is configuring Red Hat build of Keycloak instance.
It can be used be the built in database, or an example and hardcoded postgres instance, or with your very own configuration.

Be sure to create a secret containing the certificate for the keycloak instance and use them in the settings.

A self-signed certificate can be created with the following commands for example:

```bash
`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=test.keycloak.org/O=Test Keycloak./C=US`<br/>
`oc create secret tls example-tls-secret --cert=tls.crt --key=tls.key`
```

It is then used in the values file at:

```yaml
http:
  tlsSecret:
```

Check out the latest documentation for additional settings, supported features and more at, for example: https://docs.redhat.com/en/documentation/red_hat_build_of_keycloak/26.0/html-single/server_configuration_guide/

## Dependencies

This chart has the following dependencies:

| Repository | Name | Version |
|------------|------|---------|
| https://charts.stderr.at/ | tpl | ~1.0.0 |

It is best used with a full GitOps approach such as Argo CD does. For example, https://github.com/tjungbauer/openshift-clusterconfig-gitops (folder: clusters/management-cluster/setup-rh-build-of-keycloak)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tjungbauer | <tjungbau@redhat.com> | <https://blog.stderr.at/> |

## Sources
Source:
* <https://github.com/tjungbauer/helm-charts>
* <https://charts.stderr.at/>
* <https://github.com/tjungbauer/openshift-clusterconfig-gitops>

Source code: https://github.com/tjungbauer/helm-charts/tree/main/charts/rh-build-keycloak

## Parameters

Verify the subcharts for additional settings:

* [tpl](https://github.com/tjungbauer/helm-charts/tree/main/charts/tpl)

## Values

### keycloak

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| keycloak | object | `{"additionalAnnotations":{},"additionalLabels":{},"additionalOptions":{},"db":{"example_db_pass":"","exmple_db_user":"testuser","settings":{"custom_database":false,"database":"","host":"","passwordSecret":{"key":"","name":""},"poolInitialSize":"","poolMaxSize":"","poolMinSize":"","port":"","schema":"","url":"","usernameSecret":{"key":"","name":""},"vendor":""},"use_example_db_sta":false},"features":{"disabled":[],"enabled":[]},"hostname":{"admin":"","adminUrl":"","hostname":"myhostname","strict":false,"strictBackchannel":false},"http":{"httpEnabled":false,"httpPort":"","httpsPort":"","tlsSecret":""},"image":"","imagePullSecrets":[],"ingress":{"className":"","enabled":false},"instance":1,"name":"example-keycloak","namespace":"keycloak","resources":{},"transaction":{"xaEnabled":false}}` | Configuration of the Keycloak instance |
| keycloak.additionalAnnotations | object | {} | Additional annotations to add to the Keycloak instance as key: value pairs. |
| keycloak.additionalLabels | object | {} | Additional labels to add to the Keycloak instance as key: value pairs. |
| keycloak.additionalOptions | object | {} | The additionalOptions field of the Keycloak CR enables Red Hat build of Keycloak to accept any available configuration in the form <br /> of key-value pairs. You can use this field to include any option that is omitted in the Keycloak CR. For details on configuring options, see <br /> [All configurations](https://docs.redhat.com/en/documentation/red_hat_build_of_keycloak/26.0/html-single/server_configuration_guide/#all-config) |
| keycloak.features | object | `{"disabled":[],"enabled":[]}` | Red Hat build of Keycloak has packed some functionality in features, including some disabled features, such as<br /> Technology Preview and deprecated features. Other features are enabled by default, but you can disable them if they<br /> do not apply to your use of Red Hat build of Keycloak. See [Features](https://docs.redhat.com/en/documentation/red_hat_build_of_keycloak/26.0/html-single/server_configuration_guide/#features) |
| keycloak.features.enabled | list | [] | Some supported features, and all preview features, are disabled by default. Here you can enable them. |
| keycloak.hostname | object | `{"admin":"","adminUrl":"","hostname":"myhostname","strict":false,"strictBackchannel":false}` | In this section you can configure Keycloak hostname and related properties. |
| keycloak.hostname.admin | string | "" | Address for accessing the administration console. Use this option if you are exposing the administration console using a reverse proxy on a different address than specified in the hostname option. |
| keycloak.hostname.adminUrl | string | "" | Set the base URL for accessing the administration console, including scheme, host, port and path |
| keycloak.hostname.hostname | string | "" | Hostname at which is the server exposed. |
| keycloak.hostname.strict | bool | false | Disables dynamically resolving the hostname from request headers. |
| keycloak.hostname.strictBackchannel | bool | false | By default backchannel URLs are dynamically resolved from request headers to allow internal and external applications. |
| keycloak.http | object | `{"httpEnabled":false,"httpPort":"","httpsPort":"","tlsSecret":""}` | In this section you can configure Keycloak features related to HTTP and HTTPS |
| keycloak.http.httpEnabled | bool | false | Enables the HTTP listener. |
| keycloak.http.httpPort | string | "" | The used HTTP port. |
| keycloak.http.httpsPort | string | "" | The used HTTPS port. |
| keycloak.http.tlsSecret | string | "" | tlsSecret for Keycloak <br /> Can be a valid secret with tls.crt and tls.key<br/> To create a self-signed simply use the following commands:<br/> `openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=test.keycloak.org/O=Test Keycloak./C=US`<br/> `oc create secret tls example-tls-secret --cert=tls.crt --key=tls.key` |
| keycloak.image | string | `""` | Custom Keycloak image to be used. @@default -- "" |
| keycloak.imagePullSecrets | list | [] | Secret(s) that might be used when pulling an image from a private container image registry or repository. |
| keycloak.ingress | object | `{"className":"","enabled":false}` | The deployment is, by default, exposed through a basic ingress. |
| keycloak.ingress.className | string | "" | Define classname for Ingress |
| keycloak.ingress.enabled | bool | false | Enable Ingress for Keycloak. |
| keycloak.instance | int | 1 | Number of Keycloak instances in HA mode. Default is 1. |
| keycloak.name | string | example-keycloak | The name of the Keycloak instance. |
| keycloak.namespace | string | keycloak | The namespace in which the Keycloak instance is deployed. |
| keycloak.transaction | object | `{"xaEnabled":false}` | In this section you can find all properties related to the settings of transaction behavior. |
| keycloak.transaction.xaEnabled | bool | false | Determine whether Keycloak should use a non-XA datasource in case the database does not support XA transactions. |

### db

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| keycloak.db | object | `{"example_db_pass":"","exmple_db_user":"testuser","settings":{"custom_database":false,"database":"","host":"","passwordSecret":{"key":"","name":""},"poolInitialSize":"","poolMaxSize":"","poolMinSize":"","port":"","schema":"","url":"","usernameSecret":{"key":"","name":""},"vendor":""},"use_example_db_sta":false}` | Define database settings for Keycloak<br /> If omitted then keycloak will use an internal/ephemeral database It is possible to create an example postgres instance for testing purposes |
| keycloak.db.example_db_pass | string | thisisonly4testingNOT4prod | The database password to be used. |
| keycloak.db.exmple_db_user | string | testuser | The database user to be used. |
| keycloak.db.settings | object | `{"custom_database":false,"database":"","host":"","passwordSecret":{"key":"","name":""},"poolInitialSize":"","poolMaxSize":"","poolMinSize":"","port":"","schema":"","url":"","usernameSecret":{"key":"","name":""},"vendor":""}` | In this section you can find all properties related to connect to a database. |
| keycloak.db.settings.custom_database | bool | false | Enable custom db |
| keycloak.db.settings.database | string | '' | Sets the database name of the default JDBC URL of the chosen vendor. If the `url` option is set, this option is ignored. |
| keycloak.db.settings.host | string | "" | Sets the hostname of the default JDBC URL of the chosen vendor. If the `url` option is set, this option is ignored. |
| keycloak.db.settings.passwordSecret | object | `{"key":"","name":""}` | The reference to a secret holding the password of the database user.<br /> The secret must contain a key with the name of the password. |
| keycloak.db.settings.passwordSecret.key | string | "" | The key of the secret holding the password of the database user. |
| keycloak.db.settings.passwordSecret.name | string | "" | The name of the secret holding the password of the database user. |
| keycloak.db.settings.poolInitialSize | string | '' | The initial size of the connection pool. |
| keycloak.db.settings.poolMaxSize | string | '' | The maximum size of the connection pool. |
| keycloak.db.settings.poolMinSize | string | '' | The minimal size of the connection pool. |
| keycloak.db.settings.port | string | "" | Sets the port of the default JDBC URL of the chosen vendor. If the `url` option is set, this option is ignored. |
| keycloak.db.settings.schema | string | "" | The database schema to be used. |
| keycloak.db.settings.url | string | "" | The full database JDBC URL. If not provided, a default URL is set based on the selected database vendor.<br /> For instance, if using 'postgres', the default JDBC URL would be 'jdbc:postgresql://localhost/keycloak'. |
| keycloak.db.settings.usernameSecret | object | `{"key":"","name":""}` | The reference to a secret holding the username of the database user.<br /> The secret must contain a key with the name of the username. |
| keycloak.db.settings.usernameSecret.key | string | "" | The key of the secret holding the username of the database user. |
| keycloak.db.settings.usernameSecret.name | string | "" | The name of the secret holding the username of the database user. |
| keycloak.db.settings.vendor | string | "" | The database vendor, for example 'postgres'. |
| keycloak.db.use_example_db_sta | bool | false | Creates and example Statefulset<br /> This is a ready-to-go-testing service with hardcoded values and no need for further configuration.<br /> This is not intended for production use. |

### namespace

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| namespace | object | `{"additionalAnnotations":{},"additionalLabels":{},"create":true,"descr":"","display":"","name":"keycloak"}` | The namespace that shall be created for the Operator and the instance. |
| namespace.additionalAnnotations | object | {} | Additional labels to add to the Keycloak instance as key: value pairs. |
| namespace.additionalLabels | object | {} | Additional labels to add to the Keycloak instance as key: value pairs. |
| namespace.create | bool | false | Create the namespace if it does not exist. |
| namespace.descr | string | "" | Description of the namespace. |
| namespace.display | string | "" | Displayname of the namespace. |
| namespace.name | string | `"keycloak"` | The name of the namespace. |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| enabled | bool | false | Enable RH Build of Keycloak. |
| keycloak.resources | object | `{}` | specify resource requests and limits here |

## Example settings

```yaml
---
enabled: true

namespace:
  name: <yournamespace>
  create: true

keycloak:
  name: example-keycloak
  namespace: <yournamespace>

  hostname:
    hostname: <yourhostname>>

  http:
    tlsSecret: "keycloak-certificate"
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
