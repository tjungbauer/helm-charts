# DEMO Pipeline using OpenShift Pipelines/Tekton

In order to automatically trigger a PipelineRun when a git push even happend do the following: 

1. Create a Secret like the following

```
kind: Secret
apiVersion: v1
metadata:
  name: github-secret
  namespace: pipeline-lint-demo
data:
  secretToken: XXXX
type: Opaque
```

NOTE: Change the secretToken to whatever password you like

2. Configure github repository at: 
Settings > Webhooks > Create new Webhook 

Enter the following 3 parameters:

- Event Listener URL (oc get routes... )
- Content Type -> application/json
- Secret: you secure password from Step #1
