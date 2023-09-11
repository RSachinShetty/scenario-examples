
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Fresher deployed a pod named `my-pod`. However, while specifying the resource limits, they mistakenly used `Gebibyte` as the unit instead of `Mebibyte`

* node doesn't have sufficient resources, So change it to `Mebibyte` only.