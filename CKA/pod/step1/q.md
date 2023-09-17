
> <strong>Useful Resources</strong>: [Pods](https://kubernetes.io/docs/concepts/workloads/pods/) , [Resource Management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Fresher deployed a pod named `my-pod`. However, while specifying the resource limits, they mistakenly given `100Mi` storage limit  instead of `50Mi`

* node doesn't have sufficient resources, So change it to `50Mi` only.