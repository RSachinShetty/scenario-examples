
> <strong>Useful Resources</strong>: [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/) , [Persistent Volumes Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) , [Pods](https://kubernetes.io/docs/concepts/workloads/pods/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

* Create a Storage Class named `fast-storage` with a provisioner of `kubernetes.io/no-provisioner` and a `volumeBindingMode` of `Immediate`.

* Create a Persistent Volume (PV) named `fast-pv-cka` with a storage capacity of `50Mi` using the `fast-storage` Storage Class with `ReadWriteOnce` permission and host path `/tmp/fast-data`.

* Create a Persistent Volume Claim (PVC) named `fast-pvc-cka` that requests `30Mi` of storage from the `fast-pv-cka` PV(using the `fast-storage` Storage Class).

* Create a Pod named `fast-pod-cka` with `nginx:latest` image that uses the `fast-pvc-cka` PVC and mounts the volume at the path `/app/data`.