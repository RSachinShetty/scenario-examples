#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: red-pv-cka
spec:
  capacity:
    storage: 30Mi
  accessModes:
    - ReadWriteOnce
  storageClassName: manual
  hostPath:
    path: /mnt/data
EOF