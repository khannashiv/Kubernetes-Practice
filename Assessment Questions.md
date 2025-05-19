### Some Interview Questions on Kubernetes

---

#### Q: What is the difference between Docker and Kubernetes?

**Solution:**

**Docker**:
- A containerization platform that packages applications and their dependencies into containers.
- **Use case**: Build, ship, and run applications consistently across environments.
- **Focus**: Application packaging and isolated environments.

**Kubernetes**:
- A container orchestration platform that manages many containers across clusters of machines.
- **Use case**: Automatically deploy, scale, manage, and heal containerized applications.
- **Focus**: Coordination and management of containerized apps in production.

---

#### Q: What are the main components of Kubernetes architecture?

**Solution:**

Kubernetes has a **master-worker architecture**, with components divided into two main categories:

1. **Control Plane Components (Master Node)**

| Component            | Purpose                                                                 |
|-----------------------|-------------------------------------------------------------------------|
| **API Server**        | The **entry point** to Kubernetes. Exposes the Kubernetes API and handles communication. |
| **Scheduler**         | Assigns Pods to Nodes based on resource availability and policies.     |
| **Controller Manager**| Runs background **controllers** (e.g., for nodes, replication, endpoints) to ensure cluster state matches the desired state. |
| **etcd**              | A **distributed key-value store** that stores all cluster data (configuration, state). |
| **Cloud Controller Manager** *(optional)* | Integrates Kubernetes with cloud providers (like managing load balancers or storage). |

2. **Node Components (Worker Nodes)**

| Component              | Purpose                                                               |
|------------------------|----------------------------------------------------------------------|
| **Kubelet**            | Agent on each node that **communicates with the API server** and manages containers on the node. |
| **Kube-proxy**         | Handles **network routing** and forwarding within the cluster.       |
| **Container Runtime**  | Software that **runs containers** (e.g., Docker, containerd, CRI-O). |

**Quick Summary Diagram**:
```
Control Plane:
├── API Server
├── Scheduler
├── Controller Manager
└── etcd

Worker Node:
├── Kubelet
├── Kube-proxy
└── Container Runtime
```

---

#### Q: What are the main differences between Docker Swarm and Kubernetes?

**Solution:**

| Feature                      | **Docker Swarm**                       | **Kubernetes**                                |
|------------------------------|-----------------------------------------|----------------------------------------------|
| **Ease of setup**            | ✅ Simple and fast                      | ❌ More complex, steeper learning curve     |
| **Complexity**               | Lightweight, minimal features           | Full-featured, enterprise-grade              |
| **Scalability**              | Suitable for small to medium workloads  | Designed for large-scale, production systems |
| **GUI Dashboard**            | ❌ No built-in dashboard                | ✅ Yes (Kubernetes Dashboard, Lens, etc.)   |
| **High Availability**        | Limited support                        | Strong support with self-healing              |
| **Load Balancing**           | Basic (round-robin)                    | Advanced (service discovery, DNS-based)       |
| **Rolling Updates**          | ✅ Supported                            | ✅ More powerful and customizable           |
| **Community & Ecosystem**    | Smaller, declining                     | Large, growing, and widely adopted            |
| **Secrets & Configs**        | Basic support                          | Advanced, native support                      |
| **Networking**               | Simple overlay                         | Advanced (ClusterIP, NodePort, Ingress, etc.) |
| **Third-party integrations** | Limited                                | Vast ecosystem (monitoring, logging, CI/CD)   |

- **Use Docker Swarm**: Easy to use with minimal setup for small projects or quick demos.
- **Use Kubernetes**: Advanced features, scalability, and strong community support—ideal for production environments.

---

#### Q: What is the difference between Docker containers and Kubernetes pods?

**Solution:**
- A **Pod** is the smallest deployable unit in Kubernetes. Pods are managed by Kubernetes (not Docker directly).
- Pods provide orchestration-level abstraction for managing containers.
    - A pod can contain one or more containers that share:
        - The same network IP (common networking).
        - Storage volumes.
        - Configuration (e.g., environment variables).

---

#### Q: What is a namespace in Kubernetes?

