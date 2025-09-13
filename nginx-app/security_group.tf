#Security Group
resource "aws_security_group" "mysg" {
    name          = var.sg_name
    description   = "My sg for nginx application"
    vpc_id        = aws_vpc.myvpc.id

    dynamic "ingress" {
        for_each = var.ports
        content {
            from_port   = ingress.value.from_port
            to_port     = ingress.value.to_port
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]

        }
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}