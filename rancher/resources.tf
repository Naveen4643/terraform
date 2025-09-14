resource "aws_instance" "rancher" {
    count        = var.instance_count
    ami          = var.ami_id
    instance_type = var.instance_type
    key_name   = var.key_name
    vpc_security_group_ids = [aws_security_group.mysg.id]
    subnet_id     = element(data.aws_subnet_ids.default.ids, count.index % length(data.aws_subnet_ids.default.ids))

    tags = {
      Name = "rancher-server-${count.index + 1}"
    }
  
}

