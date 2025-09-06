resource "aws_security_group" "mysg" {

  name       = "${terraform.workspace}-sg"
  description = "security group for ${terraform.workspace}"

  dynamic "ingress" {
    for_each = var.ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
variable "ports" {
  type    = list(any)
  default = [22, 3306, 8080, 8081, 9000]
}
