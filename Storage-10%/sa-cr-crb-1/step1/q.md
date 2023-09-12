
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Create a service account named `app-account`, a cluster role named `app-role-cka`, and a cluster role binding named `app-role-binding-cka`. Update the permissions of this service account so that it can `get` the `pods` only in the default namespace.