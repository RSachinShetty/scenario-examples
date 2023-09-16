#!/bin/bash

kubectl taint nodes node01 nodeName=workerNode01:NoSchedule --overwrite=true

cat <<EOL > application-deployment.yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-pod
spec:
  containers:
    - name: redis-container
      image: redis:latest
      ports:
        - containerPort: 6379
EOL