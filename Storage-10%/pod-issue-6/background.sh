#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv-cka
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data
  storageClassName: standard  # Specify the desired storage class here

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc-cka
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 100Mi
  volumeName: my-pv-cka
  storageClassName: standard  # Specify the same storage class as in the PV here

---
apiVersion: v1
kind: Pod
metadata:
  name: my-pod-cka
spec:
  containers:
    - name: nginx-container
      image: nginx
      volumeMounts:
        - name: shared-storage
          mountPath: /var/www/html
  volumes:
    - name: shared-storage
      persistentVolumeClaim:
        claimName: my-pvc-cka
EOF