**Solution:**
- A **namespace** in Kubernetes provides logical isolation of resources, network policies, and RBAC.
- Example: Two projects using the same Kubernetes cluster can use separate namespaces (`ns1` and `ns2`).

---

#### Q: What is the role of kube-proxy in Kubernetes?

**Solution:**
- `kube-proxy` is a networking component that runs on every node in a Kubernetes cluster. Its main role is to manage network communication to and from Pods.

**Key Responsibilities of kube-proxy**:
1. **Service Networking**:
   - Routes traffic from Services to the correct Pods.
   - Ensures that accessing a Service (e.g., ClusterIP or NodePort) forwards requests to backend Pods.
2. **Load Balancing**:
   - Performs round-robin load balancing across multiple Pod IPs behind a Service.
3. **Maintaining Network Rules**:
   - Manages `iptables`, `ipvs`, or userspace rules to route traffic efficiently.
4. **Abstracting Pod IPs**:
   - Decouples clients from Pod IPs, which can change over time due to scaling or rescheduling.

---

#### Q: What is the role of Kubelet?

**Solution:**
- `Kubelet` manages containers scheduled to run on the worker node.
- Ensures containers are running and healthy.
- Communicates with the Kubernetes API server to get the desired state.

---

#### Q: What are the different types of Services in Kubernetes?

