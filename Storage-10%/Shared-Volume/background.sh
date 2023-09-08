#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc-cka
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 100Mi
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