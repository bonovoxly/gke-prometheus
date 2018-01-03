#!/bin/bash
kubectl create -f service-account/prometheus-service-account.yml
kubectl create -f service-account/prometheus-roles.yml
kubectl create -f service-account/prometheus-role-bindings.yml
kubectl -n monitoring create configmap prometheus-config --from-file ./config/prometheus.yml
kubectl create -f rules/prometheus-rules.yml
kubectl create -f pvc.yml
kubectl create -f prometheus-deployment.yml
kubectl create -f cert.yml
kubectl create -f prometheus-service.yml
kubectl create -f prometheus-ingress.yml
