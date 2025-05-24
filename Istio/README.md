## Istio as service mesh.

**Refrence docs for deploying istio as service mesh**
  - https://istio.io/latest/docs/setup/getting-started/
  - https://istio.io/latest/docs/setup/install/istioctl/
  - https://istio.io/latest/docs/examples/bookinfo/noistio.svg
  - https://istio.io/latest/docs/tasks/traffic-management/

**Admission Controller & Dynamic Admission Control**
  - https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/
  - https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/
  
**Practice**
  - https://github.com/iam-veeramalla/istio-guide
  ---

## Some commands used during hands-on 

| **Resource Type**                  | **Action** | **Command**                                                          |
| ---------------------------------- | ---------- | -------------------------------------------------------------------- |
| **CRD (CustomResourceDefinition)** | Create     | `kubectl apply -f my-crd-definition.yaml`                            |
|                                    | List       | `kubectl get crds`                                                   |
|                                    | Describe   | `kubectl describe crd <crd-name>`                                    |
|                                    | Delete     | `kubectl delete crd <crd-name>`                                      |
| **CR (Custom Resource)**           | Create     | `kubectl apply -f my-custom-resource.yaml`                           |
|                                    | List       | `kubectl get <kind-in-lowercase>`  (e.g., `kubectl get myresources`) |
|                                    | Describe   | `kubectl describe <kind> <name>`                                     |
|                                    | Delete     | `kubectl delete <kind> <name>`                                       |
| **VirtualService**                 | Create     | `kubectl apply -f virtual-service.yaml`                              |
|                                    | List       | `kubectl get virtualservices.networking.istio.io`                    |
|                                    | Describe   | `kubectl describe virtualservice <name>`                             |
|                                    | Delete     | `kubectl delete virtualservice <name>`                               |
| **DestinationRule**                | Create     | `kubectl apply -f destination-rule.yaml`                             |
|                                    | List       | `kubectl get destinationrules.networking.istio.io`                   |
|                                    | Describe   | `kubectl describe destinationrule <name>`                            |
|                                    | Delete     | `kubectl delete destinationrule <name>`                              |

