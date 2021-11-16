provider "aws" {
  region = "us-east-1"
}
data "http" "myip"{
    url = "https://ipv4.icanhazip.com"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
        # TCP (change to whatever ports you need)
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        # Please restrict your ingress to only necessary IPs and ports.
        # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
        cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
      }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20210813.1-x86_64-gp2"]
  }
}

resource "aws_instance" "myInstance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name = "ubuntu-devops-experts"
  security_groups = ["${aws_security_group.allow_tls.name}"]
  tags = {
    key ="my key"
  }
}

resource "local_file" "ip" {
    content  = <<-EOT
    [web-servers]
    ${aws_instance.myInstance.public_ip} ansible_ssh_user=ec2-user
    EOT
    filename = "ip.yml"
}

output "DNS" {
  value = aws_instance.myInstance.public_dns
}