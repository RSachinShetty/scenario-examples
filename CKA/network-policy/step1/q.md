
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


`my-app-deployment` deployed, and they are exposed through a service named `my-app-service`. Create a NetworkPolicy named `my-app-network-policy` to restrict incoming and outgoing traffic to these pods with the following specifications:

* Allow incoming traffic only from pods within the same namespace.
* Allow incoming traffic from a specific pod with the label "app=trusted."
* Allow outgoing traffic to pods within the same namespace.
* Deny all other incoming and outgoing traffic.