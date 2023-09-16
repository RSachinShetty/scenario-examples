#!/bin/bash

kubectl create deployment nginx-deployment --image=nginx

kubectl expose deployment nginx-deployment --port=80 --type=ClusterIP