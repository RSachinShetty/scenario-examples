
> <strong>Useful Resources</strong>: [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


`red-pod`, `green-pod`, `blue-pod` pods are running, and `red-pod` exposed within the cluster using `red-service` service. and network policy applied on `red-pod` pod. problem is now the pod `red-pod` is accessible from both `green-pod` and `blue-pod` pods. fix the issue that `green-pod` only can able access `red-pod` pod.
