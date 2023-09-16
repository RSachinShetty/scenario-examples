#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: redis-pv
spec:
  capacity:
    storage: 100Mi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/data/redis

---

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: redis-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: manually
  resources:
    requests:
      storage: 80Mi

---

apiVersion: v1
kind: Pod
metadata:
  name: redis-pod
spec:
  containers:
    - name: redis-container
      image: redis:latested
      ports:
        - containerPort: 6379
          name: redis
      volumeMounts:
        - name: redis-data
          mountPath: /data
  volumes:
    - name: redis-data
      persistentVolumeClaim:
        claimName: pvc-redis

EOF