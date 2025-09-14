variable "k8s_port" {
    type = list(number)
    default = [6443, 2379, 2380, 10250, 10251, 10252]
}   

variable "ports" {
    type = list(number)
    default = [22, 80, 443]
  
}

variable "sg_name" {
    type    = string
    default = "k8s-sg"
}

variable "instance_type" {
    type    = string
    default = "t2.medium"
  
}

variable "instance_count" {
    type    = number
    default = 4 
  
}

variable "ami_id" {
    type    = string
    default = "ami-0c02fb55956c7d316" #ubuntu 20.04 LTS for us-east-1
}

variable "key_name" {
    type    = string
    default = "my-key"
}


