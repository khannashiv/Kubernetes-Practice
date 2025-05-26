## Troubleshooting in kubernetes and refrence links.

**Refrence Links**
- https://github.com/iam-veeramalla/kubernetes-troubleshooting-zero-to-hero/
- https://kubernetes.io/docs/concepts/configuration/secret/
- https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
- https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/
- https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector
- https://kubernetes.io/docs/concepts/services-networking/network-policies/
- https://spacelift.io/blog/kubernetes-network-policy
- https://kubernetes.io/docs/concepts/storage/persistent-volumes/
- https://github.com/iam-veeramalla/Kubernetes-Zero-to-Hero/blob/main/Security/Manage_Security_Like_Pro.md
- https://www.linkedin.com/posts/balavignesh-manoharan_kubectl-port-forwarding-activity-7288050328032202752-AsaJ/?utm_source=share&utm_medium=member_ios
- https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/
- https://kubernetes.io/docs/reference/kubectl/quick-reference/

# Kubernetes Commands Reference

```bash
# -------------------------------
# 🔐 Secrets
# -------------------------------

# Create a secret from literal key-value
kubectl create secret generic my-secret --from-literal=username=admin --from-literal=password=secret123

# Create a secret from a file
kubectl create secret generic my-secret --from-file=ssh-privatekey=./id_rsa

# Get all secrets
kubectl get secrets

# Describe a secret
kubectl describe secret my-secret

# View secret data (base64 encoded)
kubectl get secret my-secret -o yaml

# -------------------------------
# ⚖️ Taints and Tolerations
# -------------------------------

# Add a taint to a node
kubectl taint nodes node1 key=value:NoSchedule

# Remove a taint from a node
kubectl taint nodes node1 key:NoSchedule-

# View taints on a node
kubectl describe node node1 | grep Taints

# Alternatively (JSON output)
kubectl get nodes -o json | jq '.items[].spec.taints'

# -------------------------------
# 📍 NodeSelector
# -------------------------------

# View node labels
kubectl get nodes --show-labels

# Label a node
kubectl label nodes node1 disktype=ssd

# -------------------------------
# 🌐 Network Policy
# -------------------------------

# Apply a network policy manifest
kubectl apply -f network-policy.yaml

# Get network policies
kubectl get networkpolicy

# Describe a network policy
kubectl describe networkpolicy <policy-name>

# -------------------------------
# 💾 Persistent Volume (PV) and Persistent Volume Claim (PVC)
# -------------------------------

# Get Persistent Volumes
kubectl get pv

# Get Persistent Volume Claims
kubectl get pvc

# Describe a Persistent Volume
kubectl describe pv <pv-name>

# Describe a Persistent Volume Claim
kubectl describe pvc <pvc-name>

# Delete a Persistent Volume Claim
kubectl delete pvc <pvc-name>

# -------------------------------
# 🔌 Port Forwarding
# -------------------------------

# Forward local port 8080 to pod port 80
kubectl port-forward pod/<pod-name> 8080:80

# Forward local port 8080 to service port 80
kubectl port-forward svc/<service-name> 8080:80
