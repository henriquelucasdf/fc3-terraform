output "vpc_id" {
  value = aws_vpc.fc3-vpc.id
}

output "subnet_ids" {
  value = aws_subnet.subnets[*].id
}

output "security_group_id" {
  value = aws_security_group.fc3-sg.id
}
