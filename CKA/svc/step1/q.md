
> <strong>Useful Resources</strong>: [Service](https://kubernetes.io/docs/concepts/services-networking/service/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>



You have an existing Nginx pod named `nginx-pod`. Perform the following steps:

* Expose the `nginx-pod` internally within the cluster using a Service named `nginx-service`.
* Use `port forwarding` to service to access the Welcome content of nginx-pod using the `curl` command.