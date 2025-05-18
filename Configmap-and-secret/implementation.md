## Implementation of config map in the form of environment variable as well as volume mount.

**ConfigMap Definition & Definition**

- A ConfigMap is an API object that lets you store configuration for other objects to use. Unlike most Kubernetes objects that have a spec, a ConfigMap has data and binaryData fields. These fields accept key-value pairs as their values.

- A ConfigMap is a Kubernetes object used to store non-sensitive key-value pairs (such as config options, settings, flags, or environment-specific data). These values can be consumed by your application without hardcoding them into your container image.

 - There are four different ways that you can use a ConfigMap to configure a container inside a Pod:

    - Inside a container command and args.
    - Environment variables for a container.
    - Add a file in read-only volume, for the application to read.
    - Write code to run inside the Pod that uses the Kubernetes API to read a ConfigMap.

- Refrence Docs : - Ref Docs : https://kubernetes.io/docs/concepts/configuration/configmap/

**ConfigMap as environment variable**

  **Why Use ConfigMap as Environment Variables?**
    - Makes your app portable and configurable across environments.
    - Keeps your config outside of the container.
    - Enables easy updates to configuration without rebuilding your Docker image.
    - Config Map from commandline : `kubectl create configmap app-config --from-literal=LOG_LEVEL=debug --from-literal=PORT=8080`
    - In YAML format above command looks:
                apiVersion: v1
                kind: ConfigMap
                metadata:
                name: app-config
                data:
                    LOG_LEVEL: debug
                    PORT: "8080"
    
    **Behavior & Considerations**

    | Aspect                 | Behavior                                                                                     |
    | ---------------------- | -------------------------------------------------------------------------------------------- |
    | **Non-existent keys**  | If a key doesn't exist in the ConfigMap, the Pod **won’t start** (with `env`, not `envFrom`) |
    | **Immutable option**   | You can make a ConfigMap **immutable** to avoid accidental changes (`immutable: true`)       |
    | **Validation**         | No type validation — all values are plain strings                                            |

    Q: Meaning of | **Validation**  | No type validation — all values are plain strings  | ?
    Sol : Kubernetes does not enforce or interpret the data types of the values stored in a ConfigMap. It treats everything as a plain string — regardless of whether it looks like a number, boolean, or list.

    - Use `envFrom` when you want simple injection of all values.
    - Use `env` when you want control, renaming, or fallback values.
    - Use ConfigMap with Secrets when you have both public and sensitive values.
    - Don’t store passwords, API keys, or tokens in ConfigMaps — use Secrets instead.

    Q: When to use `env` or `envFrom` or in which situation we have to use env|envFrom ?
    Sol : 
    | Situation                                       | Recommended |
    | ----------------------------------------------- | ----------- |
    | We want all config key-values as-is             | `envFrom`   |
    | We want to select only certain keys             | `env`       |
    | We want to rename config keys                   | `env`       |
    | We want to mix ConfigMap, Secret, and literals  | `env`       |
    | We want simplicity and have a flat config       | `envFrom`   |


    - The `envFrom` field instructs Kubernetes to create environment variables from the sources nested within it. The inner `configMapRef` refers to a ConfigMap by its name and selects `all its key-value pairs`. Add the Pod to your cluster, then retrieve its logs to see the output from the printenv command. 

    - Sometimes a Pod won't require access to all the values in a ConfigMap. For example, you could have another Pod which only uses the username value from the ConfigMap. For this use case, you can use the `env.valueFrom` syntax instead, which lets you select individual keys in a ConfigMap. The name of the environment variable can also be different from the key within the ConfigMap.

**ConfigMap as volume**

-  ConfigMaps in Kubernetes can be mounted as volumes into Pods.

- Use Case
    - You need to inject entire config files.
    - The application expects a file (rather than environment variables).
    - You want dynamic configuration without rebuilding the container.
    - In this demo: ConfigMap yaml file i.e. my-config-1.yaml is mounted to `/etc/foo` inside the pod/container.
    - The keys in configmap becomes a files inside pod i.e.` /etc/foo/db-port` as well as `/etc/foo/db-url`
        - Each key in the ConfigMap becomes a file in the mounted directory.
        - File contents are the values of the keys.
        - Changes to the ConfigMap after mounting are automatically reflected inside kubernetes pod/container, we don't have to restart pod/deployment. But changes made to config map yaml file has to be re-applied using kubectl apply -f my-config-1.yaml but this will not restart the pod / container.

**Outcomes of config-map with environmant variables as well with volumes**

- ![Config-map-1](../images/Config-map-1.PNG)
- ![Config-map-2](../images/Config-map-2.PNG)
- ![Config-map-3](../images/Config-map-3.PNG)
- ![Config-map-4](../images/Config-map-4.PNG)
- ![Config-map-5](../images/Config-map-5.PNG)
- ![Config-map-6](../images/Config-map-6.PNG)
- ![Config-map-7](../images/Config-map-7.PNG)
- ![Config-map-8](../images/Config-map-8.PNG)
- ![Config-map-9](../images/Config-map-9.PNG)
- ![Config-map-10](../images/Config-map-10.PNG)
