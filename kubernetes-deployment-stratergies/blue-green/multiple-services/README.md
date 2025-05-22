Blue/green deployment to release multiple services simultaneously
=================================================================

> In this example, we release a new version of 2 services simultaneously using
the blue/green deployment strategy.We are using nginx ingress controller running on minikube to perform demo on this kubernetes-deployment-stratergy i.e. blue/green

## Steps to follow

1. service a and b are serving traffic
1. deploy new version of both services
1. wait for all services to be ready
1. switch incoming traffic from version 1 to version 2
1. shutdown version 1

```bash

# Deploy the ingress-nginx controller for minikube
# Ref Docs : https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
$ minikube addons enable ingress

# Deploy version 1 of application a and b and the ingress
$ kubectl apply -f app-a-v1.yaml -f app-b-v1.yaml -f ingress-v1.yaml

# Test if the deployment was successful
# NOTE:In the below command url i.e. http://192.168.49.2:31577 points to ingress-nginx-controller service which get deployed under ingress-nginx namespace.
# Run command i.e. minikube service list to get url information after deplying nginx ingress controller.
$ curl "http://192.168.49.2:31577" -H 'Host: a.domain.com'
Host: my-app-a-v1-7d9d6c64d5-sjxxp, Version: v1.0.0

$ curl http://192.168.49.2:31577 -H 'Host: b.domain.com'
Host: my-app-b-v1-846b57f8f5-b7g8g, Version: v1.0.0

# To see the deployment in action, open a new terminal and run the following
# command
$ watch kubectl get po

# Then deploy version 2 of both applications
$ kubectl apply -f app-a-v2.yaml -f app-b-v2.yaml

# Wait for both applications to be running
$ kubectl rollout status deploy my-app-a-v2 -w
deployment "my-app-a-v2" successfully rolled out

$ kubectl rollout status deploy my-app-b-v2 -w
deployment "my-app-b-v2" successfully rolled out

# Check the status of the deployment, then when all the pods are ready, we can
# update the ingress
$ kubectl apply -f ingress-v2.yaml

# Test if the deployment was successful
$ curl "http://192.168.49.2:31577" -H 'Host: a.domain.com'
Host: my-app-a-v2-64fc6b4c8f-hcspl, Version: v2.0.0

$ curl http://192.168.49.2:31577 -H 'Host: b.domain.com'
Host: my-app-b-v2-78d4469df9-zbz58, Version: v2.0.0

# In case we need to rollback to the previous version
$ kubectl apply -f ingress-v1.yaml

# If everything is working as expected, we can then delete the v1.0.0
# deployment
$ kubectl delete -f ./app-a-v1.yaml -f ./app-b-v1.yaml
```

### Cleanup

```bash
$ kubectl delete all -l app=my-app

```
#### Source git repository for refrence w.r.t k8s-deployment-stratergies
  - https://github.com/ContainerSolutions/k8s-deployment-strategies/tree/master

--- 

**Outcomes of Blue-Green-deployment**

- ![Blue-green-1](../../../../images/Blue-green-1.png)
- ![Blue-green-2](../../../images/Blue-green-2.png)
- ![Blue-green-3](../../../images/Blue-green-3.png)
- ![Blue-green-4](../../../images/Blue-green-4.png)
- ![Blue-green-5](../../../images/Blue-green-5.png)
- ![Blue-green-6](../../../images/Blue-green-6.png)
- ![Blue-green-7](../../../images/Blue-green-7.png)
- ![Blue-green-8](../../../images/Blue-green-8.png)
- ![Blue-green-9](../../../images/Blue-green-9.png)
- ![Blue-green-10](../../../images/Blue-green-10.png)
- ![Blue-green-11](../../../images/Blue-green-11.png)
- ![Blue-green-12](../../../images/Blue-green-12.png)

---