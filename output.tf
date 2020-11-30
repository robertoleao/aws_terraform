output "master_1" {
 value =  aws_instance.master_1.public_ip
}

output "master_2" {
  value = aws_instance.master_2.public_ip
}

output "note_1" {
  value = aws_instance.note_1.public_ip
}