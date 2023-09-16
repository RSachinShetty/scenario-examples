#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: yellow-stc-cka
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true   

---

apiVersion: v1
kind: PersistentVolume
metadata:
  name: yellow-pv-cka
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  storageClassName: yellow-stc-cka
  local:
    path: /opt/yellow-data-cka
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - controlplane

---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: yellow-pvc-cka
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: yellow-stc-cka
  resources:
    requests:
      storage: 40Mi  
  volumeName: yellow-pv-cka
EOF