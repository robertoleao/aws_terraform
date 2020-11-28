resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.My_VPC.id

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "k8s-master" {
  name        = "k8s-master"
  description = "Trafego entre os k8s-master"
  vpc_id      = aws_vpc.My_VPC.id

  ingress {
    description = "Kubernetes API server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.My_VPC_Subnet.cidr_block]
  }
  
  ingress {
    description = "etcd server client API"
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.My_VPC_Subnet.cidr_block]
  }

  ingress {
    description = "Kubelet API - schedule - manager"
    from_port   = 10250
    to_port     = 10252
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.My_VPC_Subnet.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-master"
  }
}

resource "aws_security_group" "k8s-worker" {
  name        = "k8s-worker"
  description = "Trafego entre os k8s-worker"
  vpc_id      = aws_vpc.My_VPC.id

  ingress {
    description = "Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.My_VPC_Subnet.cidr_block]
  }

ingress {
    description = "NodePort Services"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.My_VPC_Subnet.cidr_block]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-worker"
  }
}