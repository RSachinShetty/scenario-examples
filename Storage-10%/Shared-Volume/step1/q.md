
> <strong>Useful Resources</strong>: [Persistent Volumes Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

An existing nginx deployment, `pink-app-cka`, is currently deployed on the cluster. Your task is to implement the following modifications:

Persistent Volume Claim (PVC) named `pink-pvc-cka` and Persistent Volume (PV) named `pink-pv-cka` are available.

* Create a volume named `shared-storage` and associate it with a PersistentVolumeClaim named `pink-pvc-cka`. Mount this volume at the path `/var/www/html` within the nginx-container container of the Deployment.

* Update the deployment to include a sidecar container that uses the `busybox` image. Ensure that this sidecar container remains operational by including an appropriate command "tail -f /dev/null".

* Share the `shared-storage` volume between the main application and the sidecar container, mounting it at the path `/var/www/shared`. Additionally, ensure that the sidecar container has `read-only` access to this shared volume.