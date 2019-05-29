# k8s-guide
kubernetes cluster ceration doc


# How to Setup Kubernetes Cluster on AWS Using KOPS
Prerequisites:
- Ubuntu instance
- AWS-cli setup
- S3 bucket

# Install kubectl

$ curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

$ chmod +x ./kubectl

$ sudo mv ./kubectl /usr/local/bin/kubectl

# Alternative method to install kubectl of a specific version

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
   
Then run the below command:-
- $ yum install kubectl-<version>
For example:- 
   - yum install kubectl-1.8.7
   

# Install kops
wget https://github.com/kubernetes/kops/releases/download/1.8.1/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

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


# To install Dashboard
kubectl create -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/kubernetes-dashboard/v1.4.0.yaml --context=${NAME} --validate=false


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

