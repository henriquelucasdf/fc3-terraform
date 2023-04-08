resource "aws_security_group" "fc3-sg" {
  vpc_id = aws_vpc.fc3-vpc.id
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.prefix}-sg"
  }
}

resource "aws_iam_role" "fc3-role" {
  name               = "${var.prefix}-${var.cluster_name}-role"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
    POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-EKSVPCResourceController" {
  role       = aws_iam_role.fc3-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy_attachment" "cluster-EKSClusterPolicy" {
  role       = aws_iam_role.fc3-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_cloudwatch_log_group" "fc3-log" {

  name              = "/aws/eks/${var.prefix}-${var.cluster_name}/cluster"
  retention_in_days = var.retention_days
}

resource "aws_eks_cluster" "fc3-cluster" {
  name                      = "${var.prefix}-${var.cluster_name}"
  role_arn                  = aws_iam_role.fc3-role.arn
  enabled_cluster_log_types = ["api", "audit"]

  vpc_config {
    subnet_ids         = aws_subnet.subnets[*].id
    security_group_ids = [aws_security_group.fc3-sg.id]
  }
  depends_on = [
    aws_cloudwatch_log_group.fc3-log,
    aws_iam_role_policy_attachment.cluster-EKSVPCResourceController,
    aws_iam_role_policy_attachment.cluster-EKSClusterPolicy
  ]
}
