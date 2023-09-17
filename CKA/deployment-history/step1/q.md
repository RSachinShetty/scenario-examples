
> <strong>Useful Resources</strong>: [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


The deployment named `video-app` has experienced multiple rolling updates and rollbacks. Your task is to total revision of this deployment and record the image name used in `3rd` revision to file `app-file.txt` in this format `REVISION_TOTAL_COUNT,IMAGE_NAME`.