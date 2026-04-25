# ─────────────────────────────────────
# 1. GET LATEST UBUNTU 22.04 AMI
# ─────────────────────────────────────
# This automatically finds the latest
# Ubuntu 22.04 image so you never
# need to hardcode an AMI ID
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu's company)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ─────────────────────────────────────
# 2. SECURITY GROUP
# ─────────────────────────────────────
# Acts like a firewall — controls
# what traffic can reach your server
resource "aws_security_group" "wordpress" {
  name        = "${var.project_name}-sg"
  description = "Allow web and SSH traffic"

  # Allow SSH from anywhere (to let Ansible connect)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP web traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS web traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# ─────────────────────────────────────
# 3. EC2 INSTANCE
# ─────────────────────────────────────
# Your actual server that will
# run WordPress
resource "aws_instance" "wordpress" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.wordpress.id]

  # Disk size — 20GB is plenty for WordPress
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-server"
  }
}

# ─────────────────────────────────────
# 4. ELASTIC IP
# ─────────────────────────────────────
# Gives your server a permanent
# IP address that never changes
resource "aws_eip" "wordpress" {
  instance = aws_instance.wordpress.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }
}
