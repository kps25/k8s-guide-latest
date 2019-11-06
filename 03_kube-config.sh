#!/usr/bin/env bash

# Default login: ssh -i ~/.ssh/id_rsa admin@api.<domain-name>
# ssh-add ~/.ssh/id_rsa
# ssh admin@api.<domain-name>
# sudo cat /srv/kubernetes/known_tokens.csv | grep kube,kube

API_SERVER="https://api.<domain-name>"
TOKEN="MVsVHwk3ftUfr83pQQ9ymtEdCyd3E1rE"
CLUSTER_NAME="<domain-name>"

kubectl config set preferences.colors true

kubectl config set-cluster ${CLUSTER_NAME} --server=${API_SERVER} --insecure-skip-tls-verify=true
kubectl config set-credentials ${CLUSTER_NAME} --token=${TOKEN}

# Set context to new root cluster
kubectl config set-context ${CLUSTER_NAME}

# Print all contexts
kubectl config get-contexts
kubectl get ns
