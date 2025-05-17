#!/bin/bash
set -e
eval $(minikube docker-env)

echo "Building images..."
docker build -t khannashiv/nginx-local:v1 ./nginx
docker build -t khannashiv/apache-local:v1 ./apache

echo "Deploying to Kubernetes..."
kubectl apply -f k8s/nginx-deployment.yaml
kubectl apply -f k8s/nginx-service.yaml
kubectl apply -f k8s/apache-deployment.yaml
kubectl apply -f k8s/apache-service.yaml
kubectl apply -f k8s/ingress.yaml

echo "Minikube IP:"
minikube ip

echo "Update /etc/hosts with:"
echo "$(minikube ip) foo.bar.com bar.foo.com"
echo "Try:"
echo "curl http://foo.bar.com"
echo "curl http://bar.foo.com"