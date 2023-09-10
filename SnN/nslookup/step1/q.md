
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Create an nginx pod named `nginx-pod-cka` using the `nginx` image, and expose it internally with a service named `nginx-service-cka`. Verify your ability to perform DNS lookups for the service and pod names from within the cluster using the `busybox` image. Record the results in `nginx-service.txt` and `nginx-pod.txt`.

