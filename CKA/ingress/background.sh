#!/bin/bash

kubectl create deployment nginx-deployment --image=nginx

kubectl expose deployment nginx-deployment --name=nginx-service --port=80 --type=ClusterIP