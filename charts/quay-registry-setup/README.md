

# quay-registry-setup

  [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openshift-bootstraps)](https://artifacthub.io/packages/search?repo=openshift-bootstraps)
  [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
  [![Lint and Test Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/lint_and_test_charts.yml)
  [![Release Charts](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/tjungbauer/helm-charts/actions/workflows/release.yml)

  ![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square)

 

  ## Description

  Deploy and configure Red Hat Quay Registry.

This Chart is used to configure the Quay Enterprise registry on a cluster. While the Chart can be used standalone,
it should actually be called using a full GitOps approach defined at [Quay Setup](https://github.com/tjungbauer/openshift-clusterconfig-gitops/tree/main/clusters/management-cluster/setup-quay)
which will take care of the Operator deployment and bucket configuration.

In addition to deploying and configuring the Operator, the Chart also starts some Kubernetes Jobs:

* init-user: to configure the initial administrator.
* generate-config: to generate a quay configuration.

**NOTE**: The possibilities to configure Quay seem to be endless. The most common settings are already supported by this Chart.
If you need more configuration options, please open an issue.

Per default, the Chart assumes that OpenShift Data Foundation is used as an object storage.
Therefore, it tries to create a BucketClaim. To prepare the bucket configuration a sub-chart [helper-objectstore](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-objectstore) can be used.
Verify the wrapper chart at [Quay Setup](https://github.com/tjungbauer/openshift-clusterconfig-gitops/tree/main/clusters/management-cluster/setup-quay) for a full picture.

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

Verify the possible sub-charts for additional settings:

* [helper-objectstore](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-objectstore): Preparing Object Storage.
* [helper-operator](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-operator): Install the Operator itself.
* [helper-status-checker](https://github.com/tjungbauer/helm-charts/tree/main/charts/helper-status-checker): Check the status of the Operator.

## Values

### Bucket Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| quay.bucketClaim | object | `{"enabled":false,"name":"quay-bucketname","storageclass":null,"syncwave":2}` | Create a BucketClaim. To use this the ObjectBucketClaim resource must be available on the cluster. If this resource is not available, then a bucket must be created in a different way (prepared before Quay is deployed.) This usually goes together with helper-objectstore, that can create a new BucketClass. |
| quay.bucketClaim.enabled | bool | false | Enable creation of bucket Claim. |
| quay.bucketClaim.storageclass | string | `nil` | Name of the storageclass. A separate StorageClass with BackingStore and BackingClass can be created. @ default -- openshift-storage.noobaa.io |
| quay.bucketClaim.syncwave | int | 2 | Syncwave for bucketclaim creation. This should be done very early, but it depends on ODF. |

### Quay Components

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| quay.components | object | all components are installed in managed mode. Where possible multiple replicas (2) will be used. | Quay comes with several components that might be managed by the Operator or managed by the customer. Some might have an "overrides" settings that can manage the number of replicas. This is useful for for testing purposes. |
| quay.components.clair.managed | bool | true | Let Operator manage clair |
| quay.components.clair.overrides | object | `{"replicas":2}` | Override the number of replicas (default: 2) |
| quay.components.clairpostgres.managed | string | true | Let Operator manage PostgresDB of Clair |
| quay.components.hpa.managed | string | true | Let Operator manage Auto Scaling |
| quay.components.mirror.managed | string | true | Let Operator manage Mirror instances |
| quay.components.mirror.overrides | object | `{"replicas":2}` | Override the number of replicas (default: 2) |
| quay.components.monitoring.managed | string | true | Let Operator manage Monitoring configuration |
| quay.components.objectstore.managed | string | true | Let Operator manage Objectstorage |
| quay.components.postgres.managed | bool | true | Let Operator manage Quay Postgres database |
| quay.components.quay.managed | string | true | Let Operator manage the Quay Application |
| quay.components.quay.overrides | object | `{"replicas":2}` | Override the number of replicas (default: 2) |
| quay.components.redis.managed | string | true | Let Operator manage Redis |
| quay.components.route.managed | string | true | Let Operator manage Route creation |
| quay.components.tls.managed | string | true | Let Operator manage Certificates |

### Generic Settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| quay.config_bundle | string | quay-generated-configuration | Name of the Secret of the Quay configuration. This should be configured by the chart used by GitOps approach. |
| quay.enabled | bool | false | Enable configuration of the Quay Operator. This will setup the Namespace and the Operator isntance. |
| quay.namespace.bindtoNode | object | N/A | When you want to schedule Quay on a specific node (role), for example infrastructure nodes, you can define the role here. Technically, it will add specific annotations onto the Namespace object. |
| quay.namespace.bindtoNode.role | string | `"infra"` | Role where Quay shall be scheduled @default: N/A |
| quay.namespace.create | bool | false | Create the Namespace for Quay Enterprise. Should be "true" if it is a new namespace. |
| quay.namespace.name | string | N/A | Name of the Namespace |
| quay.namespace.syncwave | int | 0 | Syncwave to create the Namespace |
| quay.public_route | string | N/A | The public route that shall be used for the registry. This setting is required to initialize quay. |
| quay.syncwave | int | 3 | Syncwave for the quay CRD |

### Job Initialize Quay

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| quay.init_user | object | `{"enabled":false,"mail":"admin@company.com","password":"","secretName":"initial-user","username":"admin"}` | Creating initial admin account.<br /> The password for this user can be GENERATED or set in the values file (not recommended) and can be found in the secret. Defaults for username and mail:   - username: admin   - mail: admin@company.com |
| quay.init_user.enabled | bool | false | Enable user account initialization. |
| quay.init_user.mail | string | `"admin@company.com"` | Email Address for that username @default admin@company.com |
| quay.init_user.password | string | generated randomly | OPTIONAL: Password in CLEARTEXT. If set then this is used as password. (not recommended) If not set, then a password will be randomly generated. |
| quay.init_user.secretName | string | init-user | Name of the Secret for the initialize user. |
| quay.init_user.username | string | admin | Default Username |
| quay.job_init_quay | object | `{"enabled":false,"quay_basename":"quay-registry-quay-app","serviceAccount":"quay-initiator","sleeptimer":30,"syncwave":200}` | Initialize Quay and configure the first user. This was start a Job, that will connect to the public route and configure the first (admin) user. |
| quay.job_init_quay.enabled | bool | false | Enable the init-Job |
| quay.job_init_quay.quay_basename | string | quay-registry-quay-app | Base name of quay URL. This is the internal service URL that is used to verify if Quay is up and running. |
| quay.job_init_quay.serviceAccount | string | quay-initiator | Name of the ServiceAccount |
| quay.job_init_quay.sleeptimer | int | 30 | Used to define the sleeptimer. |
| quay.job_init_quay.syncwave | int | 200 | Syncwave for the init Job that generates the admin account. |

### Job Inject Certificate into Quay Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| quay.job_inject_route_cert | object | `{"additional_ca":{"configmap":"kube-root-ca.crt","configmap_key":".data.ca\\.crt","enabled":false},"certificate":{"enabled":false,"name":"certificate-name"},"enabled":false,"name":"inject-certificate","serviceAccount":"quay-ca-injector","sleeptimer":30,"syncwave":5}` | Inject the route certificate into the generated configuration Secret |
| quay.job_inject_route_cert.additional_ca | object | `{"configmap":"kube-root-ca.crt","configmap_key":".data.ca\\.crt","enabled":false}` | Name of additional certificates to trust that shall be injected. |
| quay.job_inject_route_cert.additional_ca.configmap | string | none | Name of the configmap that has the additional certificates |
| quay.job_inject_route_cert.additional_ca.configmap_key | string | None | Name of the key inside the Configmap that holds the additional certificates. Be aware of escaping! |
| quay.job_inject_route_cert.additional_ca.enabled | bool | false | Enable additional certificate injection |
| quay.job_inject_route_cert.certificate | object | `{"enabled":false,"name":"certificate-name"}` | Name of the certificate secret that shall be injected. |
| quay.job_inject_route_cert.certificate.enabled | bool | false | Enable Certificate injection |
| quay.job_inject_route_cert.certificate.name | string | None | Name of the secret that contains the certificate. It must contain tls.crt and tls.key. |
| quay.job_inject_route_cert.enabled | bool | false | Enable certificate inject Job |
| quay.job_inject_route_cert.name | string | inject-certificate | Name of the Job |
| quay.job_inject_route_cert.serviceAccount | string | quay-ca-injector | Name of the ServiceAccount for the injector Job |
| quay.job_inject_route_cert.sleeptimer | int | 30 | Sleeptime to wait before the certificate is ready |
| quay.job_inject_route_cert.syncwave | int | 5 | Synvwave for this Job |

### Quay Configuration Settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| quay_configuration.allow_pulls_without_strict_logging | bool | false | If true, pulls will still succeed even if the pull audit log entry cannot be written. This is useful if the database is in a read-only state and it is desired for pulls to continue during that time. |
| quay_configuration.authentication_type | string | Database | The authentication engine to use for credential authentication.<br /> Values: One of<br />    <ul><li>Database</li>        <li>LDAP</li>        <li>JWT</li>        <li>Keystone</li>        <li>OIDC</li></ul> |
| quay_configuration.avatar_kind | string | local | The types of avatars to display, either generated inline (local) or Gravatar (gravatar) |
| quay_configuration.browser_api_calls_xhr_only | bool | false | If enabled, only API calls marked as being made by an XHR will be allowed from browsers |
| quay_configuration.create_private_repo_on_push | bool | true | Whether new repositories created by push are set to private visibility |
| quay_configuration.default_system_reject_quota_bytes | float | no limit is set (== 1.073741824e+11) | Enables system default quota reject byte allowance for all organizations. By default, no limit is set. --> 1.073741824e+11 |
| quay_configuration.default_tag_expiration | string | 2w | The default, configurable tag expiration time for time machine. <b>Pattern:</b> ^[0-9]+(w\|m\|d\|h\|s)$ |
| quay_configuration.feature.action_log_rotation | bool | false | Enabling log rotation and archival will move all logs older than 30 days to storage. |
| quay_configuration.feature.aggregated_log_count_retrieval | bool | true | Whether to allow retrieval of aggregated log counts |
| quay_configuration.feature.anonymous_access | bool | true | Whether to allow anonymous users to browse and pull public repositories |
| quay_configuration.feature.app_specific_tokens | bool | true | If enabled, users can create tokens for use by the Docker CLI |
| quay_configuration.feature.bitbucket_build | bool | false | Whether to support Bitbucket build triggers. |
| quay_configuration.feature.blacklisted_emails | bool | false | If set to true, no new User accounts may be created if their email domain is blacklisted |
| quay_configuration.feature.build_support | bool | false | Whether to support Dockerfile build. |
| quay_configuration.feature.change_tag_expiration | bool | true | Whether users and organizations are allowed to change the tag expiration for tags in their namespace. |
| quay_configuration.feature.direct_login | bool | true | Whether users can directly login to the UI |
| quay_configuration.feature.extended_repository_names | bool | true | Enable support for nested repositories |
| quay_configuration.feature.fips | bool | false | If set to true, Red Hat Quay will run using FIPS-compliant hash functions |
| quay_configuration.feature.garbage_collection | bool | true | Whether garbage collection of repositories is enabled. |
| quay_configuration.feature.general_oci_support | bool | true | Enable support for OCI artifacts. |
| quay_configuration.feature.github_build | bool | false | Whether to support GitHub build triggers. |
| quay_configuration.feature.github_login | bool | false | Whether GitHub login is supported |
| quay_configuration.feature.gitlab_build | bool | false | Whether to support GitLab build triggers. |
| quay_configuration.feature.google_login | bool | false | Whether Google login is supported. |
| quay_configuration.feature.helm_oci_support | bool | false | Enable support for Helm artifacts. |
| quay_configuration.feature.invite_only_user_creation | bool | false | Whether users being created must be invited by another user |
| quay_configuration.feature.library_support | bool | true | Whether to allow for "namespace-less" repositories when pulling and pushing from Docker |
| quay_configuration.feature.log_export | bool | true | Whether to allow exporting of action logs. |
| quay_configuration.feature.mailing | bool | false | Whether emails are enabled |
| quay_configuration.feature.nonsuperuser_team_syncing_setup | bool | false | If enabled, non-superusers can setup syncing on teams using LDAP. |
| quay_configuration.feature.partial_user_autocomplete | bool | true | If set to true, autocompletion will apply to partial usernames |
| quay_configuration.feature.proxy_storage | bool | false | Whether to proxy all direct download URLs in storage through NGINX. |
| quay_configuration.feature.public_catalog | bool | false | If set to true, the _catalog endpoint returns public repositories. Otherwise, only private repositories can be returned. |
| quay_configuration.feature.quota_management | bool | false | Enables configuration, caching, and validation for quota management feature. |
| quay_configuration.feature.rate_limits | bool | false | Whether to enable rate limits on API and registry endpoints. Setting FEATURE_RATE_LIMITS to true causes nginx to limit certain API calls to 30 per second. If that feature is not set, API calls are limited to 300 per second (effectively unlimited). |
| quay_configuration.feature.reader_build_logs | bool | false | If set to true, build logs can be read by those with read access to the repository, rather than only write access or admin access. |
| quay_configuration.feature.recaptcha | bool | false | Whether Recaptcha is necessary for user login and recovery |
| quay_configuration.feature.repo_mirror | bool | true | If set to true, enables repository mirroring. |
| quay_configuration.feature.repository_garbage_collection | bool | true | Whether garbage collection is enabled for repositories. |
| quay_configuration.feature.restricted_v1_push | bool | true | If set to true, only namespaces listed in V1_PUSH_WHITELIST support V1 push |
| quay_configuration.feature.security_notifications | bool | false | If the security scanner is enabled, turn on or turn off security notifications |
| quay_configuration.feature.signing | bool | false | Whether to support signing |
| quay_configuration.feature.storage_replication | bool | false | Whether to automatically replicate between storage engines. |
| quay_configuration.feature.super_users | bool | true | Whether superusers are supported |
| quay_configuration.feature.team_syncing | bool | true | Whether to allow for team membership to be synced from a backing group in the authentication engine (LDAP or Keystone). |
| quay_configuration.feature.ui_v2 | bool | true | When set, allows users to try the beta UI environment. |
| quay_configuration.feature.ui_v2_repo_settings | bool | false | Enables repository settings in the beta UI Environment |
| quay_configuration.feature.user_creation | bool | true | Whether users can be created (by non-superusers) |
| quay_configuration.feature.user_initialize | bool | false | To create the first user, users need to set the FEATURE_USER_INITIALIZE parameter to true |
| quay_configuration.feature.user_last_accessed | bool | true | Whether to record the last time a user was accessed |
| quay_configuration.feature.user_log_access | bool | false | If set to true, users will have access to audit logs for their namespace |
| quay_configuration.feature.user_metadata | bool | false | Whether to collect and support user metadata |
| quay_configuration.feature.user_rename | bool | false | If set to true, users can rename their own namespace |
| quay_configuration.feature.username_confirmation | bool | true | If set to true, users can confirm and modify their initial usernames when logging in via OpenID Connect (OIDC) or a non-database internal authentication provider like LDAP. |
| quay_configuration.fresh_login_timeout | string | 5m | The time after which a fresh login requires users to re-enter their password |
| quay_configuration.maximum_layer_size | string | 20G | Maximum allowed size of an image layer. Pattern: ^[0-9]+(G\|M)$ |
| quay_configuration.preferred_url_scheme | string | http | One of http or https. Note that users only set their PREFERRED_URL_SCHEME to http when there is no TLS encryption in the communication path from the client to Quay. |
| quay_configuration.registry_state | string | normal | The state of the registry. Either: normal or read-only |
| quay_configuration.registry_title | string | Red Hat Quay | If specified, the long-form title for the registry. Displayed in frontend of your Red Hat Quay deployment, for example, at the sign in page of your organization. Should not exceed 35 characters. |
| quay_configuration.registry_title_short | string | Red Hat Quay | If specified, the short-form title for the registry. Title is displayed on various pages of your organization, for example, as the title of the tutorial on your organization’s Tutorial page. |
| quay_configuration.repo_mirror_interval | int | 30 | The number of seconds between checking for repository mirror candidates |
| quay_configuration.repo_mirror_rollback | bool | false | When set to true, the repository rolls back after a failed mirror attempt. |
| quay_configuration.repo_mirror_tls_verify | bool | false | Require HTTPS and verify certificates of Quay registry during mirror. |
| quay_configuration.search_max_result_page_count | int | 10 | Maximum number of pages the user can paginate in search before they are limited |
| quay_configuration.search_results_per_page | int | 10 | Number of results returned per page by search page |
| quay_configuration.session_cookie_secure | bool | false | Whether the secure property should be set on session cookies Set to True for all installations using SSL |
| quay_configuration.ssl_protocols | list | TLSv1.3 | If specified, nginx is configured to enabled a list of SSL protocols defined in the list. Removing an SSL protocol from the list disables the protocol during Red Hat Quay startup. ['TLSv1','TLSv1.1','TLSv1.2', `TLSv1.3] |
| quay_configuration.successive_trigger_failure_disable_threshold | int | 100 | If not set to None, the number of successive failures that can occur before a build trigger is automatically disabled. |
| quay_configuration.successive_trigger_internal_error_disable_threshold | int | 5 | If not set to None, the number of successive internal errors that can occur before a build trigger is automatically disabled |
| quay_configuration.super_user_list | list | admin | Additional SUPER_USERS besides the initial administraor as defined at init_user.username (default admin) |
| quay_configuration.tag_expiration_options | list | `["0s","1d","1w","2w","4w"]` | If enabled, the options that users can select for expiration of tags in their namespace.<br /> <b>Pattern:</b> ^[0-9]+(w\|m\|d\|h\|s)$  |
| quay_configuration.team_resync_stale_time | string | 30m | If team syncing is enabled for a team, how often to check its membership and resync if necessary.<br /> Pattern: ^[0-9]+(w\|m\|d\|h\|s)$<br /> Example: 2h |
| quay_configuration.user_recovery_token_lifetime | string | 30m | The length of time a token for recovering a user accounts is valid Pattern: ^[0-9]+(w\|m\|d\|h\|s)$ |
| quay_configuration.userfiles_path | string | userfiles | Path under storage in which to place user-uploaded files Example: userfiles |
| quay_configuration.v2_pagination_size | int | 50 | The number of results returned per page in V2 registry APIs |

### Quay Configuration Generic

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| quay_configuration.bucket.boto_timeout | int | 60 | Optional. The time, in seconds, until a timeout exception is thrown when attempting to read from a connection. The default is 60 seconds. Used by GoogleCloudStorage. |
| quay_configuration.bucket.is_secure | bool | true | Is the bucket connection secured (TLS) |
| quay_configuration.bucket.name | string | N/A | S3 Bucket name |
| quay_configuration.bucket.port | int | 443 | Port to access the bucket |
| quay_configuration.bucket.region | string | us-east-1 | Region of the bucket. Used for object storage S3Storage or STSS3Storage |
| quay_configuration.bucket.sas_token | string | some/path/ | SAS Token for Azure. Used by AzureStorage. |
| quay_configuration.bucket.sts_role_arn | string | None | The unique Amazon Resource Name (ARN). Used by STSS3Storage. |
| quay_configuration.bucket.swift_ca_path | string | /conf/stack/swift.cert | CA Path for Swift storage. Used by SwiftStorage. |
| quay_configuration.configmapName | string | quay-configuration-skeleton | Name of the config map skeleton |
| quay_configuration.enabled | bool | false | Enable Quay configuration |
| quay_configuration.s3_hostname.hostname | string | N/A | Hostname of the object storage. This is coming from a ConfigMap that is generated by ODF which is then mounted into /tmp/quay-bucket/BUCKET_HOST |
| quay_configuration.s3_hostname.overwrite | bool | false | Overwrite the hostname for the object storage. This might be required to use a public URL for example, instead of the name that is storaged by ODF. |
| quay_configuration.storage | object | `{"instance":"RadosGWStorage","maximum_chunk_size_mb":100,"server_side_assembly":true}` | Storage Settings. Verify the Quay documentation about the object storage configuration: <a href=https://docs.redhat.com/en/documentation/red_hat_quay/3.11/html-single/configure_red_hat_quay/index#config-fields-storage-noobaa>Quay Storage Configuration</a> |
| quay_configuration.storage.instance | string | RadosGWStorage | Instance of storage that shall be used. Dependent on the instance type, different parameters are used in the configuration. There are some types Quay supports:<br /> <ul>   <li>LocalStorage</li>   <li>RHOCSStorage</li>   <li>RadosGWStorage (default) - Ceph/RadosGW and Nutanix</li>   <li>S3Storage</li>   <li>STSS3Storage</li>   <li>GoogleCloudStorage</li>   <li>AzureStorage</li>   <li>SwiftStorage</li>   <li>IBMCloudStorage</li> </ul> |
| quay_configuration.storage.maximum_chunk_size_mb | int | 100Mb | Defines the maximum chunk size in MB for the final copy. Has no effect if server_side_assembly is set to false. Used by RadosGWStorage, RHOCSStorage, IBMCloudStorage |
| quay_configuration.storage.server_side_assembly | bool | true | Whether Red Hat Quay should try and use server side assembly and the final chunked copy instead of client assembly. Defaults to true. |
| quay_configuration.syncwave | int | 3 | Syncwave for generating the quay configuration |

## Example values to configure the Operator

This will configure the Quay Operator the start/manage Quay Enterprise with all components, except:

* Horizontal Pod Autoscaler (HPA)
* Objectstorage
* Mirroring

For those three that managed is set to "false" in this example.

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

## Example values to configure Quay itself

Quay comes with a massive configuration that is stored in a Secret object because it contains some sensitive data (for example, the connection information to the bucket storage).
Moreover, the configuration must follow a very specific layout. (for example, booleans must be booleans and not strings, which might be a hassle when working with Helm)

This Chart allows you to define the configuration settings in the values file. It will pick up these parameters and generate a Secret object, injecting or merging any
sensitive data.

The typical workflow is (assuming we are using ODF object storage)
1. Creating the BucketClaim --> This will generate a Secret and a ConfigMap providing the connection information to the bucket
2. A Job will generate the Quay configuration using the Sekelton and the values provided in the values file.
3. The Job will create a Secret object with the Quay configuration.

The following is a (huge) example of possible settings and the default values.

**NOTE**: Not each and every setting has been implemented yet. For example: LDAP Authentication... I simply do not have LDAP available for testing.
However, the Chart can be enriched with such configuration.

```yaml
  #####################
  # QUAY CONFIGURATION
  #####################
  # Any setting here is OPTIONAL and will overwrite or append the default setting.
  # ATTN: Helm does not work very well with booleans and the Quay configuration settings must have boolean types (strings with quotes are not accepted)
  # Therefore it is a bit tricky to make this configurable.
  #
  # 1. Quote them, to make them strings and compare them, then using trimAll to remove the quotes again.
  # For the ConfigMap this should be good enough.
  #
  # If you miss any value simply define it here and in the skeleton for the configMap - I did not test any possibility
  # For example mail od LDAP configurations are currently missing, but can be extended.

  # Additional SUPER_USERS besides the initial administraor as defined at init_user.username (default admin)
  super_user_list:
    - second_admin

  # The authentication engine to use for credential authentication.
  # Values:
  #    One of Database, LDAP, JWT, Keystone, OIDC
  # Default: Database
  # authentication_type: database

  # If enabled, only API calls marked as being made by an XHR will be allowed from browsers
  # Default: false
  browser_api_calls_xhr_only: false

  # Additional features that can be activated or deactivated
  feature:
    # To create the first user, users need to set the FEATURE_USER_INITIALIZE parameter to true
    # Default: false
    user_initialize: true

    # Enabling log rotation and archival will move all logs older than 30 days to storage.
    # Default: false
    # action_log_rotation: false

    # Whether to allow retrieval of aggregated log counts
    # Default: true
    # aggregated_log_count_retrieval: true

    # Whether to allow anonymous users to browse and pull public repositories
    # Default: true
    anonymous_access: false

    # When set, allows users to try the beta UI environment.
    # Default: true
    # ui_v2: false

    # If enabled, users can create tokens for use by the Docker CLI
    # Default: true
    # app_specific_tokens: true

    # Whether to support Bitbucket build triggers.
    # Default: false
    # bitbucket_build: false

    # If set to true, no new User accounts may be created if their email domain is blacklisted
    # Default: false
    # blacklisted_emails: false

    # Whether to support Dockerfile build.
    # Default: false
    # build_support: false

    # Whether users and organizations are allowed to change the tag expiration for tags in their namespace.
    # Default: true
    # change_tag_expiration: true

    # Whether users can directly login to the UI
    # Default: true
    # direct_login: true

    # Enable support for nested repositories
    # Default: true
    # extended_repository_names: true

    # If set to true, Red Hat Quay will run using FIPS-compliant hash functions
    # Default: false
    # fips: false

    # Whether garbage collection of repositories is enabled.
    # Default: true
    # garbage_collection: true

    # Enable support for OCI artifacts.
    # Default: true
    # general_oci_support: true

    # Whether to support GitHub build triggers.
    # Default: false
    # github_build: false

    # Whether GitHub login is supported
    # Default: false
    # github_login: false

    # Whether to support GitLab build triggers.
    # Default: false
    # gitlab_build: false

    # Whether Google login is supported.
    # Default: false
    # google_login: false

    # Enable support for Helm artifacts.
    # Default: false
    helm_oci_support: true

    # Whethe users being created must be invited by another user
    # Default: false
    # invite_only_user_creation: false

    # Whether to allow for "namespace-less" repositories when pulling and pushing from Docker
    # Default: true
    # library_support: true

    # Whether to allow exporting of action logs.
    # Default: true
    # log_export: true

    # Whether emails are enabled
    # Default: false
    # mailing: false

    # If enabled, non-superusers can setup syncing on teams using LDAP.
    # Default: false
    # nonsuperuser_team_syncing_setup: false

    # If set to true, autocompletion will apply to partial usernames
    # Default: true
    # partial_user_autocomplete: true

    # Whether to proxy all direct download URLs in storage through NGINX.
    # Default: false
    proxy_storage: true

    # If set to true, the _catalog endpoint returns public repositories. Otherwise, only private repositories can be returned.
    # Default: false
    # public_catalog: false

    # Enables configuration, caching, and validation for quota management feature.
    # Default: false
    # quota_management: false

    # Whether to enable rate limits on API and registry endpoints. Setting FEATURE_RATE_LIMITS to true causes nginx to
    # limit certain API calls to 30 per second. If that feature is not set, API calls are limited to 300 per second (effectively unlimited).
    # Default: false
    # rate_limits: false

    # If set to true, build logs can be read by those with read access to the repository, rather than only write access or admin access.
    # Default: false
    # reader_build_logs: false

    # Whether Recaptcha is necessary for user login and recovery
    # Default: false
    # recaptcha: false

    # If set to true, enables repository mirroring.
    # Default: true
    # repo_mirror: true

    # If set to true, only namespaces listed in V1_PUSH_WHITELIST support V1 push
    # Default: true
    # restricted_v1_push: true

    # If the security scanner is enabled, turn on or turn off security notifications
    # Default: false
    security_notifications: true

    # Whether to automatically replicate between storage engines.
    # Default: false
    # storage_replication: false

    # Whether superusers are supported
    # Default: true
    # super_users: true

    # Whether to allow for team membership to be synced from a backing group in the authentication engine (LDAP or Keystone).
    # Default: true
    # team_syncing: true

    # When set, allows users to try the beta UI environment.
    # Default: true
    # ui_v2: true

    # Enables repository settings in the beta UI Environment
    # Default: false
    # ui_v2_repo_settings: false

    # Whether users can be created (by non-superusers)
    # Default: true
    user_creation: false

    # Whether to record the last time a user was accessed
    # Default: true
    # user_last_accessed: true

    # If set to true, users will have access to audit logs for their namespace
    # Default: false
    # user_log_access: false

    # Whether to collect and support user metadata
    # Default: false
    # user_metadata: false

    # If set to true, users can rename their own namespace
    # Default: false
    # user_rename: false

    # If set to true, users can confirm and modify their initial usernames when logging in via OpenID Connect (OIDC) or a non-database internal authentication provider like LDAP.
    # Default: true
    username_confirmation: false

    # Whether garbage collection is enabled for repositories.
    # Defaults to true.
    # repository_garbage_collection: true

    # Whether to support signing
    # Default: false
    # signing: false

  # The time after which a fresh login requires users to re-enter their password
  # Default: 5m
  # fresh_login_timeout: 5m

  # Maximum allowed size of an image layer.
  # Pattern: ^[0-9]+(G|M)$
  # Default: 20G
  # maximum_layer_size: 20G

  # One of http or https. Note that users only set their PREFERRED_URL_SCHEME to http
  # when there is no TLS encryption in the communication path from the client to Quay.
  # Default: http
  preferred_url_scheme: https

  # The state of the registry
  # Either: normal or read-only
  # registry_state: normal

  # If specified, the long-form title for the registry. Displayed in frontend of your Red Hat Quay deployment,
  # for example, at the sign in page of your organization. Should not exceed 35 characters.
  # Default: Red Hat Quay
  # registry_title: Red Hat Quay

  # If specified, the short-form title for the registry. Title is displayed on various pages of your organization,
  # for example, as the title of the tutorial on your organization’s Tutorial page.
  # Default: Red Hat Quay
  # registry_title_short: Red Hat Quay

  # The number of seconds between checking for repository mirror candidates
  # Default: 30
  # repo_mirror_interval: 30

  # When set to true, the repository rolls back after a failed mirror attempt.
  # Default: false
  # repo_mirror_rollback: false

  # Require HTTPS and verify certificates of Quay registry during mirror.
  # DEfault: false
  # repo_mirror_tls_verify: false

  # Maximum number of pages the user can paginate in search before they are limited
  # Default: 10
  # search_max_result_page_count: 10

  # Number of results returned per page by search page
  # Default: 10
  search_results_per_page: 30

  # Whether the secure property should be set on session cookies
  # Set to True for all installations using SSL
  # Default: false
  # session_cookie_secure: false

  # If specified, nginx is configured to enabled a list of SSL protocols defined in the list.
  # Removing an SSL protocol from the list disables the protocol during Red Hat Quay startup.
  # ['TLSv1','TLSv1.1','TLSv1.2', `TLSv1.3]
  # Default: TLSv1.3
  ssl_protocols:
    - TLSv1.2
    - TLSv1.3

  # If not set to None, the number of successive failures that can occur before a build trigger is automatically disabled.
  # Default: 100
  # successive_trigger_failure_disable_threshold: 100

  # If not set to None, the number of successive internal errors that can occur before a build trigger is automatically disabled
  # Default: 5
  # successive_trigger_internal_error_disable_threshold: 5

  # The length of time a token for recovering a user accounts is valid
  # Pattern: ^[0-9]+(w|m|d|h|s)$
  # Default: 30m
  # user_recovery_token_lifetime: 30m

  # Path under storage in which to place user-uploaded files
  # Example: userfiles
  # userfiles_path: userfiles/

  # The number of results returned per page in V2 registry APIs
  # Default: 50
  # v2_pagination_size: 100

  # If team syncing is enabled for a team, how often to check its membership and resync if necessary.
  # Pattern: ^[0-9]+(w|m|d|h|s)$
  # Example: 2h
  # Default: 30m
  # team_resync_stale_time: 30m

  # If enabled, the options that users can select for expiration of tags in their namespace.
  # ^[0-9]+(w|m|d|h|s)$
  #
  # Default:
  #  - 0s
  #  - 1d
  #  - 1w
  #  - 2w
  #  - 4w
  # tag_expiration_options:
  #  - 0s
  #  - 1d
  #  - 1w
  #  - 2w
  #  - 4w

  # The default, configurable tag expiration time for time machine.
  # Pattern: ^[0-9]+(w|m|d|h|s)$
  # Default: 2w
  # default_tag_expiration: 2w

  # If true, pulls will still succeed even if the pull audit log entry cannot be written.
  # This is useful if the database is in a read-only state and it is desired for pulls to continue during that time.
  # Default: false
  # allow_pulls_without_strict_logging: false

  # The types of avatars to display, either generated inline (local) or Gravatar (gravatar)
  # Default: local
  # avatar_kind: local

  # Whether new repositories created by push are set to private visibility
  # Default: true
  # create_private_repo_on_push: true

  # Enables system default quota reject byte allowance for all organizations.
  # By default, no limit is set. --> 1.073741824e+11
  # default_system_reject_quota_bytes: 1.073741824e+11
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
