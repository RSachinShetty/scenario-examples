#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: red-pvc-cka
spec:
  volumeName: red-pv-cka
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 30Mi
EOF