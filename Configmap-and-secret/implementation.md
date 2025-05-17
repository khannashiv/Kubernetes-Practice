## Implementation of config map in the form of environment variable as well as volume mount.

**ConfigMap Definition & Definition**

 - A ConfigMap is an API object that lets you store configuration for other objects to use. Unlike most Kubernetes objects that have a spec, a ConfigMap has data and binaryData fields. These fields accept key-value pairs as their values.

 - There are four different ways that you can use a ConfigMap to configure a container inside a Pod:
    - Inside a container command and args.
    - Environment variables for a container.
    - Add a file in read-only volume, for the application to read.
    - Write code to run inside the Pod that uses the Kubernetes API to read a ConfigMap.

- The `envFrom` field instructs Kubernetes to create environment variables from the sources nested within it. The inner configMapRef refers to a ConfigMap by its name and selects all its key-value pairs. Add the Pod to your cluster, then retrieve its logs to see the output from the printenv command. 

- Sometimes a Pod won't require access to all the values in a ConfigMap. For example, you could have another Pod which only uses the username value from the ConfigMap. For this use case, you can use the `env.valueFrom` syntax instead, which lets you select individual keys in a ConfigMap. The name of the environment variable can also be different from the key within the ConfigMap.

 - Ref Docs : https://kubernetes.io/docs/concepts/configuration/configmap/
