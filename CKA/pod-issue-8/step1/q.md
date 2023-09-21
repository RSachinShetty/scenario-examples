
> <strong>Useful Resources</strong>: [Pods](https://kubernetes.io/docs/concepts/workloads/pods/) , [Service](https://kubernetes.io/docs/concepts/services-networking/service/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

`nginx-pod` exposed to service `nginx-service`, 

when port-forwarded `kubectl port-forward svc/nginx-service 8080:80` it is stuck, so unable to access application `curl http://localhost:8080`

fix this issue