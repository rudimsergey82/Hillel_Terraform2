output "public_networks" {
  value = aws_subnet.public.*.id
}

output "vpc_id" {
  value = aws_vpc.this.id
}
