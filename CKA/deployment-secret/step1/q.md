
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Currently, the `webapp-deployment` is running with sensitive database environment variables directly embedded in the deployment YAML. To enhance security and protect the sensitive data, perform the following steps:

* Create a Kubernetes Secret named `db-secret` with the sensitive database environment variable values(base64):
    * Key: `DB_Host`, Value: `mysql-host`
    * Key: `DB_User`, Value: `root`
    * Key: `DB_Password`, Value: `dbpassword`
Update the `webapp-deployment` to load the sensitive database environment variables from the newly created `db-secret` Secret.