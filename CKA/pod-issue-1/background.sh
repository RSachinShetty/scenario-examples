#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  volumes:
    - name: log-volume
      emptyDir: {}
  containers:
    - name: nginx-container
      image: nginx:ltest
      volumeMounts:
        - name: log-volume
          mountPath: /var/log/nginx
EOF