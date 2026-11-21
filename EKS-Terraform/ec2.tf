###########################################################
# UBUNTU 24.04 AMI
###########################################################

data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

###########################################################
# UBUNTU ADMIN EC2 LAUNCH TEMPLATE
###########################################################

resource "aws_launch_template" "eks_admin_lt" {

  name = "eks-admin-ubuntu-launch-template"

  image_id = data.aws_ssm_parameter.ubuntu_ami.value

  instance_type = "t3.medium"

  vpc_security_group_ids = [
    aws_security_group.allow_all.id
  ]

  iam_instance_profile {
    name = aws_iam_instance_profile.eks_admin_profile.name
  }

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = 50
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "eks-admin-ubuntu"
      Environment = "dev"
      Project     = "eks-project"
    }
  }

  tags = {
    Name = "eks-admin-ubuntu-launch-template"
  }
}


###########################################################
# ADMIN EC2
###########################################################
resource "aws_instance" "eks" {

  subnet_id = aws_subnet.public1.id

  launch_template {
    id = aws_launch_template.eks_admin_lt.id

    version = aws_launch_template.eks_admin_lt.latest_version
  }

  user_data = base64encode(<<-EOF
#!/bin/bash

set -euxo pipefail

exec > /var/log/eks-admin-setup.log 2>&1

apt-get update -y

apt-get install -y \
  curl \
  unzip \
  tar \
  gzip \
  jq

# Install AWS CLI
curl -fL \
  https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
  -o /tmp/awscliv2.zip

unzip -q /tmp/awscliv2.zip -d /tmp

/tmp/aws/install

# Install kubectl
KUBECTL_VERSION="v1.35.0"

curl -fL \
  "https://dl.k8s.io/release/$${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
  -o /tmp/kubectl

install -m 0755 /tmp/kubectl /usr/local/bin/kubectl

# Install eksctl
curl -fL \
  https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_linux_amd64.tar.gz \
  -o /tmp/eksctl.tar.gz

tar -xzf /tmp/eksctl.tar.gz -C /tmp

install -m 0755 /tmp/eksctl /usr/local/bin/eksctl

# Configure AWS region
export AWS_DEFAULT_REGION=us-east-1

# Wait for EKS cluster
until aws eks describe-cluster \
  --name chandra \
  --region us-east-1 >/dev/null 2>&1
do
  sleep 20
done

# Wait for ACTIVE
while true; do

  STATUS=$(aws eks describe-cluster \
    --name chandra \
    --region us-east-1 \
    --query 'cluster.status' \
    --output text)

  if [ "$STATUS" = "ACTIVE" ]; then
    break
  fi

  sleep 20

done

# Configure kubeconfig
mkdir -p /root/.kube

aws eks update-kubeconfig \
  --name chandra \
  --region us-east-1 \
  --kubeconfig /root/.kube/config

export KUBECONFIG=/root/.kube/config

# Wait for Kubernetes nodes
until kubectl get nodes >/dev/null 2>&1; do
  sleep 15
done

kubectl get nodes -o wide

kubectl get pods -A

echo "EKS Admin Ubuntu setup completed"

EOF
  )

  depends_on = [
    aws_eks_access_policy_association.eks_admin
  ]

  tags = {
    Name = "eks-admin"
  }
}

