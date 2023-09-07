
> <strong>Useful Resources</strong>: [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)

For this question, please set the context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Create a storage class called `orange-stc-cka07-str` as per the properties given below:

- Provisioner should be `kubernetes.io/no-provisioner`.
- Volume binding mode should be `WaitForFirstConsumer`.