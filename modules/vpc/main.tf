resource "aws_vpc" "fc3-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}-vpc"
  }

}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets" {
  count                   = length(var.availability_zones)
  availability_zone       = var.availability_zones[count.index]
  vpc_id                  = aws_vpc.fc3-vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true # instances created in this subnet is assigned to an public ip
  tags = {
    Name = "${var.prefix}-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "fc3-igw" {
  vpc_id = aws_vpc.fc3-vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "fc3-rtb" {
  vpc_id = aws_vpc.fc3-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fc3-igw.id
  }
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table_association" "fc3-rtb-association" {
  count          = length(aws_subnet.subnets)
  route_table_id = aws_route_table.fc3-rtb.id
  subnet_id      = aws_subnet.subnets.*.id[count.index]

}
