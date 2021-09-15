provider "aws" {
  region     = "us-east-1"
  profile    = "terraform"
}

resource "aws_instance" "instance-1" {
  ami           = "ami-00395b56cb6891346"
  instance_type = "t2.nano"
}

resource "aws_eip" "eip" {
  instance = "${aws_instance.instance-1.id}"
}

resource "aws_instance" "instance-2" {
  ami           = "ami-04169656fea786776"
  instance_type = "t2.nano"
}

//In order to create a graph image: terraform graph | dot -Tpng > graph.png