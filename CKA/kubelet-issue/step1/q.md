
> <strong>Useful Resources</strong>: [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

In `controlplane` node, something problem with `kubelet` configuration files, fix that issue 

You can `ssh controlplane`

location: /var/lib/kubelet/config.yaml and /etc/kubernetes/kubelet.conf