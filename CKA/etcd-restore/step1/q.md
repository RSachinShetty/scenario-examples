
> <strong>Useful Resources</strong>: [ETCD](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

`etcd-controlplane` pod is running in `kube-system` environment, take backup and store it in `/opt/cluster_backup.db` file.

ETCD backup is stored at the path `/opt/cluster_backup.db` on the `controlplane` node. for --data-dir use `/root/default.etcd`, restore it on the `controlplane` node itself and , and also store restore console output store it in `restore.txt`

`ssh controlplane`
