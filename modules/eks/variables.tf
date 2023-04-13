variable "prefix" {}
variable "vpc_id" {}
variable "cluster_name" {}
variable "retention_days" {}
variable "cluster_role_arn" {}
variable "node_role_arn" {}
variable "subnet_ids" {}
variable "desired_size" {}
variable "min_size" {}
variable "max_size" {}
variable "security_group_ids" {
  type = list(string)
}
