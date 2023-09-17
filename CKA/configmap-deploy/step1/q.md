
> <strong>Useful Resources</strong>: [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) , [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/) , [Configure Pod Configmap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>



Within the default namespace, there is a web application deployment named `webapp-deployment` that relies on an environment variable that can change frequently. You need to manage this environment variable using a ConfigMap. Follow these steps:

* Create a new ConfigMap named `webapp-deployment-config-map` with the key-value pair `APPLICATION=web-app`.
* Update the deployment `webapp-deployment` to utilize the newly created ConfigMap.