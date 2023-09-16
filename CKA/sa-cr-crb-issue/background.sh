#!/bin/bash

kubectl create serviceaccount dev-sa
kubectl create role dev-role-cka --verb=get --resource=secrets --namespace=default
kubectl create rolebinding dev-role-binding-cka --role=dev-role-cka --serviceaccount=default:dev-sa