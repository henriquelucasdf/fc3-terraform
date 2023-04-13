module "fc3-vpc" {
  source             = "./modules/vpc"
  prefix             = var.prefix
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "fc3-iam" {
  source            = "./modules/iam"
  cluster_role_name = "${var.prefix}-${var.cluster_name}-cluster-role"
  node_role_name    = "${var.prefix}-${var.cluster_name}-node-role"

  depends_on = [
    module.fc3-vpc
  ]
}


module "fc3-eks" {
  source             = "./modules/eks"
  prefix             = var.prefix
  vpc_id             = module.fc3-vpc.vpc_id
  cluster_name       = var.cluster_name
  retention_days     = var.retention_days
  cluster_role_arn   = module.fc3-iam.cluster_role_arn
  node_role_arn      = module.fc3-iam.node_role_arn
  subnet_ids         = module.fc3-vpc.subnet_ids
  security_group_ids = [module.fc3-vpc.security_group_id]
  desired_size       = var.eks_desired_size
  min_size           = var.eks_min_size
  max_size           = var.eks_max_size

  depends_on = [
    module.fc3-iam
  ]
}
