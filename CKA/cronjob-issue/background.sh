#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: hello-world-pod
spec:
  containers:
    - name: hello-world-container
      image: busybox
      command: ["sh", "-c", "while true; do echo 'Hello, World!'; sleep 10; done"]
---

apiVersion: v1
kind: Service
metadata:
  name: hello-world-service
spec:
  selector:
    app: hello-world-pod
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP

---

apiVersion: batch/v1
kind: CronJob
metadata:
  name: hello-world-cronjob
spec:
  schedule: "* * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: curl-container
              image: curlimages/curl:latest
              command: ["curl", "hello-world-pod"]
          restartPolicy: OnFailure

EOF