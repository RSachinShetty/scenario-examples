
> <strong>Useful Resources</strong>: [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

`cache-daemonset` DaemonSet deployed, now it's not creating any pod on the `controlplane` node. fix this issue and make sure the pods are getting created on all nodes including the controlplane node as well.