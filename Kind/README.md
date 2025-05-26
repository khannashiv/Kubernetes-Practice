## About KIND (Kubernetes IN Docker)
- KIND is a tool for running local Kubernetes clusters using Docker container "nodes." It's very useful for testing and development.

**Why to use KIND?**
- Lightweight and fast for local dev.
- Great for CI pipelines.
- No need for a full-blown cloud environment.

**Installation & Setup of KIND cluster**
- https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-source

**KIND cheatsheet for refrence**
- https://www.hackingnote.com/en/cheatsheets/kind/
- https://gist.github.com/githubfoam/f8e60a283e308063738980cbc3c009ee

## Common KIND & kubectl Commands for Hands-on Practice

```bash
#### KIND Frequent Commands ####
# 1. Create a KIND cluster
kind create cluster --name my-cluster

# 2. Get cluster info
kubectl cluster-info --context kind-my-cluster

# 3. List all KIND clusters
kind get clusters

# 4. Delete a KIND cluster
kind delete cluster --name my-cluster

# 5. Create cluster with custom config file or if one wants to deploy multi-node cluster
kind create cluster --name custom-cluster --config kind-config.yaml

# 6. Load local Docker image into KIND cluster
kind load docker-image my-app-image --name my-cluster

# 7. Export kubeconfig for KIND cluster
kind get kubeconfig --name my-cluster

# 8. Check current kubectl context (active cluster)
kubectl config current-context

# 9. Switch kubectl context to another cluster
kubectl config use-context <name-of-kubernetes-cluster>

# 10. View kubeconfig entries filtered by cluster name
kubectl config view | grep <name-of-cluster>
```
