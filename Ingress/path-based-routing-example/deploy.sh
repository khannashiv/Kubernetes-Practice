#!/bin/bash
set -e
eval $(minikube docker-env)

echo "Building images..."
docker build -t khannashiv/app1:v1 ./app1
docker build -t khannashiv/app2:v1 ./app2

echo "Deploying to Kubernetes..."
kubectl apply -f ./k8s/app1-deployment-service.yaml
kubectl apply -f ./k8s/app2-deployment-service.yaml
kubectl apply -f ./k8s/ingress.yaml

echo "Minikube IP:"
minikube ip


