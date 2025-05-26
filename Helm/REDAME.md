## Helm in Kubernetes
- Helm is a package manager for Kubernetes that helps manage Kubernetes applications through Helm Charts.

**Installation of Helm**
- https://helm.sh/docs/intro/install/ 

**Practice Helm**
- https://github.com/iam-veeramalla/helm-zero-to-hero/
- https://github.com/khannashiv/Helm-Practice

**Commonly used Helm commands**

--- 
🔧 Basic Helm Commands

| Command        | Description                         |
| -------------- | ----------------------------------- |
| `helm version` | Show the version of Helm installed. |
| `helm help`    | Display help for Helm commands.     |

📦 Working with Charts

| Command                    | Description                                   |
| -------------------------- | --------------------------------------------- |
| `helm create <chart-name>` | Create a new chart with the given name.       |
| `helm lint <chart>`        | Check a chart for errors.                     |
| `helm package <chart>`     | Package a chart directory into a `.tgz` file. |
| `helm template <chart>`    | Render chart templates locally.               |

📁 Chart Repositories

| Command                      | Description                                           |
| ---------------------------- | ----------------------------------------------------- |
| `helm repo add <name> <url>` | Add a new chart repository.                           |
| `helm repo update`           | Update information of available charts from the repo. |
| `helm repo list`             | List chart repositories.                              |
| `helm search repo <keyword>` | Search charts in repos for a keyword.                 |

🚀 Installing and Managing Releases

| Command                               | Description                   |
| ------------------------------------- | ----------------------------- |
| `helm install <release-name> <chart>` | Install a chart as a release. |
| `helm upgrade <release-name> <chart>` | Upgrade an existing release.  |
| `helm uninstall <release-name>`       | Uninstall a release.          |
| `helm list`                           | List installed releases.      |


🔍 Inspecting and Debugging

| Command                                   | Description                                 |
| ----------------------------------------- | ------------------------------------------- |
| `helm status <release-name>`              | View the status of a release.               |
| `helm get all <release-name>`             | Get all information about a release.        |
| `helm history <release-name>`             | View the history of a release.              |
| `helm rollback <release-name> <revision>` | Roll back a release to a previous revision. |

---

## 🚀 Helm Hands-on Script

Below is a shell script that performs Helm repository setup, packaging, pushing to GitHub Pages, and installing services .

```bash

# Add Helm repo
helm repo add myrepo https://khannashiv.github.io/Helm-Practice
helm repo update

# Clean up old files before doi
rm -rf shipping-1.1.0.tgz index.yaml

# Package Helm charts
helm package payments/
helm package shipping/

# Recreate Helm repo index
helm repo index . --url https://khannashiv.github.io/Helm-Practice

# Push changes to GitHub
git add .
git commit -m "Fix"
git push origin main

# Update repo and install charts
helm repo update
helm install payments-service myrepo/payments 
helm install shipping-service myrepo/shipping

# Search and template charts
helm search repo myrepo
helm template payments-service myrepo/payments --debug

```