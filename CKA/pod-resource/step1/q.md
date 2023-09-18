
> <strong>Useful Resources</strong>: [Kubectl](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Find the pod that consumes the most CPU in all namespace(including kube-system) in all cluster(currently we have single cluster). Then, store the result in the file `high_cpu_pod.txt` with the following format: `pod_name,namespace`.