
> <strong>Useful Resources</strong>: [Service account](https://kubernetes.io/docs/concepts/security/service-accounts/) , [RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


You have a service account named `prod-sa`, a Role named `prod-role-cka`, and a RoleBinding named `prod-role-binding-cka`.
we are trying to `create` `list` and `get` the `services`. However, using `prod-sa` service account is not able to perform these operations. fix this issue.