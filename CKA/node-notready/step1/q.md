
> <strong>Useful Resources</strong>: [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


`kubelet` service not running in `controlplane`, it will cause the `controlplane` in `NotReady` state, so fix this issue