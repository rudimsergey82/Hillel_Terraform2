output "instance_ids" {
  value = module.ec2.*.instance_id
}

output "instance_pub_ip" {
  value = module.ec2.*.instance_pub_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_networks" {
  value = module.vpc.public_networks
}