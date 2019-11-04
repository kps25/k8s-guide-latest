## Install Kubetcl Latest Version on Linux OS
1) curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
2) chmod +x ./kubectl
3) sudo mv ./kubectl /usr/local/bin/kubectl

## Install Kops Latest Version on Linux OS
1) wget https://github.com/kubernetes/kops/releases/download/1.10.0/kops-linux-amd64
2) chmod +x kops-linux-amd64
3) mv kops-linux-amd64 /usr/local/bin/kops



# Create a K8s Cluster -->> 
$ kops create cluster --state "s3://<Bucket-Name>" --zones "us-east-1d,us-east-1f" --master-count 1 --node-count 1 --node-size=t2.micro --name <Domain-Name> --yes
## For ex:- 
kops create cluster --state "s3://new-ssp-bucket" --zones "us-east-1d,us-east-1f" --master-count 1 --node-count 1 --node-size=t2.micro --name sspcloudpro.co.in --yes
