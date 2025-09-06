resource "aws_instance" "terf" {
tags = {
Name = "${terraform.workspace}-server"

}
ami = "ami-0360c520857e3138f"
instance_type = "t2.micro"
key_name = "nani"
count = 1
vpc_security_group_ids = [aws_security_group.mysg.id]

}

output "test" {
value = [aws_instance.terf[0].public_ip,aws_instance.terf[0].private_ip,aws_security_group.mysg.name,aws_instance.terf[0].tags["Name"]]
}
