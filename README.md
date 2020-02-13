# k8s-guide
kubernetes cluster ceration doc


# How to Setup Kubernetes Cluster on AWS Using KOPS
Prerequisites:
- Ubuntu instance
- AWS-cli setup
- S3 bucket

# Install kubectl

$curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

$chmod +x ./kubectl

$sudo mv ./kubectl /usr/local/bin/kubectl


# Install kops

$ curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64

$ chmod +x ./kops

$ sudo mv ./kops /usr/local/bin/

# Create Route53 domain for the cluster

aws route53 create-hosted-zone --name <domain-name> --caller-reference 2018-04-04-00:0


# Create a S3 bucket which will keep the configuration for the cluster:

$ aws s3 mb s3://<your-Bucket-name>
Ex:- s3://mybucket

## Copy the below content in a file called k8s-cluster-create.sh 

export AWS_ACCESS_KEY_ID=<access key>
export AWS_SECRET_ACCESS_KEY=<secret key>

export KUBERNETES_PROVIDER=aws;

export KOPS_STATE_STORE=s3://<bucket name>
export NAME=<domain name>

export MASTER_SIZE=t2.micro;
export NODE_SIZE=t2.micro;
export NUM_NODES=2;
export NODE_ZONES=ap-south-1a,ap-south-1b;
export MASTER_ZONES=ap-south-1a;

export AWS_S3_REGION=ap-south-1;

kops create cluster \
   --cloud=$KUBERNETES_PROVIDER \
   --zones=$NODE_ZONES \
   --master-zones=$MASTER_ZONES \
   --node-count=$NUM_NODES \
   --node-size=$NODE_SIZE \
   --master-size=$MASTER_SIZE \
   --associate-public-ip=true \
   --name=$NAME \
   --yes

kops update cluster ${NAME} --yes



# Run the below command to create the kubernetes cluster


$ sh k8s-create-cluster.sh


# Once the cluster is created, You will see the below output

Cluster is starting.  It should be ready in a few minutes.

Suggestions:
 * validate cluster: kops validate cluster
 * list nodes: kubectl get nodes --show-labels
 * ssh to the master: ssh -i ~/.ssh/id_rsa admin@api.k8s.cloud.in

# Once the cluster is up and running, We need to get the config to connect to K8s Cluster
## Run the below command

$ kops export kubecfg ${NAME}

Above command will get the configurations of the newly created and copied into ~/.kube/config file


# To install Dashboard
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc5/aio/deploy/recommended.yaml

# Now access Dashboard at:

$ http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/.



# Create An Authentication Token (RBAC)
To find out how to create sample user and log in following the below Creating sample user guide.

$ Link:- https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md


# Commands:

# To create a new namespace
kubectl create namespace <namespace-name>


## To get the login detals of the dashboard and creds of the Cluster
kubectl config view --minify

## To get the cluster details
Kops get clusters


## To know the nodes details $
kubectl get nodes –o wide

## To know the pods details $
kubectl get pods



## When you have an issue with `kubectl get pods`

kubectl get nodes
# Error from server (NotAcceptable): unknown (get nodes)


Try install ing the below commands again

1) curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.7/bin/linux/amd64/kubectl
2) chmod +x ./kubectl
3) sudo mv ./kubectl /usr/local/bin/kubectl


## Reference:
https://github.com/kubernetes/kubernetes

