
> <strong>Useful Resources</strong>: [Pods](https://kubernetes.io/docs/concepts/workloads/pods/) , [Service](https://kubernetes.io/docs/concepts/services-networking/service/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

You need to create a Kubernetes Pod and a Service to host a simple web application that prints "Hello, World!" when accessed. Follow these steps:

Create a Pod named `app-pod` with the following specifications:
* Container name: `app-container`
* Container image: `httpd:latest`
* Container port: `80`

Create a Service named `app-svc` with the following specifications:
* Select the Pod with the label app: `app-lab`.
* Service port: `80`
* Target port: `80`
* Service type: `ClusterIP`

* kubectl port-forward to forward a local port to the Pod's port

* Access the web application using `curl` on another terminal