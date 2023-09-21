
> <strong>Useful Resources</strong>: [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) , [ETCD](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

something is not working at the moment on controlplane node(Cause NotReady state), check that and `etcd-controlplane` pod is running in `kube-system` environment, take backup and store it in `/opt/cluster_backup.db` file, and also store backup console output store it in `backup.txt`

`ssh controlplane`
