#!/bin/bash
kubectl delete -f service-account/prometheus-service-account.yml
kubectl delete -f service-account/prometheus-roles.yml
kubectl delete -f service-account/prometheus-role-bindings.yml
kubectl -n monitoring delete configmap prometheus-config
kubectl delete -f rules/prometheus-rules.yml
kubectl delete -f prometheus-deployment.yml
kubectl delete -f cert.yml
kubectl delete -f prometheus-service.yml
kubectl delete -f prometheus-ingress.yml
echo "This does not delete the persistent volume claim. That must be manually deleted."
