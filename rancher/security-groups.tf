resource "aws_security_group" "mysg" {
    name = var.sg_name
    description = "My sg for nginx application"

    dynamic "ingress" {
        for_each = var.ports
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "ingress" {
        for_each = var.k8s_port
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            security_groups = [aws_security_group.mysg.id]
        }
    }


    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 30000
        to_port         = 32767
        protocol        = "tcp"
        security_groups = [aws_security_group.mysg.id]
    }

}


