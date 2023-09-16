
> <strong>Useful Resources</strong>: [Persistent Volumes & Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Create a PersistentVolume (PV) and a PersistentVolumeClaim (PVC) using an existing storage class named `gold-stc-cka` to meet the following requirements:

Step 1: Create a Persistent Volume (PV)
* Name the PV as `gold-pv-cka`.
* Set the capacity to `50Mi`.
* Use the volume type hostpath with the path `/opt/gold-stc-cka`.
* Assign the storage class as `gold-stc-cka`.
* Ensure that the PV is created on `node01`, where the `/opt/gold-stc-cka` directory already exists.
* Apply a label to the PV with key `tier` and value `white`.

Step 2: Create a Persistent Volume Claim (PVC)
* Name the PVC as `gold-pvc-cka`.
* Request `30Mi` of storage from the PV `gold-pv-cka` using the matchLabels criterion.
* Use the `gold-stc-cka` storage class.
* Set the access mode to `ReadWriteMany`.