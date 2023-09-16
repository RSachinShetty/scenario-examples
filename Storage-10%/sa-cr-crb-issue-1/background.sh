#!/bin/bash

kubectl create serviceaccount prod-sa
kubectl create role prod-role-cka --verb=get --resource=secrets --namespace=default
kubectl create rolebinding prod-role-binding-cka --role=prod-role-cka --serviceaccount=default:prod-sa