
> <strong>Useful Resources</strong>: [RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


You have a service account named `group1-sa`, a ClusterRole named `group1-role-cka`, and a ClusterRoleBinding named `group1-role-binding-cka`. Your task is to update the permissions for the `group1-sa` service account so that it can only `create`, `get` and `list` the `deployments` and no other resources in the cluster.