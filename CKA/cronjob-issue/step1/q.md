
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

`hello-world-pod` pod exposed internally within the service name `hello-world-service` and for `hello-world-pod` monitor(access through svc) purpose deployed `hello-world-cronjob` cronjob that run every minute.

Now `hello-world-cronjob` cronjob not working as expected, fix that issue