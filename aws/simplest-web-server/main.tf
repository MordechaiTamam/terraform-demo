provider "aws" {
  region = "us-east-1"
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
  user_data     = <<-EOF
                  #!/bin/bash
                  sudo su
                  yum -y install httpd
                  echo "<p> My Instance! </p>" >> /var/www/html/index.html
                  chmod 777 /var/www/html/index.html
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  EOF
}

resource "local_file" "ip" {
    content  = aws_instance.myInstance.public_ip
    filename = "ip.yml"
}

output "DNS" {
  value = aws_instance.myInstance.public_dns
}