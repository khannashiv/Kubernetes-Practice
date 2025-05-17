#### Steps to deploy host-based-routing .

1. Start Minikube and enable ingress .
    - minikube start --driver=docker
    - minikube addons enable ingress

2. Download & deploy
    - unzip host-routing-k8s.zip
    - cd host-routing
    - chmod +x deploy.sh
    - ./deploy.sh

3. Edit /etc/hosts to point domains to Minikube IP : <MINIKUBE_IP> foo.bar.com bar.foo.com

4. Test
    - curl http://foo.bar.com
    - curl http://bar.foo.com

    <!--
        # The other way of doing curl is :
        -- curl -H "Host: foo.bar.com" http://192.168.49.2
            - H "Host: bar.foo.com" — Adds an HTTP Host header to the request.
            - http://192.168.49.2 — Sends the request to this IP address (usually your Ingress controller, e.g. in Minikube).
    -->


