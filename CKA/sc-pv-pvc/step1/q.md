
> <strong>Useful Resources</strong>: [Persistent Volumes & Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) , [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Your task involves setting up storage components in a Kubernetes cluster. Follow these steps:

Step 1: Create a Storage Class named `blue-stc-cka` with the following properties:
* Provisioner: `kubernetes.io/no-provisioner`
* Volume binding mode: `WaitForFirstConsumer`

Step 2: Create a Persistent Volume (PV) named `blue-pv-cka` with the following properties:
* Capacity: `100Mi`
* Access mode: `ReadWriteOnce`
* Reclaim policy: `Retain`
* Storage class: `blue-stc-cka`
* Local path: `/opt/blue-data-cka`
* Node affinity: Set node affinity to create this PV on `controlplane`.

Step 3: Create a Persistent Volume Claim (PVC) named `blue-pvc-cka` with the following properties:
* Access mode: `ReadWriteOnce`
* Storage class: `blue-stc-cka`
* Storage request: `50Mi`
* The volume should be bound to `blue-pv-cka`.