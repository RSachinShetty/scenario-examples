
> <strong>Useful Resources</strong>: [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) , [Secret](https://kubernetes.io/docs/concepts/configuration/secret/) , [Distribute Credentials Securely](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Currently, the `webapp-deployment` is running with sensitive database environment variables directly embedded in the deployment YAML. To enhance security and protect the sensitive data, perform the following steps:

* Create a Kubernetes Secret named `db-secret` with the below sensitive database environment variable values:
    * Key: `DB_Host`, Value: `mysql-host`
    * Key: `DB_User`, Value: `root`
    * Key: `DB_Password`, Value: `dbpassword`
* Update the `webapp-deployment` to load the sensitive database environment variables from the newly created `db-secret` Secret.