#!/bin/bash
set -e
eval $(minikube docker-env)

echo "Deploying to Kubernetes..."
kubectl apply -f ./k8s-manifests/deployment-wildcard.yaml
kubectl apply -f ./k8s-manifests/service-wildcard.yaml
kubectl apply -f ./k8s-manifests/ingress-wildcard.yaml

echo "Minikube IP is : $(minikube ip)"