#######Create instances for ansible trainings
#######KDA 07.04.2021

provider "aws" {}

resource "aws_instance" "Ansible_training_amzn" {
  ami                                  = data.aws_ami.latest_amazon_linux.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t3.micro"
  count                                = 1
  vpc_security_group_ids               = [aws_security_group.Ansible_training.id]
  key_name                             = "crazyozzy-key-Stockholm"
  tags = {
    Name = "Ansible_training_amzn"
  }
}

resource "aws_instance" "Ansible_training_ubnt" {
  ami                                  = data.aws_ami.latest_ubuntu.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t3.micro"
  count                                = 1
  vpc_security_group_ids               = [aws_security_group.Ansible_training.id]
  key_name                             = "crazyozzy-key-Stockholm"
  tags = {
    Name = "Ansible_training_ubnt"
  }
}

resource "aws_security_group" "Ansible_training" {
  name = "Ansible_training"

  dynamic "ingress" {
    for_each = ["22", "80"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
