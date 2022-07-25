## Sealed Secrets

deploys sealed-secrets (disabled by default)

be sure to enable it and also install the CRDs: 

´´´
helm template . --set 'sealed-secrets.enabled=true' --include-crds
´´´