resource "aws_instance" "website_server" {
  ami           = "ami-028ba4d4ccb4b7b72" #Amazon Linux 2 AMI 
  instance_type = "t2.micro"
  key_name = "chave-site-prod-v2"
  vpc_security_group_ids = [aws_security_group.website_sg.id]
  iam_instance_profile = "ECR-EC2-Role"

  tags = {
    Name = "website_server"
    Provisioned = "Terraform"
  }
}

##Security Group
resource "aws_security_group" "website_sg" {
  name        = "website_sg"
  vpc_id      = "vpc-0b2df611681889b10"
  tags = {
    Name = "website_sg"
    Provisioned = "Terraform"
    Client = "Lev"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = "SEU_IP_AQUI/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.website_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

