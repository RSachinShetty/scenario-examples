
> <strong>Useful Resources</strong>: [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


`my-app-deployment` and `cache-deployment` deployed, and `my-app-deployment` deployment exposed through a service named `my-app-service`. Create a NetworkPolicy named `my-app-network-policy` to restrict incoming and outgoing traffic to `my-app-deployment` pods with the following specifications:

* Allow incoming traffic only from pods within the same namespace.
* Allow incoming traffic from a specific pod with the label `app=trusted`
* Allow outgoing traffic to pods within the same namespace.
* Deny all other incoming and outgoing traffic.
