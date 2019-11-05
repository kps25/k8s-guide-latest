## Deploy the Kubernetes Web UI (Dashboard)
Ref:- https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html

## Deploying the K8s Dashboard in kubernetes-dashboard namespace:-
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml

### Dashboard URL:
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/login

Replace localhost:8001 with --> https://<domain-name>/


Create a file called eks-admin-service-account.yaml with the text below. This manifest defines a service account and cluster role binding called eks-admin.

apiVersion: v1
kind: ServiceAccount
metadata:
  name: eks-admin
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: eks-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: eks-admin
  namespace: kube-system
Apply the service account and cluster role binding to your cluster.

kubectl apply -f eks-admin-service-account.yaml
Output:

serviceaccount "eks-admin" created
clusterrolebinding.rbac.authorization.k8s.io "eks-admin" created
Step 4: Connect to the Dashboard
