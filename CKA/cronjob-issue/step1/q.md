
> <strong>Useful Resources</strong>: [Pods](https://kubernetes.io/docs/concepts/workloads/pods/) , [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

`cka-pod` pod exposed internally within the service name `cka-service` and for `cka-pod` monitor(access through svc) purpose deployed `cka-cronjob` cronjob that run `every minute`.

Now `cka-cronjob` cronjob not working as expected, fix that issue