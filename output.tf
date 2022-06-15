output "VPC"{
    value = aws_vpc.VPC.id
}

output "Public_Subnet" {
  value = aws_subnet.Public_subnet.id
}

output "Internet_GW_IP"{
    value = aws_internet_gateway.internet_GW.id
}