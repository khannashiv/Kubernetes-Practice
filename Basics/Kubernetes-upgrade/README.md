# ✅ How to Upgrade an Enterprise-Level Kubernetes Cluster (EKS Focused)

## 📌 Prerequisites

### Node Cordon for Safety
Although Kubernetes supports zero-downtime upgrades, it's a best practice to cordon nodes (make them unschedulable) during the upgrade to prevent new pods from being scheduled while upgrading.

### Read Release Notes
Always review the Kubernetes release notes when planning an upgrade (e.g., from v1.30 to v1.32). Look for:
- **Deprecated APIs**
- **Introduced or removed features**
- **Behavioral changes**
- **Required actions** (like upgrading CRDs)

### No Downgrade Support
Kubernetes upgrades are **one-way only**. If you upgrade to v1.31 and encounter issues, you **cannot** roll back to v1.30. You’d need to rebuild the cluster and restore from backup.

### Test in Lower Environments First
Always test the upgrade in lower environments like **dev, staging, or UAT** before applying changes in production.

### Control Plane and Node Version Compatibility
- Worker nodes must be **within one minor version** of the control plane.
- **Example:** If the control plane is on v1.30, worker nodes can be on v1.29 or v1.30, but not v1.28.

#### When upgrading:
1. **First, upgrade nodes** to match the control plane version.
2. **Then upgrade the control plane** to the next version.

### Cluster Autoscaler Compatibility
If using a **Cluster Autoscaler**, ensure its version matches the **supported Kubernetes version** per Cluster Autoscaler compatibility matrix. **Mismatches can lead to scaling failures.**
- Ref : https://github.com/kubernetes/autoscaler#releases

### IP Address Availability
Ensure **at least 5 available IP addresses per subnet** for EKS upgrades.

<!--
Ques: Why IP Addresses Matter in EKS ?
Sol : EKS uses Amazon VPC networking, and each pod running in the cluster is assigned an IP address from the VPC subnet. When performing an upgrade, particularly when upgrading node groups or performing maintenance tasks, certain conditions can require additional IP addresses:

    -- Scaling and Replacement of Nodes: During node upgrades, old nodes are drained, and new ones are brought up. If you are replacing nodes or scaling up your cluster, you need available IP addresses to assign to new nodes and their workloads.

    -- Pod IP Addressing: If you're using the Amazon VPC CNI (which is the default CNI for EKS), it assigns VPC IP addresses to the pods directly. So if your subnet is near capacity (i.e., you don't have enough available IPs), new pods or nodes might fail to launch due to a lack of available IP addresses.

Ques : Best Practice for Sufficient IPs ? 
Sol : While the "5 IP addresses" figure is not a universal requirement, the general best practice is:
    -- Ensure adequate IP address availability in your VPC subnet before upgrading or scaling your EKS cluster.
    -- Typically, when adding or upgrading nodes, Amazon recommends ensuring you have at least 10% more available IP addresses than your current usage, especially if you are using the Amazon VPC CNI.

-->
### Kubelet Compatibility
The **kubelet version** on worker nodes should **match the control plane version**. Compatibility is critical for proper API communication and workload scheduling.
- Ref : https://kubernetes.io/releases/version-skew-policy/

## 🚀 Upgrade Process (EKS-Based)

### 1. Control Plane Upgrade (Managed by AWS)

In **EKS**, control plane upgrades are managed via the **AWS console, CLI**, or infrastructure-as-code tools like **Terraform**.

- Control plane upgrades are **zero-downtime** but should be scheduled during **low-traffic hours**.

### 2. Data Plane Upgrade (Worker Nodes / Node Groups)

#### A. Managed Node Groups (**Recommended Approach**)
Use **EKS-managed node groups** with **launch templates**.

##### Upgrade Methods:

- **Rolling Update (Zero Downtime):** EKS replaces nodes **one at a time** (e.g., Node 1 → Node 2 → Node 3), respecting **PodDisruptionBudgets (PDBs)**.
- **Force Update:** Useful when **PDBs prevent pod eviction**. EKS forcibly terminates and recreates nodes.

#### B. Self-Managed Nodes

If using **custom AMIs** or **unmanaged node groups**:
1. **Manually cordon** the node.
2. **Drain the node** (evict running pods).
3. **Upgrade the node** (e.g., replace EC2 instance with new AMI).
4. **Rejoin the node** to the cluster.
5. **Repeat** for all nodes.

#### C. Hybrid Approach

A mix of **managed** and **self-managed** nodes.
- Apply respective upgrade strategies to **each node group**.

## 🔌 Addons and Plugin Upgrade

After upgrading the **control plane** and **data plane**:
- **Upgrade all cluster add-ons** (CNI, CoreDNS, kube-proxy).
- **Validate compatibility** using the **AWS CLI** or **EKS console**.
- **Update custom plugins** or operators (e.g., Ingress controllers, CSI drivers).

## ✅ Final Checklist

✔ Backup **etcd** / workloads if running on **self-managed cluster**  
✔ Validate **all CRDs** and **Helm charts**  
✔ Validate **workloads post-upgrade**  
✔ Monitor **logs and metrics** (e.g., via **Prometheus**, **CloudWatch**)  
✔ Perform **smoke tests** to verify app functionality  
