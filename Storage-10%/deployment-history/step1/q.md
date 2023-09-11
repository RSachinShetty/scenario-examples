
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


The deployment named `video-app` has experienced multiple rolling updates and rollbacks. Your task is to total revision of this deployment and record the image name used in `3rd` revision to file app-file.txt.

like this:

echo `REVISION_TOTAL_COUNT,IMAGE_NAME` > "app-file.txt"