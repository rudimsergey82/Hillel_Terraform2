variable "instance_count" {
  type        = string
  default     = "1"
  description = "Number of EC2 instances to be created"
}

variable "ami" {
  type        = string
  description = "EC2 AMI"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of EC2 instance"
}

variable "ssh_key" {
  type        = string
  description = "SSH key"
}

variable "tags" {
  type = map(string)
}

variable "ebs_size" {
  default     = "1"
  description = "Additional EBS volume, GB"
}

variable "eip_attach" {
  type        = bool
  default     = false
  description = "Selector for ElasticIP: true == create and attach"
}

variable "vpc_subnets" {
  type = string
}

variable "vpc_id" {
  type = string
}