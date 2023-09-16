
> <strong>Useful Resources</strong>: [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>


Create a Kubernetes Pod configuration to facilitate real-time monitoring of a log file. Specifically, you need to set up a Pod named `alpine-pod-pod` that runs an Alpine Linux container.

Requirements:

* Name the Pod `alpine-pod-pod`.
* Use `alpine:latest` image
* Configure the container to execute the `tail -f /config/log.txt` command using `/bin/sh` to continuously monitor and display the contents of a log file.
* Set up a volume named `config-volume` that maps to a ConfigMap named `log-configmap`, this `log-configmap` already available.
* Ensure the Pod has a restart policy of `Never`.