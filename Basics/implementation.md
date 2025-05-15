## Deploying minikube cluster for learning kubernetes.

**Installation**

- We have followed the following links to install minikube along with that we have done installation of kubectl utility by referring the following links.
    - Here I'm using Ubuntu as my base on OS on top of which We will install minikube as well as kubectl utility.Along with that we have installed docker driver which minikube will use behind the scene since KVM2 - VM-based was not working for me.
        - https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download
        - https://minikube.sigs.k8s.io/docs/drivers/
        - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/ 

**Deploying pod using YAML file.**

- We have followed official documentaion to deploy pod in top of minikube cluster.
    - Ref : https://kubernetes.io/docs/concepts/workloads/pods/ 
    - First of all I have pulled one of the docker image from docker hub containing my python application onto ubuntu VM.
    - Then under pod.yaml I have updated pod name, container name to `text-analyzer-practice` and image name to `image: khannashiv/text-analyzer:46` which is present locally on my VM.
    - After updating the pod.yaml via vim editor then we have proceed with `kubectl apply -f pod.yaml` which actually has deployed the pod for us.
    - Once an IP was assigned to pod, we can go ahead & access this pod holding the required application within minikube cluster.
    - For this we have to login to minikube cluster using the command i.e. `minikube ssh`. 
    - From there we have done curl to IP assigned to pod followed by port # where my python application is running. i.e.`curl <IP-of-pod>:<app port #>` for example  `curl 10.244.0.166:8000`

    - ![](../images/Pod-1.PNG "Pod-1")

