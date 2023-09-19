#!/bin/bash

kubectl create deployment nginx-deployment --image=nginx

kubectl expose deployment nginx-service --port=80 --type=ClusterIP