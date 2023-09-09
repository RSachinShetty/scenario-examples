
> <strong>Useful Resources</strong>: [Persistent Volumes Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Modify the size of the existing Persistent Volume Claim (PVC) named `yellow-pvc-cka` to request `60Mi` of storage from the `yellow-pv-cka` volume. Ensure that the PVC successfully resizes to the new size and remains in the `Bound` state.