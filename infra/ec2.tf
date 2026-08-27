# EC2 instance that hosts the website
resource "aws_instance" "website_server" {
  ami                    = "ami-028ba4d4ccb4b7b72" # Amazon Linux 2023 AMI
  instance_type          = "t2.micro"
  key_name               = "web-app-key"
  vpc_security_group_ids = [aws_security_group.website_sg.id]
  iam_instance_profile   = "ECR-EC2-Role"         # Lets the instance pull images from ECR
  user_data              = file("user_data.sh")   # Installs Docker on first boot

  tags = {
    Name        = "website_server"
    Provisioned = "Terraform"
  }
}

# Security group: controls inbound/outbound traffic for the instance
resource "aws_security_group" "website_sg" {
  name   = "website_sg"
  vpc_id = "vpc-0b2df611681889b10"

  tags = {
    Name        = "website_sg"
    Provisioned = "Terraform"
  }
}

# Allows SSH (port 22), restricted to the IP defined in var.admin_ip
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4          = var.admin_ip
  from_port          = 22
  ip_protocol        = "tcp"
  to_port            = 22
}

# Allows HTTP (port 80) from anywhere, so the website is publicly reachable
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4          = "0.0.0.0/0"
  from_port          = 80
  ip_protocol        = "tcp"
  to_port            = 80
}

# Allows HTTPS (port 443) from anywhere
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4          = "0.0.0.0/0"
  from_port          = 443
  ip_protocol        = "tcp"
  to_port            = 443
}

# Allows all outbound traffic (needed to reach ECR, package repos, etc.)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4          = "0.0.0.0/0"
  ip_protocol        = -1
}