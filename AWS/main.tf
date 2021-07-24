terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        #Ubuntu 20: "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
        #Ubuntu 18: "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
        #Ubuntu 16: "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}
resource "aws_instance" "vpn" {
  ami           = data.aws_ami.ubuntu.id   #Use the latest instance
  #t2.nano = .5GB ram
  #t2.micro = 1GB ram
  #t3.small = 2 cpu 2GB ram
  instance_type = "t2.nano"
  vpc_security_group_ids = ["${var.SECURITYGROUP}"]   #Enter Security group IDs here
  key_name = aws_key_pair.deployer.key_name                   #Key must already be on aws. Enter key name here
  tags = {
        Name = "XX"
        Purpose = "XX"
    }
}