resource "aws_iam_user_policy_attachment" "eks_cluster_policy" {
  user       = var.eks_admin_user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_user_policy_attachment" "eks_worker_policy" {
  user       = var.eks_admin_user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_user_policy_attachment" "eks_cni_policy" {
  user       = var.eks_admin_user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}