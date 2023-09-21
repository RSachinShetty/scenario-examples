
> <strong>Useful Resources</strong>: [Service account](https://kubernetes.io/docs/concepts/security/service-accounts/) , [RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


You have a service account named `dev-sa`, a Role named `dev-role-cka`, and a RoleBinding named `dev-role-binding-cka`.
we are trying to `create` `list` and `get` the `pods` and `services`. However, using `dev-sa` service account is not able to perform these operations. fix this issue.