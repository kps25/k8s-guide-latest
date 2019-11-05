## Deploy the Kubernetes Web UI (Dashboard)
Ref:- https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html

## Deploying the K8s Dashboard in kubernetes-dashboard namespace:-
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml

### Dashboard URL:
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/login

Replace localhost:8001 with --> https://<domain-name>/
