#Create the VPC
resource "aws_vpc" "VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "AWS_VPC"
  }
}

#Creates teh subnet
resource "aws_subnet" "Public_subnet" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "Public_subnet"
  }
}

#Creates the internet gateway for outbound trafic 
resource "aws_internet_gateway" "internet_GW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "Internet Gateway for public_subnet"
  }
}

#Create route for the public subnet association with the GW
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_GW.id
  }
  tags = {
      Name = "Public route table"
  }
}

# Explicitly associate the newly created route tables to the public subnets so it does not use the default one 
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.Public_subnet.id
  route_table_id = aws_route_table.route_table.id
}