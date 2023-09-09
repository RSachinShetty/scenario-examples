#!/bin/bash

mkdir -p /opt/nginx-data-cka


cat <<EOL > nginx-pod-cka.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod-cka
spec:
  containers:
    - name: my-container
      image: nginx:latest
EOL

kubectl apply -f - <<EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: nginx-stc-cka
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true   

---

apiVersion: v1
kind: PersistentVolume
metadata:
  name: nginx-pv-cka
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  storageClassName: nginx-stc-cka
  local:
    path: /opt/nginx-data-cka
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - controlplane
EOF