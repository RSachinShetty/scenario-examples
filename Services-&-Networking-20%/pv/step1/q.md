
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Create a PersistentVolume (PV) named `black-pv-cka` with the following specifications:

* Volume Type: `hostPath`
* Path: `/opt/black-pv-cka`
* Capacity: `50Mi`