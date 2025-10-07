output "update_kubeconfig_command" {
  description = "Command to update kubeconfig manually if needed"
  value       = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks.cluster_name}"
}