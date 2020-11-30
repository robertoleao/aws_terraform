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