#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: log-configmap
data:
  log.txt: |
    ERROR: Mon Oct 1 10:30:23 UTC 2023 Log in Error!
    INFO: Mon Oct 1 10:30:23 UTC 2023 Logged In
    ERROR: Mon Oct 1 10:30:23 UTC 2023  Log in Error!
    INFO: Mon Oct 1 10:30:23 UTC 2023 Logged In
    ERROR: Mon Oct 1 10:30:23 UTC 2023  Log in Error!
    INFO: Mon Oct 1 10:30:23 UTC 2023 Logged In
    ERROR: Mon Oct 1 10:30:23 UTC 2023  Log in Error!
    INFO: Mon Oct 1 10:30:23 UTC 2023 Logged In
    ERROR: Mon Oct 1 10:30:23 UTC 2023  Log in Error!
    
---

apiVersion: v1
kind: Pod
metadata:
  name: log-reader-pod
spec:
  containers:
  - name: log-reader-container
    image: alpine:latest
    command: ["/bin/sh", "-c"]
    args:
    - |
      tail -f /config/log.txt
    volumeMounts:
    - name: config-volume
      mountPath: /config
  volumes:
    - name: config-volume
      configMap:
        name: log-configmap
  restartPolicy: Never
EOF