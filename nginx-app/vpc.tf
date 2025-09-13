# VPC 
resource "aws_vpc" "myvpc" {
    tags = {
        Name    = var.vpc_name 
    }
    cidr_block  = var.vpc_cidr
}