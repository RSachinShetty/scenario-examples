
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>



Within the default namespace, there is a web application pod named `webapp-deployment` that relies on an environment variable that can change frequently. You need to manage this environment variable using a ConfigMap. Follow these steps:

* Create a new ConfigMap named `webapp-deployment-config-map` with the key-value pair `APPLICATION=web-app`.
* Update the deployment `webapp-deployment` to utilize the newly created ConfigMap.