**Solution:**
Reference: [Kubernetes Services Documentation](https://kubernetes.io/docs/concepts/services-networking/service/)

---

#### Q: What is the difference between NodePort and LoadBalancer type services?

**Solution:**

| Feature                | **NodePort**                    | **LoadBalancer**                      |
|------------------------|----------------------------------|--------------------------------------|
| **Exposed on**         | Node’s IP + Node port           | External load balancer with public IP |
| **Port Range**         | 30000–32767                     | Any port (managed by LB)              |
| **Load Balancing**     | Basic (manual across nodes)     | Automatic (via cloud LB)              |
| **Use Case**           | Dev, testing, internal clusters | Production, public services           |
| **External IP**        | ❌ No (uses node IPs)           | ✅ Yes                               |

1. **NodePort**:
    - Exposes the service on a static port (30000–32767) on every node’s IP.
    - External users access the app using:
      ```
      http://<NodeIP>:<NodePort>
      ```
    - Basic and limited—good for development or testing.

2. **LoadBalancer**:
    - Exposes the service using a public/external IP provided or assigned to the load balancer.
    - Handles advanced load balancing, health checks, and traffic routing.

---

#### Q: What are your day-to-day activities on Kubernetes?

**Solution**:

1. **Deploying and Managing Applications**:
    - Writing and applying YAML manifests (Deployment, Service, Ingress, etc.).
    - Using `kubectl` to create/update resources:
      ```
      kubectl apply/edit -f deployment.yaml
      ```
    - Managing Helm charts for reusable, versioned deployments.

2. **Monitoring and Health Checks**:
    - Checking Pod, Node, and Service status:
      ```
      kubectl get pods, nodes, services
      ```
    - Watching logs and metrics for performance and errors:
      ```
      kubectl logs <pod-name>
      ```
    - Using tools like Prometheus, Grafana, or Lens for deeper visibility.

3. **Troubleshooting Issues**:
    - Investigating failing Pods or CrashLoopBackOff errors.
    - Describing resources for details:
      ```
      kubectl describe pod <pod-name>
      ```
    - Checking events and node capacity.
    - Debugging networking or DNS issues inside the cluster.

4. **Managing Configurations**:
    - Updating ConfigMaps and Secrets.
    - Managing environment variables and mounting volumes.
    - Rolling out application updates:
      ```
      kubectl rollout
      ```

5. **Scaling and Resource Management**:
    - Scaling deployments:
      ```
      kubectl scale deployment my-app --replicas=5
      ```
    - Adjusting resource limits in Pods.
    - Monitoring for over-provisioning or resource bottlenecks.

6. **Security and Access Control**:
    - Managing RBAC roles and permissions.
    - Creating and rotating TLS certificates and secrets.
    - Enforcing network policies and container security standards.

7. **Backups and Disaster Recovery**:
    - Taking etcd backups (for admins).
    - Validating cluster recovery strategies.

---


#### Q: During the upgrade, I have ArgoCD, Helm, and Prometheus installed. How do we manage all these during the upgrade phase?

**Solution**:

- At the end of the day, these are Kubernetes controllers running in your cluster. To ensure they continue functioning correctly after the upgrade, it's crucial to thoroughly test these components in a lower environment (e.g., dev, UAT, staging) before applying the upgrade in production. This allows you to identify any compatibility issues or misconfigurations with the upgraded Kubernetes version. Additionally, ensure the versions of the controllers (ArgoCD, Helm, Prometheus) you’re using are compatible with the new Kubernetes version you are upgrading to.

---

#### Q: How do you test whether the upgrade works or not?

**Solution**:

- To validate that the upgrade works successfully, it is essential to automate the testing process. The QE (Quality Engineering) or DevOps teams typically create regression, functional, and end-to-end (E2E) tests. These tests should be executed on the upgraded Kubernetes nodes to confirm that the upgrade is successful.
- Instead of manually inspecting each individual component (e.g., ArgoCD, Helm, Prometheus), you can run automated tests to verify the core functionality of the cluster and the critical services it hosts. This ensures the Kubernetes upgrade doesn’t break essential workloads or services.

---

#### Q: What are different types of probes in Kubernetes ?

**Solution**:

1. Liveness Probe : 
  - Checks if the application is still running.If the liveness probe fails, Kubernetes will restart the container.
  - Use Case: If your application hangs or gets stuck (e.g., deadlock), the liveness probe detects it and triggers a restart.

2. Readiness Probe:
  - Checks if the application is ready to serve traffic.If it fails, the Pod is removed from the Service endpoints, but it’s not restarted.
  - Use Case: An app takes time to initialize or becomes temporarily unable to serve (e.g., waiting for DB connection).

3. Startup Probe:
  - Used when an application takes a long time to start. It gives the app more time before Kubernetes starts liveness checks.
  - Use Case: For legacy apps or apps with long initialization routines
  - How it works:
      - If a startup probe is defined, liveness and readiness probes are disabled until the startup probe succeeds.After success, Kubernetes starts running the other probes.

| **Probe Type**    | **What it Checks**           | **Failure Action**                   | **Use Case**                         |
|------------------|----------------------------|--------------------------------------|--------------------------------------|
| Liveness Probe  | Is the app alive?           | Restart the container               | App crash, hang, or deadlock        |
| Readiness Probe | Is the app ready to serve?  | Remove pod from Service endpoint    | App warming up, waiting for resources |
| Startup Probe   | Has the app started yet?    | Kill pod if it doesn't start in time | Slow-starting apps                  |

---

#### Q: What is the function of maxUnavailable and maxSurge in rolling update deployment stratergy ?

**Solution**:

✅ maxUnavailable

  - The maximum number of Pods that can be unavailable during the update.
  - Expressed as an absolute number or percentage of desired Pods.
  - Ensures that a certain number of replicas are always available.

✅ maxSurge

  - The maximum number of extra Pods that can be created above the desired number of Pods during the update.
  - Also expressed as an absolute number or percentage.
  - Allows faster rollout by temporarily exceeding the desired replica count.


📊 Example
Let's say your Deployment has replicas: 4.

### 📄 YAML Example
```yaml
    strategy:
      type: RollingUpdate
      rollingUpdate:
        maxUnavailable: 1
        maxSurge: 2
```
- What happens during the update:
   - Kubernetes may bring up to 2 extra Pods temporarily (6 total Pods max).
   - At most 1 Pod can be unavailable at any given time.
   - This speeds up the rollout while maintaining high availability.

📌 Summary Table

| Setting          | Meaning                                               | Default |
| ---------------- | ----------------------------------------------------- | ------- |
| `maxUnavailable` | Max number of Pods that can be **down** during update | `1`     |
| `maxSurge`       | Max number of **extra Pods** created during update    | `1`     |

Both can be set as:
  - A number (e.g., 1)
  - A percentage string (e.g., "25%")

---