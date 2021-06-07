output "instance_id" {
  value = aws_instance.this.*.id
}

output "instance_pub_ip" {
  value = concat(aws_eip.this.*.public_ip, aws_instance.this.*.public_ip, [""])
}