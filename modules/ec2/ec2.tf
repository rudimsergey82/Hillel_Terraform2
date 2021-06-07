resource "aws_instance" "this" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  subnet_id              = var.vpc_subnets
  vpc_security_group_ids = [aws_security_group.this.id]
  tags                   = var.tags
}

resource "aws_key_pair" "this" {
  key_name   = "ssh-key"
  public_key = var.ssh_key
}

resource "aws_eip" "this" {
  count    = (var.eip_attach == true ? var.instance_count : 0)
  instance = element(aws_instance.this.*.id, count.index)
  vpc      = "true"
}

resource "aws_security_group" "this" {
  name   = "SSH"
  vpc_id = var.vpc_id
  tags   = var.tags

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "SSH" {
  description       = "Allow SSH from anywhere."
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_volume_attachment" "this" {
  count       = var.instance_count
  device_name = "/dev/sdh"
  volume_id   = element(aws_ebs_volume.this.*.id, count.index)
  instance_id = element(aws_instance.this.*.id, count.index)
}

resource "aws_ebs_volume" "this" {
  count             = var.instance_count
  availability_zone = element(aws_instance.this.*.availability_zone, count.index)
  size              = var.ebs_size
  type              = "gp2"
}