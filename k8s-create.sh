export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)


export KUBERNETES_PROVIDER=aws;
export KOPS_STATE_STORE=s3://example-k8s-bucket
export NAME=example-domain.com
echo $NAME

export MASTER_SIZE=t2.micro
export NODE_SIZE=t2.micro
export NUM_NODES=2
export NODE_ZONES=ap-southeast-1b,ap-southeast-1c
export MASTER_ZONES=ap-southeast-1c

export AWS_S3_REGION=ap-southeast-1


kops create cluster \
--cloud=$KUBERNETES_PROVIDER \
--zones=$NODE_ZONES \
--master-zones=$MASTER_ZONES \
--node-count=$NUM_NODES \
--node-size=$NODE_SIZE \
--master-size=$MASTER_SIZE \
--associate-public-ip=true  \
--name=$NAME \
--yes

kops update cluster ${NAME} --yes
