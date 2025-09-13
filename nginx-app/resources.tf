# Ec2 public instance
resource "aws_instance" "public-server" {
    ami                         = "ami-0360c520857e3138f"   # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami for us-east-1
    instance_type               = "t2.micro"
    subnet_id                   = aws_subnet.public-subnet-1.id
    vpc_security_group_ids      = [aws_security_group.mysg.id]
    key_name                    = "mykey"
    associate_public_ip_address = true
        user_data = <<EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    echo "<h1>Hello from Public Server</h1>" > /usr/share/nginx/html/index.html
    sudo systemctl start nginx 
    sudo systemctl enable nginx
    EOF

    tags = {
      Name = "public-server-A"
    }
}

# Ec2 private instance
resource "aws_instance" "private-server" {  
    ami                         = "ami-0360c520857e3138f"   # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami for us-east-1
    instance_type               = "t2.micro"
    subnet_id                   = aws_subnet.private-subnet-1.id
    vpc_security_group_ids      = [aws_security_group.mysg.id]
    key_name                    = "mykey"
    associate_public_ip_address = false
        user_data = <<EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    echo "<h1>Hello from Private Server </h1>" > /usr/share/nginx/html/index.html
    sudo systemctl start nginx 
    sudo systemctl enable nginx
    EOF

    tags = {
      Name = "private-server-A"
    }
}


#Applcation Load Balancer
resource "aws_lb" "app-lb" {
    name               = "app-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.mysg.id]
    subnets            = [aws_subnet.public-subnet-1.id]
    tags = {
      Name = "app-lb"
    }
}

#Target Group
resource "aws_lb_target_group" "app-tg" {
    name               = "app-tg" 
    port               = 80
    protocol           = "HTTP" 
    vpc_id             = aws_vpc.myvpc.id
    
}

#app group attachment
resource "aws_lb_target_group_attachment" "public-tg-attach" {
    target_group_arn = aws_lb_target_group.app-tg.arn
    target_id        = aws_instance.public-server.id
    port             = 80
}

#listener
resource "aws_lb_listener" "app-listener" { 
    load_balancer_arn = aws_lb.app-lb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.app-tg.arn
    }
}


# Outputs
output "vpc_id" {
    value = aws_vpc.myvpc.id
}

#output application load balancer DNS
output "alb_dns" {
    value = aws_lb.app-lb.dns_name
}   

