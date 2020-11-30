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