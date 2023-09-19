
> <strong>Useful Resources</strong>: [Persistent Volumes Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) , [Pod to Use a PV](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/) 

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

An existing nginx pod, `my-pod-cka` and Persistent Volume Claim (PVC) named `my-pvc-cka` are available. Your task is to implement the following modifications:
- NOTE:- PVC to PV binding and `my-pod-cka` pods sometimes takes around 2Mins to Up & Running So Please wait

* Update the pod to include a sidecar container that uses the `busybox` image. Ensure that this sidecar container remains operational by including an appropriate command `"tail -f /dev/null"`.

* Share the `shared-storage` volume between the main application and the sidecar container, mounting it at the path `/var/www/shared`. Additionally, ensure that the sidecar container has `read-only` access to this shared volume.