#!/bin/bash

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
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nginx-pv-cka
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/nginx-data-cka
EOF