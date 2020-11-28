terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "sounit"
  region  = "us-east-1"
}
# Guarda o nome da chave para criar na aws
variable "key_name" {}
#
resource "tls_private_key" "key-auto" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Gera a chave usando a variavel de key_name
resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.key-auto.public_key_openssh}"
}
# Busca as informação da chave para criar o arquivo "chmod 400 key_name.pem"
resource "null_resource" "get_keys" {
  provisioner "local-exec" {
    command     = "echo '${tls_private_key.key-auto.private_key_pem}' > ~/.ssh/private_key.pem"
  }
}
# Primeira instancia 
resource "aws_instance" "master_1" {
  ami           = var.ec2image
  instance_type = "t2.medium"
  #instance_count = 5 numero de instancia
  subnet_id     = aws_subnet.My_VPC_Subnet.id
  vpc_security_group_ids = [ aws_security_group.k8s-master.id ,  aws_security_group.k8s-worker.id ,  aws_security_group.allow_ssh.id ]  # Tive problema nessa linha por causa do [].
  key_name      = "${aws_key_pair.generated_key.key_name}"
  tags          = {
    Name = "orcherstration_kubernetes_1"
    }
  }
# Segunda instancia
  resource "aws_instance" "master_2" {
  ami           = var.ec2image
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.My_VPC_Subnet.id
  vpc_security_group_ids = [ aws_security_group.k8s-master.id ,  aws_security_group.k8s-worker.id ,  aws_security_group.allow_ssh.id ]
  key_name      = "${aws_key_pair.generated_key.key_name}"
  tags          = {
    Name = "orcherstration_kubernetes_2"
    }
  }
# Terceira instancia
  resource "aws_instance" "note_1" {
  ami           = var.ec2image
  instance_type = "t2.small"
  subnet_id     = aws_subnet.My_VPC_Subnet.id
  vpc_security_group_ids = [ aws_security_group.k8s-master.id ,  aws_security_group.k8s-worker.id ,  aws_security_group.allow_ssh.id ]
  key_name      = "${aws_key_pair.generated_key.key_name}"
  tags          = {
    Name = "Node_1"
    }
  }
