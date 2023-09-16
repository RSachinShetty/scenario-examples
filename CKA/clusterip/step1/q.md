
> <strong>Useful Resources</strong>: [ClusterIP](https://kubernetes.io/docs/concepts/services-networking/cluster-ip-allocation/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Part I:
* Create a Kubernetes ClusterIP service named `nginx-service`. This service should expose to `nginx-deployment`, using port `8080` and target port `80`

Part II:
* Retrieve and store the IP addresses of the pods. Sort the output by their IP addresses in Ascending order and save it to the file `pod_ips.txt` in the following format:

```
IP_ADDRESS
127.0.0.1
127.0.0.2
127.0.0.3
```{{}}
