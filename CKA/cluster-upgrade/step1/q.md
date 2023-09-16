
> <strong>Useful Resources</strong>: [Cluster Upgrade](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Upgrade `controlplane` node `kubeadm`, `cluster` and `kubelet` to next version.

EXAMPLE: If current version is `v1.27.1` then upgrade to `v1.27.2`

***********
|`kubeadm`|
***********

BEFORE UPGRADE: ( `v1.27.1` )

![Scan results](./2.png)

AFTER UPGRADE: ( `v1.27.2` )

![Scan results](./b.png)

*******************
|`Cluster Upgrade`|
*******************

BEFORE UPGRADE: ( `v1.27.1` )

![Scan results](./3.png)

AFTER UPGRADE: ( `v1.27.2` )

![Scan results](./c.png)

*******************
|`kubelet Upgrade`|
*******************

BEFORE UPGRADE: ( `v1.27.1` )

![Scan results](./1.png)

AFTER UPGRADE: ( `v1.27.2` )

![Scan results](./a.png)

Similarly verify upgradation for current verion. ( ex:- `v1.27.1` to `v1.27.2` )