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