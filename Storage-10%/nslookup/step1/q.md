
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Create a pod named `dns-pod-cka` using the `registry.k8s.io/e2e-test-images/jessie-dnsutils:1.3` image add `sleep 3600` command, and expose it internally with a service named `dns-service-cka`. Verify your ability to perform DNS lookups for the service and pod names from within the cluster using the `busybox` image. Record the results in `dns-service.txt` and `dns-pod.txt`.

