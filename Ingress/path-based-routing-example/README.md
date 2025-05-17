#### Steps to deploy path-based-routing .

1. Start Minikube and enable ingress
    - minikube start --driver=docker
    - minikube addons enable ingress

2. Download & deploy
    - unzip path-based-routing.zip
    - cd host-routing
    - chmod +x deploy.sh
    - ./deploy.sh

3. Test
    - http://<minikube-ip>/app1
    - http://<minikube-ip>/app2
