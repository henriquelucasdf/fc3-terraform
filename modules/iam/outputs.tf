output "cluster_role_arn" {
  value = aws_iam_role.cluster-role.arn
}

output "node_role_arn" {
  value = aws_iam_role.node-role.arn
}
