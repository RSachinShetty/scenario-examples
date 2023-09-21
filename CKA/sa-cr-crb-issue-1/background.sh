#!/bin/bash

kubectl create serviceaccount prod-sa
kubectl create role prod-role-cka --verb=list --resource=pods --namespace=default
kubectl create rolebinding prod-role-binding-cka --role=prod-role-cka --serviceaccount=default:prod-sa