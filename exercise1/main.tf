provider "aws" {
  region = var.aws_region
  default_tags = {
    Environment = var.environment
    Owner = var.owner
    Project = var.project
  }
}

resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  tags = merge(
    var.default_tags,
    {
        Additional_tag = var.additional_tag
    }
  )

}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
    for_each = toset(local.azs_to_use) 
    availability_zone_id = each.value
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.cidr_block,4,each.key)
    tags = var.default_tags
}

resource "aws_subnet" "private" {
    for_each = toset(local.azs_to_use) 
    availability_zone_id = each.value
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.cidr_block,4,length(local.azs_to_use)+each.key)
    tags = var.default_tags
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
    tags = var.default_tags
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    tags = var.default_tags
}

resource "aws_route" "public_igw" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public" {   
    count = length(aws_subnet.public)
    subnet_id  = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "public" {
  subnet_id  = aws_subnet.public[0].id
  tags = var.default_tags
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = var.default_tags
}

resource "aws_route" "private_ngw" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.public.id
}

resource "aws_route_table_association" "private" {   
    count = length(aws_subnet.private)
    subnet_id  = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}

resource "aws_vpc_endpoint" "s3" {
    vpc_id       = aws_vpc.main.id
    service_name = "com.amazonaws.${var.aws_region}.s3"
    tags = var.default_tags
}











