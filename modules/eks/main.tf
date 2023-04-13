resource "aws_cloudwatch_log_group" "fc3-log" {

  name              = "/aws/eks/${var.prefix}-${var.cluster_name}/cluster"
  retention_in_days = var.retention_days
}

resource "aws_eks_cluster" "fc3-cluster" {
  name                      = "${var.prefix}-${var.cluster_name}"
  role_arn                  = var.cluster_role_arn
  enabled_cluster_log_types = ["api", "audit"]

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

}

resource "aws_eks_node_group" "node-1" {
  cluster_name    = aws_eks_cluster.fc3-cluster.name
  node_group_name = "node-1"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = ["t3.micro"]

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }
}
