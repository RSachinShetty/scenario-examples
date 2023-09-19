
> <strong>Useful Resources</strong>: [Service](https://kubernetes.io/docs/concepts/services-networking/service/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Create a NodePort service named `app-service-cka` (with below specification) to expose the `nginx-app-cka` deployment in the `nginx-app-space` namespace.
* port & target port `80`
* protocol `TCP` 
* node port `31000` 