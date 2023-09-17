
> <strong>Useful Resources</strong>: [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Due to a missing feature in the current version. To resolve this issue, perform a rollback of the deployment `redis-deployment ` to the previous version. After rolling back the deployment, save the image currently in use to the `rolling-back-image.txt` file, and finally increase the replica count to `3`."