
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>



Create a ReplicaSet named `dns-rs-cka` with `2` replicas in the `dns-ns` namespace using the image `registry.k8s.io/e2e-test-images/jessie-dnsutils:1.3` and set the command to `sleep 3600` with the container named `dns-container`.

Once the pods are up and running, run the `nslookup kubernetes.default` command from any one of the pod and save the output into a file named `dns-output.txt`.