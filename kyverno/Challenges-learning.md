## Kyverno: Resource Request Limit Policy & Exclusions

### Q:
I have a cluster-wide policy to limit resource requests/limits for a pod. When I create a new pod in any namespace other than the default, and I run this policy locally on my Kubernetes cluster, it seems not to get enforced. Why?

---

### A:
Kyverno excludes certain namespaces from policy enforcement by default to avoid disrupting critical Kubernetes system components.

#### **How to Check Excluded Namespaces?**

Run the following command to see your Kyverno ConfigMap:

```bash
kubectl get configmap -n kyverno kyverno -o yaml
```

Look under:

```yaml
data:
  excludeGroupRole: ...
  excludeUsername: ...
  excludedNamespaces: kube-system,kube-public,kube-node-lease,kyverno
```

---

### Q:
What does the following ConfigMap mean?

```yaml
apiVersion: v1
kind: ConfigMap
data:
  excludeGroupRole: system:serviceaccounts:kube-system,system:nodes,system:kube-scheduler
  generateSuccessEvents: "false"
  resourceFilters: |
    [Event,*,*]
    [*,kube-system,*]
    [*,kube-public,*]
    [*,kube-node-lease,*]
    [*,kyverno,*]
    [Node,*,*]
    [APIService,*,*]
    [TokenReview,*,*]
    [SubjectAccessReview,*,*]
    [SelfSubjectAccessReview,*,*]
    ...
  webhooks: '[{"namespaceSelector": {"matchExpressions": [{"key":"kubernetes.io/metadata.name","operator":"NotIn","values":["kyverno"]}]}}]'
```

#### **Explanation:**

- **excludeGroupRole:**  
  Kyverno ignores requests from these groups/roles:
  - `system:serviceaccounts:kube-system`: Service accounts in the kube-system namespace
  - `system:nodes`: The kubelet/node API clients
  - `system:kube-scheduler`: The Kubernetes scheduler

- **generateSuccessEvents: "false"**  
  Kyverno will not generate events for successful operations (rule passes, successful policy applications).

- **resourceFilters:**  
  Tells Kyverno which resources to skip. Each line follows the format:  
  `[<Kind>,<Namespace>,<Name>]`  
  For example:
  - `[*,kube-system,*]` → Ignore all resources in the kube-system namespace
  - `[Node,*,*]` → Ignore all Node resources
  - `[Event,*,*]` → Ignore all Event objects
  - `[*,kyverno,*]` → Ignore anything in the kyverno namespace

- **webhooks:**  
  ```json
  [{"namespaceSelector": {"matchExpressions": [{"key":"kubernetes.io/metadata.name","operator":"NotIn","values":["kyverno"]}]}}]
  ```
  This controls which namespaces Kyverno’s admission webhooks apply to.  
  The above means: **Do not run validation/mutation webhooks in the kyverno namespace.**

---

### **Summary Table**

| Key Setting                  | Meaning                                                    |
|------------------------------|------------------------------------------------------------|
| `excludeGroupRole`           | Ignores requests from critical system components           |
| `generateSuccessEvents`      | Reduces event noise by logging only failures               |
| `resourceFilters`            | Excludes specific kinds/namespaces from policy processing  |
| `webhooks.namespaceSelector` | Skips running webhooks in the `kyverno` namespace          |

---