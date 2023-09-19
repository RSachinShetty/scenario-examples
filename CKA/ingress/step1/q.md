
> <strong>Useful Resources</strong>: [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


There exists a deployment named `nginx-deployment` exposed through a service called `nginx-service`. Create an ingress resource named `nginx-ingress-resource` to efficiently distribute incoming traffic with the following settings: `pathType: Prefix`, `path: /shop`, Backend Service `Name: nginx-service`, Backend Service `Port: 80`, ssl-redirect should be configured as `false`.