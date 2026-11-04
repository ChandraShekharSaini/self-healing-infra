# 🚀 End-to-End DevOps Project: Python Microservices on AWS EKS

![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazonaws)
![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python)
![FastAPI](https://img.shields.io/badge/FastAPI-Microservices-009688?logo=fastapi)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes)
![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI/CD-2088FF?logo=githubactions)
![Argo CD](https://img.shields.io/badge/Argo%20CD-GitOps-EF7B4D?logo=argo)
![NGINX](https://img.shields.io/badge/NGINX-Ingress-009639?logo=nginx)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800?logo=grafana)

## 📌 Project Overview

This project demonstrates an end-to-end DevOps workflow for deploying **Python-based microservices on Amazon Elastic Kubernetes Service (EKS)**.

The project integrates Infrastructure as Code (IaC), containerization, automated CI/CD, GitOps-based continuous delivery, ingress traffic management, monitoring, and centralized logging.

Infrastructure is provisioned using Terraform. Python microservices are containerized using Docker and published to Amazon ECR through GitHub Actions. Argo CD manages Kubernetes deployments using GitOps principles.

NGINX Ingress Controller manages external HTTP/HTTPS traffic and routes requests to the appropriate microservices.

Prometheus, Grafana, and the EFK stack provide monitoring, visualization, and centralized log management.

## 🎯 Project Objectives

- Provision AWS infrastructure using Terraform.
- Develop Python-based microservices using FastAPI.
- Containerize microservices using Docker.
- Automate CI/CD pipelines using GitHub Actions.
- Store Docker images in Amazon ECR.
- Deploy microservices on Amazon EKS.
- Implement GitOps-based deployment using Argo CD.
- Configure NGINX Ingress Controller for external traffic routing.
- Monitor applications and Kubernetes resources using Prometheus and Grafana.
- Centralize application and infrastructure logs using EFK.

## 🏗️ Architecture

![End-to-End DevOps Architecture](images/architecture.png)

### Architecture Workflow

1. Developer pushes Python microservices code to GitHub.
2. GitHub Actions builds and tests the Python applications.
3. Docker images are created for individual microservices.
4. Images are pushed to Amazon ECR.
5. GitHub Actions updates Kubernetes manifests in the GitOps repository.
6. Argo CD detects changes and synchronizes Kubernetes resources.
7. Amazon EKS runs and manages the microservices.
8. NGINX Ingress Controller routes external requests to the appropriate services.
9. Prometheus collects metrics and Grafana displays monitoring dashboards.
10. Fluentd forwards application logs to Elasticsearch, which can be searched using Kibana.

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Python | Backend development |
| FastAPI | REST API and microservices |
| Docker | Application containerization |
| Amazon ECR | Container image registry |
| Amazon EKS | Managed Kubernetes orchestration |
| Amazon EC2 | Compute infrastructure |
| Terraform | Infrastructure as Code |
| GitHub Actions | CI/CD automation |
| Argo CD | GitOps continuous delivery |
| Kubernetes | Container orchestration |
| NGINX Ingress Controller | External traffic routing |
| Prometheus | Metrics collection |
| Grafana | Monitoring dashboards |
| Fluentd | Log collection |
| Elasticsearch | Log storage and indexing |
| Kibana | Log visualization |

## 🔄 Project Workflow

### 1. Develop Python Microservices

- Develop independent microservices using Python and FastAPI.
- Create REST APIs for individual services.
- Configure dependencies using `requirements.txt`.
- Implement health-check endpoints.
- Configure environment variables for application settings.

Example microservices:

- User Service
- Product Service
- Order Service
- Payment Service

### 2. Containerize Applications Using Docker

- Create an individual Dockerfile for each microservice.
- Build Docker images.
- Test containers locally.
- Configure application ports and environment variables.

Example:

```bash
docker build -t user-service:latest ./user-service
docker build -t product-service:latest ./product-service
docker build -t order-service:latest ./order-service
```

### 3. Automate CI/CD Using GitHub Actions

- Trigger workflows on configured Git events.
- Install Python dependencies.
- Execute application tests.
- Build Docker images for individual microservices.
- Authenticate with Amazon ECR.
- Push versioned Docker images to ECR.
- Update Kubernetes deployment manifests in the GitOps repository.

### 4. Provision AWS Infrastructure Using Terraform

Use Terraform to provision:

- VPC and networking components.
- Public and private subnets.
- Internet Gateway and NAT Gateway.
- IAM roles and policies.
- Amazon EKS cluster.
- EKS managed node groups.
- Amazon ECR repositories.
- Security groups and supporting resources.

### 5. Deploy Microservices on Amazon EKS

Deploy individual microservices using Kubernetes:

- Deployments
- Services
- ConfigMaps
- Secrets
- Namespaces
- Liveness and Readiness Probes
- Resource Requests and Limits
- Horizontal Pod Autoscaler (HPA)

Each microservice runs independently and communicates with other services through Kubernetes Services.

### 6. Configure NGINX Ingress Controller

Install NGINX Ingress Controller to manage external application traffic.

Responsibilities:

- Expose microservices through a common entry point.
- Route HTTP requests based on URL paths.
- Configure host-based routing.
- Manage external access to Kubernetes Services.
- Support TLS termination when certificates are configured.

Example routing:

| Path | Microservice |
|---|---|
| `/users` | User Service |
| `/products` | Product Service |
| `/orders` | Order Service |
| `/payments` | Payment Service |

Example Ingress configuration:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: microservices-ingress
  namespace: microservices
spec:
  ingressClassName: nginx
  rules:
    - http:
        paths:
          - path: /users
            pathType: Prefix
            backend:
              service:
                name: user-service
                port:
                  number: 8000

          - path: /products
            pathType: Prefix
            backend:
              service:
                name: product-service
                port:
                  number: 8000

          - path: /orders
            pathType: Prefix
            backend:
              service:
                name: order-service
                port:
                  number: 8000

          - path: /payments
            pathType: Prefix
            backend:
              service:
                name: payment-service
                port:
                  number: 8000
```

### 7. Implement GitOps Using Argo CD

- Store Kubernetes manifests in a Git repository.
- Connect Argo CD to the GitOps repository.
- Configure Argo CD Applications.
- Synchronize desired application state with Amazon EKS.
- Monitor synchronization and deployment health.
- Detect and correct configuration drift when self-healing is enabled.

### 8. Monitor Using Prometheus and Grafana

- Collect Kubernetes cluster metrics.
- Monitor pod CPU and memory utilization.
- Monitor node resource consumption.
- Create Grafana dashboards.
- Use PromQL to investigate application and infrastructure metrics.
- Configure alerts using Alertmanager where required.

### 9. Centralized Logging Using EFK

- Collect container logs using Fluentd.
- Forward logs to Elasticsearch.
- Store and index application logs.
- Search and visualize logs using Kibana.
- Troubleshoot microservice failures and investigate application errors.

## 📂 Repository Structure

Suggested repository structure:

```text
python-microservices-eks/
│
├── services/
│   ├── user-service/
│   │   ├── app/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   └── Dockerfile
│   │
│   ├── product-service/
│   │   ├── app/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   └── Dockerfile
│   │
│   ├── order-service/
│   │   ├── app/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   └── Dockerfile
│   │
│   └── payment-service/
│       ├── app/
│       ├── main.py
│       ├── requirements.txt
│       └── Dockerfile
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── providers.tf
│
├── kubernetes/
│   ├── namespace.yaml
│   ├── user-deployment.yaml
│   ├── product-deployment.yaml
│   ├── order-deployment.yaml
│   ├── payment-deployment.yaml
│   ├── services.yaml
│   └── ingress.yaml
│
├── argocd/
│   └── application.yaml
│
├── monitoring/
│   └── prometheus-values.yaml
│
├── logging/
│   └── fluentd-values.yaml
│
├── .github/
│   └── workflows/
│       └── ci-cd.yml
│
├── images/
│   └── architecture.png
│
└── README.md
```

## ⚙️ Prerequisites

- AWS account with appropriate IAM permissions.
- AWS CLI.
- Terraform.
- Docker.
- Python 3.x.
- kubectl.
- Helm.
- Git and GitHub account.
- Amazon EKS cluster.
- Amazon ECR repositories.
- Argo CD.
- NGINX Ingress Controller.
- Prometheus and Grafana.
- Fluentd, Elasticsearch, and Kibana.

## 🚀 Getting Started

### Step 1: Clone Repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>

cd python-microservices-eks
```

### Step 2: Configure AWS

```bash
aws configure

aws sts get-caller-identity
```

### Step 3: Provision Infrastructure

```bash
cd terraform

terraform init
terraform validate
terraform plan
terraform apply
```

### Step 4: Build Python Applications

Install dependencies:

```bash
pip install -r requirements.txt
```

Run an individual FastAPI microservice:

```bash
uvicorn main:app --host 0.0.0.0 --port 8000
```

### Step 5: Build Docker Images

```bash
docker build -t user-service:latest ./services/user-service

docker build -t product-service:latest ./services/product-service

docker build -t order-service:latest ./services/order-service

docker build -t payment-service:latest ./services/payment-service
```

### Step 6: Connect to Amazon EKS

```bash
aws eks update-kubeconfig \
  --region <AWS_REGION> \
  --name <EKS_CLUSTER_NAME>
```

Verify:

```bash
kubectl get nodes
kubectl get namespaces
```

### Step 7: Install NGINX Ingress Controller

```bash
helm repo add ingress-nginx \
  https://kubernetes.github.io/ingress-nginx

helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace
```

Verify:

```bash
kubectl get pods -n ingress-nginx

kubectl get svc -n ingress-nginx
```

The controller Service can provision an AWS Load Balancer depending on the configured Service annotations and AWS load balancer integration.

### Step 8: Deploy Using Argo CD

Configure the Argo CD Application to point to the GitOps repository and Kubernetes manifest directory.

```bash
kubectl apply -f argocd/application.yaml
```

Check application status:

```bash
kubectl get applications -n argocd
```

### Step 9: Verify Microservices and Ingress

```bash
kubectl get pods -n microservices

kubectl get svc -n microservices

kubectl get ingress -n microservices
```

Check the Ingress Controller:

```bash
kubectl get svc -n ingress-nginx
```

### Step 10: Verify Monitoring and Logging

```bash
kubectl get pods -A

kubectl get svc -A
```

Access Prometheus, Grafana, and Kibana using their configured endpoints.

## 📊 Monitoring Examples

**CPU Usage by Pod**

```promql
sum by (pod) (
  rate(container_cpu_usage_seconds_total{
    container!="",
    pod!=""
  }[5m])
)
```

**Memory Usage by Pod**

```promql
sum by (pod) (
  container_memory_working_set_bytes{
    container!="",
    pod!=""
  }
)
```

**Kubernetes Ready Nodes**

```promql
kube_node_status_condition{
  condition="Ready",
  status="true"
}
```

## 🔍 Troubleshooting Commands

**Kubernetes Resources**

```bash
kubectl get pods -A
kubectl get deployments -A
kubectl get services -A
kubectl get ingress -A
```

**Application Logs**

```bash
kubectl logs <POD_NAME>

kubectl logs <POD_NAME> --previous
```

**Describe Pod**

```bash
kubectl describe pod <POD_NAME>
```

**NGINX Ingress Controller Logs**

```bash
kubectl logs -n ingress-nginx \
  deployment/ingress-nginx-controller
```

**Argo CD**

```bash
argocd app list

argocd app get <APPLICATION_NAME>

argocd app sync <APPLICATION_NAME>
```

## 🔐 Security Best Practices

- Use IAM roles with least-privilege permissions.
- Prefer GitHub Actions OIDC for AWS authentication.
- Store sensitive information in AWS Secrets Manager or Kubernetes Secrets with appropriate encryption and access controls.
- Never commit AWS credentials or passwords to GitHub.
- Restrict access to the Kubernetes API.
- Configure TLS for external application traffic.
- Use private subnets for worker nodes where appropriate.
- Scan Docker images for vulnerabilities.
- Enable encryption for Terraform state and sensitive data.

## 💡 Key DevOps Concepts Demonstrated

- Python Microservices Architecture.
- Infrastructure as Code using Terraform.
- Docker Containerization.
- Kubernetes Orchestration.
- Amazon EKS Cluster Management.
- Amazon ECR Image Management.
- CI/CD Automation using GitHub Actions.
- GitOps using Argo CD.
- NGINX Ingress Controller and Path-Based Routing.
- Monitoring using Prometheus and Grafana.
- Centralized Logging using EFK.
- Cloud Infrastructure Monitoring and Troubleshooting.

## 🔮 Future Improvements

- Implement API Gateway and authentication.
- Add automated unit and integration testing.
- Integrate SonarQube for code quality.
- Add Trivy for container image vulnerability scanning.
- Implement Horizontal Pod Autoscaling.
- Configure TLS using cert-manager.
- Implement Canary and Blue-Green Deployments.
- Add distributed tracing using OpenTelemetry.
- Configure Alertmanager notifications.
- Implement automated rollback and disaster recovery.

## 👨‍💻 Author

**Chandra Shekhar Saini**

Cloud & DevOps Engineer | AWS | Python | Kubernetes | Terraform | Docker | CI/CD | GitOps | Monitoring

- GitHub: https://github.com/ChandraShekharSaini
- Project Repository: Add your actual repository URL here.

## ⭐ Support

If you find this project useful for learning Cloud and DevOps, consider giving the repository a ⭐ on GitHub.

---

**Disclaimer:** This project is intended for learning and demonstration purposes. Review AWS security configurations, infrastructure costs, and Kubernetes resource settings before production deployment.
