
> <strong>Useful Resources</strong>: [Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) , [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) , [Service](https://kubernetes.io/docs/concepts/services-networking/service/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Create a Deployment named `dns-deploy-cka` with `2` replicas in the `dns-ns` namespace using the image `registry.k8s.io/e2e-test-images/jessie-dnsutils:1.3` and set the command to `sleep 3600` with the container named `dns-container`.

Once the pods are up and running, run the `nslookup kubernetes.default` command from any one of the pod and save the output into a file named `dns-output.txt`.