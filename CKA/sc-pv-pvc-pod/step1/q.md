
> <strong>Useful Resources</strong>: [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

* Create a Storage Class named `fast-storage` with a provisioner of `kubernetes.io/no-provisioner` and a `volumeBindingMode` of `Immediate`.

* Create a Persistent Volume (PV) named `fast-pv-cka` with a storage capacity of 50Mi using the fast-storage Storage Class.

* Create a Persistent Volume Claim (PVC) named `fast-pvc-cka` that requests `30Mi` of storage from the `fast-pv-cka` PV.

* Create a Pod named fast-pod-cka that uses the fast-pvc-cka PVC and mounts the volume at the path /app/data.