
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Find the Node that consumes the most MEMORY in all cluster(currently we have single cluster). Then, store the result in the file `high_memory_node.txt` with the following format: `cluster_name,node_name`.