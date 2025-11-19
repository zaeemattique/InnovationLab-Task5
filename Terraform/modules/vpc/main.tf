resource "aws_vpc" "Task5-vpc-zaeem" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Task5-vpc-zaeem"
  }
}

resource "aws_subnet" "Task5-publicSNA-zaeem" {
  vpc_id            = aws_vpc.Task5-vpc-zaeem.id
  cidr_block        = var.subnet_cidr_A
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

    tags = {
        Name = "Task5-publicSNA-zaeem"
    }
}

resource "aws_subnet" "Task5-publicSNB-zaeem" {
  vpc_id            = aws_vpc.Task5-vpc-zaeem.id
  cidr_block        = var.subnet_cidr_B
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true

    tags = {
        Name = "Task5-publicSNB-zaeem"
    }
}

resource "aws_internet_gateway" "Task5-igw-zaeem" {
  vpc_id = aws_vpc.Task5-vpc-zaeem.id  

    tags = {
        Name = "Task5-igw-zaeem"
    }
}

resource "aws_route_table" "Task5-publicRT-zaeem" {
  vpc_id = aws_vpc.Task5-vpc-zaeem.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Task5-igw-zaeem.id
  }

  tags = {
    Name = "Task5-publicRT-zaeem"
  }
}

resource "aws_route_table_association" "Task5-publicRTA-A-zaeem" {
  subnet_id      = aws_subnet.Task5-publicSNA-zaeem.id
  route_table_id = aws_route_table.Task5-publicRT-zaeem.id
}

resource "aws_route_table_association" "Task5-publicRTA-B-zaeem" {
  subnet_id = aws_subnet.Task5-publicSNB-zaeem.id
  route_table_id = aws_route_table.Task5-publicRT-zaeem.id
}
