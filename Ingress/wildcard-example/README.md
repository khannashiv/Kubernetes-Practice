#### Steps to deploy path-based-routing .

1. Start Minikube and enable ingress
    - minikube start --driver=docker
    - minikube addons enable ingress

2. Download & deploy
    - unzip wildcard-example.zip
    - cd wildcard-example
    - chmod +x deploy.sh
    - ./deploy.sh

3. Test
    - curl -ivv -H "host: bar.example.com" 192.168.49.2/path1
    - curl -ivv -H "Host: foo.example.com" 192.168.49.2/path2
    - Above test can be run from terminal, if we get reposnse as 200 OK that confirms our implementation is successful.
    - Further in order to get output on browser as well, we have made entry of above IPs and corresopnding host names under /etc/hosts file.
    - Tested by running ping against the hostname / url's .
        - ping bar.example.com
        - ping foo.example.com
        - Confirm above host name should get resolved on IP address i.e. 192.168.49.2 (which is minikube-ip)
        - After confirming load the url's on the browser to see if it loads default web page for nginx as well as for apache i.e. httpd.
            - http://foo.example.com/path1
            - http://bar.example.com/path2