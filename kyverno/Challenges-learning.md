Q: I have cluster wide policy to limit resource request limit for a pod, when I create new pod in any other namespace apart from default namespace by running this policy locally on my kubernetes cluster I'm able to create new pod without setting up resource request limit why so ?

Sol:Kyverno excludes certain namespaces from policy enforcement by default to avoid disrupting critical Kubernetes system components.
        Ques:a) How to Check this ?
        Sol :a) Run this command to see your Kyverno ConfigMap: kubectl get configmap -n kyverno kyverno -o yaml
                Look under:
                    data:
                    excludeGroupRole: ...
                    excludeUsername: ...
                    excludedNamespaces: kube-system,kube-public,kube-node-lease,kyverno

Ques : What is meaning of following ?

apiVersion: v1
data:
  excludeGroupRole: system:serviceaccounts:kube-system,system:nodes,system:kube-scheduler
  generateSuccessEvents: "false"
  resourceFilters: |
    [Event,*,*] [*,kube-system,*] [*,kube-public,*] [*,kube-node-lease,*] [*,kyverno,*] [Node,*,*] [APIService,*,*] [TokenReview,*,*] [SubjectAccessReview,*,*] [SelfSubjectAccessReview,*,*] [*,kyverno,kyverno*] [Binding,*,*] [ReplicaSet,*,*] [AdmissionReport,*,*] [ClusterAdmissionReport,*,*] [BackgroundScanReport,*,*] [ClusterBackgroundScanReport,*,*] [PolicyReport,*,*] [ClusterPolicyReport,*,*]
  webhooks: '[{"namespaceSelector": {"matchExpressions": [{"key":"kubernetes.io/metadata.name","operator":"NotIn","values":["kyverno"]}]}}]'
kind: ConfigMap

Sol : This ConfigMap is part of Kyverno's configuration. It controls which resources Kyverno ignores or processes, and how it behaves.

a) excludeGroupRole: system:serviceaccounts:kube-system,system:nodes,system:kube-scheduler
	Kyverno ignores requests coming from these groups/roles:
		system:serviceaccounts:kube-system: Service accounts in the kube-system namespace
		system:nodes: The kubelet / node API clients
		system:kube-scheduler: The Kubernetes scheduler

b) generateSuccessEvents: "false" -- > Kyverno will not generate events for successful operations like rule passes or successful policy applications.

c) resourceFilters: This is a critical setting that tells Kyverno which resources to skip. Each line has this format:
	[<Kind>,<Namespace>,<Name>]

	for example :
		resourceFilters: |
			  [Event,*,*]
			  [*,kube-system,*]
			  [*,kube-public,*]
			  [*,kube-node-lease,*]
			  [*,kyverno,*]
			  ...

			  Meaning of above .

				[*,kube-system,*] → ignore all resources in kube-system namespace
				[Node,*,*] → ignore all Node resources
				[Event,*,*] → ignore all Event objects
				[*,kyverno,kyverno*] → ignore anything in kyverno namespace that starts with kyverno

d) webhooks: '[{"namespaceSelector": {"matchExpressions": [{"key":"kubernetes.io/metadata.name","operator":"NotIn","values":["kyverno"]}]}}]' 
		This controls which namespaces Kyverno’s admission webhooks apply to as per the above expression it says don't run validation/mutation webhooks in the kyverno namespace .

Summary 

| Key Setting                  | Meaning                                                               |
| ---------------------------- | --------------------------------------------------------------------- |
| `excludeGroupRole`           | Ignores requests from critical system components                      |
| `generateSuccessEvents`      | Reduces event noise by logging only failures                          |
| `resourceFilters`            | Excludes specific kinds/namespaces from policy processing             |
| `webhooks.namespaceSelector` | Tells Kyverno's admission webhook to **skip the `kyverno` namespace** |