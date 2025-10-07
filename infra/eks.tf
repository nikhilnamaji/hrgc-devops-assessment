module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster_name
  cluster_version = var.eks_version

  vpc_id = module.vpc.vpc_id

  create_iam_role                     = true
  attach_cluster_encryption_policy    = false

  cluster_endpoint_public_access      = true
  cluster_endpoint_private_access     = true

  control_plane_subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)

  create_cluster_security_group       = true
  cluster_security_group_description  = "EKS cluster security group"

  bootstrap_self_managed_addons       = true

  authentication_mode                 = "API"
  enable_cluster_creator_admin_permissions = true

  dataplane_wait_duration             = "40s"

  enable_security_groups_for_pods     = true

  create_cloudwatch_log_group         = false
  create_kms_key                      = false
  enable_kms_key_rotation             = false
  kms_key_enable_default_policy       = false
  enable_irsa                         = false
  cluster_encryption_config           = {}
  enable_auto_mode_custom_tags        = false

  create_node_security_group                  = true
  node_security_group_enable_recommended_rules = true
  node_security_group_description              = "EKS node group security group - used by nodes to communicate with the cluster API"
  node_security_group_use_name_prefix          = true

  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    group1 = {
      name           = "HRGC-node-group"
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}