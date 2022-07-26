## Sealed Secrets

deploys sealed-secrets (disabled by default)

be sure to enable it and also install the CRDs: 

```
helm upgrade --install sealed-secrets tjungbauer/sealed-secrets --set 'sealed-secrets.enabled=true'
```



## Example Usage

... once the operator has been installed the command line tool **kubeseal** must be installed

Either use `brew install kubeseal` or download your appropriate release from: https://github.com/bitnami-labs/sealed-secrets/releases

## Simple tests

* Create a new project `oc new-project myproject`

* Create s secret: 

  ```
  echo -n bar | kubectl create secret generic mysecret --dry-run=client --from-file=foo=/dev/stdin -o yaml >mysecret.json`
  ```

  UNENCRYPTED secreted stored as mysecret.json --> not good practice, but good for testing :)

  Seal the secret:
  
  ```
  kubeseal --controller-name=sealed-secrets --controller-namespace=sealed-secrets <mysecret.json >mysealedsecret.json`
  ```

  Sealed secret stored at mysealedsecret.json. It is save to store this on Github

* Installed the sealed secret `oc create -f mysealedsecret.json`

  Verify the existence:

  ```
  ❯ oc get SealedSecret
  NAME       AGE
  mysecret   4s
  ```

  ```
  ❯ oc get secrets mysecret
  NAME       TYPE     DATA   AGE
  mysecret   Opaque   1      13s
  ```

## Updating or appending new values

```
echo -n "my new password" \
    | kubectl create secret generic dummy --dry-run=client --from-file=password=/dev/stdin -o json \
    | kubeseal --controller-namespace=sealed-secrets --controller-name=sealed-secrets --format yaml --merge-into mysealedsecret.json
```

```
❯ oc apply -f mysealedsecret.json
sealedsecret.bitnami.com/mysecret configured
```

```
❯ oc get secrets mysecret
NAME       TYPE     DATA   AGE
mysecret   Opaque   2      3m32s
```