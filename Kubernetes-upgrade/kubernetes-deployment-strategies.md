
# Kubernetes Deployment Strategies

This document details various deployment strategies available in Kubernetes, including how they work, when to use them, pros and cons, and YAML configuration examples.

---

## 1. Rolling Update Strategy (Default)

### 🧠 What It Is
The default Kubernetes deployment strategy. Gradually replaces old pods with new ones while maintaining availability.

### ⚙️ How It Works
- Terminates a few old pods.
- Spins up new pods incrementally.

### ✅ When to Use
- Supports multiple running versions.
- Requires high availability.

### 🔧 Key Settings
- `maxUnavailable`: Allowed unavailable pods during update.
- `maxSurge`: Extra pods allowed beyond desired count.

### 👍 Pros
- No downtime.
- Native and simple to use.

### 👎 Cons
- Rollback takes time.
- Can't test new version in isolation.

### 📄 YAML Example
```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 1
    maxSurge: 1
```

### 🔁 Rollback
```bash
kubectl rollout undo deployment/myapp
```

---

## 2. Blue/Green Deployment Strategy

### 🧠 What It Is
Two environments: Blue (live), Green (new). Traffic is switched to Green after testing.

### ⚙️ How It Works
- Deploy Green alongside Blue.
- Test and validate Green.
- Switch service to point to Green.

### ✅ When to Use
- Need clean rollback.
- Want to test new version in production.

### 👍 Pros
- Instant rollback.
- Safe and predictable.

### 👎 Cons
- Requires double resources.
- Traffic switching must be manual.

### 📄 YAML Example
```yaml
# Green Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-green
spec:
  replicas: 3
  selector:
    matchLabels:
      version: green
  template:
    metadata:
      labels:
        version: green
    spec:
      containers:
      - name: myapp
        image: myapp:v2
```

### 🔁 Rollback
Update the service selector to point back to Blue.

---

## 3. Canary Deployment Strategy

### 🧠 What It Is
New version is deployed to a small set of users, then gradually rolled out to more.

### ⚙️ How It Works
- Start with a few pods.
- Monitor performance.
- Gradually increase traffic.

### ✅ When to Use
- Need safe and incremental rollout.
- Real-time monitoring is available.

### 👍 Pros
- Reduces risk.
- Easy rollback early in deployment.

### 👎 Cons
- Requires traffic splitting setup.
- Monitoring is crucial.

### 📄 YAML Example
```yaml
# Canary Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-canary
spec:
  replicas: 1
  selector:
    matchLabels:
      version: canary
  template:
    metadata:
      labels:
        version: canary
    spec:
      containers:
      - name: myapp
        image: myapp:v2
```

### 🔁 Rollback
Scale down or remove the canary deployment.

---

## 4. A/B Testing Deployment Strategy

### 🧠 What It Is
Routes traffic to different versions based on user attributes (headers, cookies, etc).

### ⚙️ How It Works
- Uses Ingress rules or service mesh (e.g., Istio).
- Custom logic controls traffic direction.

### ✅ When to Use
- Feature testing for specific user groups.
- UX experiments and performance testing.

### 👍 Pros
- Precise user targeting.
- Great for experimentation.

### 👎 Cons
- Complex setup (requires ingress/controller/mesh).
- Advanced routing configuration needed.

### 📄 YAML Example (Istio)
```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: myapp
spec:
  hosts:
  - myapp.example.com
  http:
  - match:
    - headers:
        user-group:
          exact: "beta"
    route:
    - destination:
        host: myapp
        subset: v2
  - route:
    - destination:
        host: myapp
        subset: v1
```

### 🔁 Rollback
Remove routing rule for version B or revert headers.

---

## ✅ Strategy Comparison Table

| Strategy         | Downtime | Traffic Control   | Rollback        | Complexity | Best For                          |
|------------------|----------|-------------------|------------------|------------|-----------------------------------|
| Recreate         | Yes      | None              | Easy             | Low        | Quick, simple updates             |
| Rolling Update   | No       | Automatic         | Medium           | Low        | General usage                     |
| Blue/Green       | No       | Manual switch     | Easy             | Medium     | Test before release, fast rollback |
| Canary           | No       | Gradual rollout   | Easy (early)     | Medium     | Risk-controlled deployment        |
| A/B Testing      | No       | Custom/user-based | Medium           | High       | Targeted experiments              |
