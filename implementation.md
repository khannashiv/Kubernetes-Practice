# Deploying Minikube Cluster for Learning Kubernetes

---

## Installation

We have followed the official documentation to install Minikube and the kubectl utility on Ubuntu. The Docker driver is also installed, which Minikube uses behind the scenes.

**References:**
- [Minikube Installation](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download)
- [Minikube Drivers](https://minikube.sigs.k8s.io/docs/drivers/)
- [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

---

## Deploying a Pod Using YAML

We followed the [official documentation](https://kubernetes.io/docs/concepts/workloads/pods/) to deploy a pod on the Minikube cluster.

**Steps:**
1. Pulled a Docker image from Docker Hub containing the Python application onto the Ubuntu VM.
2. Edited `pod.yaml`, setting:
    - Pod name and container name to `text-analyzer-practice`
    - Image name to `khannashiv/text-analyzer:46`
3. Applied the YAML:  
   ```sh
   kubectl apply -f pod.yaml
   ```
4. Accessed the pod within Minikube:
    - Used `minikube ssh` to log into the cluster
    - Used `curl <POD_IP>:<APP_PORT>` (e.g., `curl 10.244.0.166:8000`)

**Screenshot:**  
- ![Pod-1](images/Pod-1.PNG)

---

## Deploying a Deployment Using YAML

We used the [official documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) to create a deployment.

**Steps:**
1. Created `deployment.yaml` specifying desired replicas.
2. Applied the YAML:
   ```sh
   kubectl apply -f deployment.yaml
   ```
3. Accessed the pod as before, via `minikube ssh` and curl to the pod IP and port.

**Screenshots:**  
- ![Deploy-1](images/Deploy-1.PNG)  
- ![Deploy-2](images/Deploy-2.PNG)  
- ![Deploy-3](images/Deploy-3.PNG)  
- ![Deploy-4](images/Deploy-4.PNG)

---

## Deploying a Service Using YAML

We followed the [official documentation](https://kubernetes.io/docs/concepts/services-networking/service/) to deploy a service.

**Service Types:**
- **ClusterIP (default):**
    - Internal only (e.g., databases, internal APIs)
- **NodePort:**
    - Exposes the service on a static port on each Node’s IP (port range: 30000–32767)
- **LoadBalancer:**
    - Exposes the service externally (typically for production/public services in the cloud)

**Steps:**
1. Created `service.yaml` with the desired service type (`NodePort` in this case).
2. Applied the YAML:
   ```sh
   kubectl apply -f service.yaml
   ```
3. Accessed the application via the node’s static IP and node port.

**Screenshots:**  
- ![Service-1](images/Service-1.PNG)  
- ![Service-2](images/Service-2.PNG)  
- ![Service-3](images/Service-3.PNG)  
- ![Service-4](images/Service-4.PNG)  
- ![Service-5](images/Service-5.PNG)  
- ![Service-6](images/Service-6.PNG)  
- ![Service-7](images/Service-7.PNG)

---

## Kubectl Commands Cheat Sheet

- [kubectl Quick Reference](https://kubernetes.io/docs/reference/kubectl/quick-reference/)
- [Kubernetes Cheat Sheet - Spacelift](https://spacelift.io/blog/kubernetes-cheat-sheet)

---

## Deploying Ingress Resource Using YAML

We used the [official documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/) to deploy an ingress resource. An ingress controller (nginx in this case) is required.

**References:**
- [Ingress Concepts](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [Ingress with Minikube](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/)
- [Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)

**Basic Commands:**
```sh
kubectl get deploy -A | grep text
kubectl get svc -A | grep text
kubectl get ingress -A | grep text
kubectl get pods -A | grep nginx
kubectl logs ingress-nginx-controller-56d7c84fd4-cfbc7 -n ingress-nginx
```
> Note: The controller runs as a pod inside the `ingress-nginx` namespace.

**Screenshots:**  
- ![Ingress-1](images/Ingress-1.PNG)  
- ![Ingress-2](images/Ingress-2.PNG)  
- ![Ingress-3](images/Ingress-3.PNG)  
- ![Ingress-4](images/Ingress-4.PNG)

---

### Ingress for Todo Python App

- YAML files are under the `ingress` directory.
- If `host` is set in `ingress-todo.yaml`, update `/etc/hosts` on the VM:
  ```
  <MINIKUBE_IP> <HOSTNAME>
  ```
**Screenshots:**  
- ![Ingress-5](images/ingress-5.PNG)  
- ![Ingress-6](images/ingress-6.PNG)  
- ![Ingress-7](images/ingress-7.PNG)  
- ![Ingress-8](images/ingress-8.PNG)  
- ![Ingress-9](images/ingress-9.PNG)  
- ![Ingress-10](images/ingress-10.PNG)

---

## Outcomes

### Host-Based Routing

Screenshots:  
- ![Host-based-routing-1](images/Host-based-routing-1.PNG)  
- ![Host-based-routing-2](images/Host-based-routing-2.PNG)  
- ![Host-based-routing-3](images/Host-based-routing-3.PNG)  
- ![Host-based-routing-4](images/Host-based-routing-4.PNG)  
- ![Host-based-routing-5](images/Host-based-routing-5.PNG)  
- ![Host-based-routing-6](images/Host-based-routing-6.PNG)  
- ![Host-based-routing-7](images/Host-based-routing-7.PNG)  
- ![Host-based-routing-8](images/Host-based-routing-8.PNG)  
- ![Host-based-routing-9](images/Host-based-routing-9.PNG)  
- ![Host-based-routing-10](images/Host-based-routing-10.PNG)  
- ![Host-based-routing-11](images/Host-based-routing-11.PNG)  
- ![Host-based-routing-12](images/Host-based-routing-12.PNG)

---

### Path-Based Routing

Screenshots:  
- ![Path-based-routing-1](images/Path-based-routing-1.PNG)  
- ![Path-based-routing-2](images/Path-based-routing-2.PNG)  
- ![Path-based-routing-3](images/Path-based-routing-3.PNG)  
- ![Path-based-routing-4](images/Path-based-routing-4.PNG)  
- ![Path-based-routing-5](images/Path-based-routing-5.PNG)  
- ![Path-based-routing-6](images/Path-based-routing-6.PNG)  
- ![Path-based-routing-7](images/Path-based-routing-7.PNG)

---

### Wildcard Routing

Screenshots:  
- ![Wildcard-routing-1](images/Wildcard-routing-1.PNG)  
- ![Wildcard-routing-2](images/Wildcard-routing-2.PNG)  
- ![Wildcard-routing-3](images/Wildcard-routing-3.PNG)  
- ![Wildcard-routing-4](images/Wildcard-routing-4.PNG)  
- ![Wildcard-routing-5](images/Wildcard-routing-5.PNG)  
- ![Wildcard-routing-6](images/Wildcard-routing-6.PNG)  
- ![Wildcard-routing-7](images/Wildcard-routing-7.PNG)