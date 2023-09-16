
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

when you run `kubectl get nodes` OR `kubectl get pod -A` threw :-
`The connection to the server 172.30.1.2:6443 was refused - did you specify the right host or port?`
* need to wait for few seconds to make above command work again but above error will come again after few second
* and also `kube-controller-manager-controlplane` pod continuously restarting
Fix above issue

Expectation: both `kube-controller-manager-controlplane` and `kube-apiserver-controlplane` pods running in `kube-system` namespace 

You can `ssh controlplane`