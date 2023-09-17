
> <strong>Useful Resources</strong>: [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Create a new deployment named `cache-deployment` in the default namespace using a custom image `redis:7.0.13`. Ensure that the deployment has the following specifications:

* Set the replica count to `2`.
* Set the strategy type `RollingUpdate`
* Configure the `MaxUnavailable` field to `30%` and the `MaxSurge` field to `45%`.
* Deploy the `cache-deployment` deployment and ensure that all pods are in a ready state.
* Now, Perform an image upgrade to `redis:7.2.1`.
* Examine the rolling history of the deployment, and save the Total revision count to the `total-revision.txt`.