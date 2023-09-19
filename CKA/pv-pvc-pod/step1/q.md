
> <strong>Useful Resources</strong>: [Persistent Volumes & Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) , [Pod to Use a PV](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

You are responsible for provisioning storage for a Kubernetes cluster. Your task is to create a PersistentVolume (PV), a PersistentVolumeClaim (PVC), and deploy a pod that uses the PVC for shared storage.

Here are the specific requirements:
* Create a PersistentVolume (PV) named `my-pv-cka` with the following properties:
    * Storage capacity: `100Mi`
    * Access mode: `ReadWriteOnce`
    * Host path: `/mnt/data`
    * Storage class: `standard`
* Create a PersistentVolumeClaim (PVC) named `my-pvc-cka` to claim storage from the `my-pv-cka` PV, with the following properties:
    * Storage class: `standard`
    * request storage: `100Mi`(less than)
* Deploy a pod named `my-pod-cka` using the `nginx` container image.
* Mount the PVC, `my-pvc-cka`, to the pod at the path `/var/www/html`.
Ensure that the PV, PVC, and pod are successfully created, and the pod is in a Running state.

Note: Binding and Pod might take time to come up, please have patience