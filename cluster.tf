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
