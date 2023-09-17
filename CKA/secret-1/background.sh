#!/bin/bash

kubectl create ns database-ns
kubectl create secret generic database-data -n database-ns --from-literal=DB_PASSWORD=secret 