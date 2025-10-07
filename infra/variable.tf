variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "cidr_block" {
  type        = string
  default     = "10.10.0.0/16"
  description = "VPC CIDR block"
}

variable "vpc_name" {
  type        = string
  default     = "demo-eks-vpc"
  description = "VPC name"
}

variable "tags" {
  type        = map(string)
  default = {
    terraform  = "true"
    kubernetes = "nikhil-eks-cluster"
  }
  description = "Tags to apply to all resources"
}

variable "azs" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "Availability Zones"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
  description = "Private subnet CIDR blocks"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.10.101.0/24", "10.10.102.0/24"]
  description = "Public subnet CIDR blocks"
}

variable "eks_version" {
  type        = string
  default     = "1.31"
  description = "EKS version"
}

variable "cluster_name" {
  type        = string
  default     = "nikhil-eks-cluster"
  description = "Name of the EKS cluster"
}

variable "eks_admin_user_arn" {
  type        = string
  description = "IAM user ARN to be granted admin access to EKS cluster"
}

variable "eks_admin_user_name" {
  type        = string
  description = "Username to map to EKS cluster admin"
}

variable "eks_node_instance_type" {
  type        = string
  default     = "t3.medium"
  description = "EC2 instance type for EKS worker nodes"
}