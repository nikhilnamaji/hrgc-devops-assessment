# hrgc-devops-assessment
# Automated EKS Deployment with Terraform & CI/CD

This repository demonstrates a fully automated Kubernetes deployment on AWS EKS using Terraform, Docker, Helm, and GitHub Actions. It provisions the infrastructure, builds the Docker image, deploys the application, and sets up monitoring with Prometheus & Grafana.

---

## 📌 Prerequisites

Before starting, make sure you have the following installed and configured:

- **AWS CLI** – configured using `aws configure`
- **Docker** – installed and running
- **Terraform** – installed
- **IAM User ARN and Username** – Terraform will prompt for these during `terraform init`

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
│ ├── outputs.tf
└── .github/workflows/
└── ci-cd-pipeline.yml

yaml
Copy code

---

## 📌 Deployment Steps

1. **Initialize Terraform**  
   Run the following command and enter your IAM User ARN and IAM Username when prompted:
   ```bash
   terraform init
Validate Terraform configuration

bash
Copy code
terraform validate
Plan Terraform changes

bash
Copy code
terraform plan
Apply Terraform changes

bash
Copy code
terraform apply
Terraform will prompt for your IAM User ARN and IAM Username. After confirmation, it will provision:

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

Pipeline triggers on push to main branch.

📌 Verification
After successful deployment:

Update kubeconfig (if needed):

bash
Copy code
aws eks --region <your-region> update-kubeconfig --name <cluster-name>
Check cluster nodes:

bash
Copy code
kubectl get nodes
Check services and note the LoadBalancer EXTERNAL-IP:

bash
Copy code
kubectl get svc
Open the EXTERNAL-IP in your browser to see the application JSON response.

## 📌 Helm & Monitoring

- Prometheus and Grafana are installed using the `kube-prometheus-stack` Helm chart.
- Grafana is exposed via **LoadBalancer**, so you can access it directly in your browser using the **EXTERNAL-IP** of the Grafana service.
- Retrieve Grafana admin password:
   ```bash
   kubectl --namespace monitoring get secret prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo
