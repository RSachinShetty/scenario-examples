
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Create a deployment named `my-web-app-deployment` using the Docker image `sachinhr/my-python-app` with `2` replicas. Then, expose the `my-web-app-deployment` as a service named `my-web-app-service`, making it accessible on port `30770` on the nodes of the cluster.




