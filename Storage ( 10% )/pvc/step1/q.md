
> <strong>Useful Resources</strong>: [Persistent Volumes & Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) , [Pod to Use a PV](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

A persistent volume named `red-pv-cka` is available. Your task is to create a PersistentVolumeClaim (PVC) named `red-pvc-cka` and request `30Mi` of storage from the `red-pv-cka` PersistentVolume (PV).

Ensure the following criteria are met:

Access mode: `ReadWriteOnce`
Storage class: `manual`
