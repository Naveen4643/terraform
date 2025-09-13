variable "sg_name" {
    description = "Security Group Name"
    type        = string
    default     = "my-sg"

}

variable "vpc_name" {
    description = "VPC Name"
    type        = string
    default     = "my-vpc"
}

variable "ports" {
    description = "values for ingress rules"
    type        = list(any)
    default     = [ 22, 80, 8080 ]
}

variable "public_subnet_1_name" {
  description = "value for public subnet 1 name"
  type        = string  
  default     = "public-subnet-1"  
}

variable "public_subnet_1_cidr" {
  description = "value for public subnet 1 cidr"
  type        = string  
  default     = "10.0.0.0/24"
  
}

variable "private_subnet_1_name" {
  description = "value for private subnet 1 name"
  type        = string  
  default     = "private-subnet-1"  
  
}

variable "private_subnet_1_cidr" {
  description = "value for private subnet 1 cidr"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vpc_cidr" {
    description = "VPC CIDR Block"
    type        = string
    default     = "10.0.0.0/16"
}