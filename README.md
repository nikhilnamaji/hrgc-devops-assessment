# HRGF DevOps Assessment

Automated EKS Deployment with Terraform & CI/CD

This repository demonstrates a fully automated Kubernetes deployment on AWS EKS using Terraform, Docker, Helm, and GitHub Actions. It provisions the infrastructure, builds the Docker image, deploys the application, and sets up monitoring with Prometheus & Grafana.

---

## 📌 Prerequisites

Before starting, make sure you have the following installed and configured:

- **AWS CLI** – configured using `aws configure`
- **Docker** – installed and running
- **Terraform** – installed
- **IAM User** – Terraform will prompt for IAM User ARN and Username during `terraform plan/apply`
- **GitHub Account** – to set repository secrets

---

## 📌 Project Structure

.
├── app/
│ ├── app.py
│ └── requirements.txt
├── helm/
│ └── hello-app/
├── infra/
│ ├── aws_auth.tf
│ ├── iam_policies.tf
│ ├── kubectl_config.tf
│ ├── eks_module.tf
│ ├── vpc.tf
│ ├── providers.tf
│ ├── variables.tf
│ └── outputs.tf
└── .github/workflows/
└── ci-cd-pipeline.yml

yaml
Copy code

---

## 📌 GitHub Actions Secrets

Before running the pipeline, add the following **secrets and variables** in your repository:

| Name                  | Description                          |
|-----------------------|--------------------------------------|
| AWS_ACCESS_KEY_ID      | Your AWS access key ID               |
| AWS_SECRET_ACCESS_KEY  | Your AWS secret access key           |
| AWS_REGION             | AWS region (e.g., eu-west-1)        |
| DOCKER_USERNAME        | Docker Hub username                  |
| DOCKER_PASSWORD        | Docker Hub password                  |
| EKS_CLUSTER_NAME       | Name of the EKS cluster to create    |

> Settings → Secrets and Variables → Actions → New repository secret

---

## 📌 Deployment Steps

### 1️⃣ Clone the repository

git clone https://github.com/<your-username>/hrgc-devops-assessment.git
cd hrgc-devops-assessment/infra
2️⃣ Initialize Terraform

terraform init

3️⃣ Validate Terraform configuration

terraform validate
4️⃣ Plan Terraform changes

terraform plan

Terraform will prompt for IAM User ARN and IAM Username:

Example IAM User ARN:

arn:aws:iam::123456789012:user/xyz 

Example IAM Username:

XYZ

5️⃣ Apply Terraform changes


terraform apply

Terraform will provision:

VPC with public and private subnets

EKS cluster

Managed node group

IAM roles and policies

Kubernetes aws-auth ConfigMap

📌 CI/CD Pipeline

Once the cluster is provisioned, the GitHub Actions pipeline will automatically:

Build the Docker image from app/Dockerfile

Push the image to Docker Hub

Deploy the application to EKS using Helm (helm upgrade --install)

Scan Docker image for vulnerabilities using Trivy

Set up monitoring with Prometheus & Grafana

Pipeline triggers on push to the main branch.

📌 Verification

After successful deployment:

Update kubeconfig:

aws eks --region <AWS_REGION> update-kubeconfig --name <EKS_CLUSTER_NAME>

Check cluster nodes:


kubectl get nodes

Check services and note the LoadBalancer EXTERNAL-IP:


kubectl get svc

Open the EXTERNAL-IP in your browser to see the application JSON response.

📌 Helm & Monitoring

Prometheus and Grafana are installed using the kube-prometheus-stack Helm chart.

Grafana is exposed via LoadBalancer, accessible through the EXTERNAL-IP of the Grafana service.

Retrieve Grafana admin password:


kubectl --namespace monitoring get secret prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo

📌 Notes


Make sure GitHub Actions secrets are correctly configured before pushing any changes to main
