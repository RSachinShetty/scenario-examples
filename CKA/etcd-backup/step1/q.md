
> <strong>Useful Resources</strong>: [ETCD](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

`etcd-controlplane` pod is running in `kube-system` environment, take backup and store it in `/opt/cluster_backup.db` file, and also store backup console output store it in `backup.txt`

`ssh controlplane`
