variable "aws_region" {
  description = "AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of your AWS key pair"
  type        = string
  default     = "wordpress-key"
}

variable "project_name" {
  description = "Name tag for all resources"
  type        = string
  default     = "wordpress-autodeploy"
}
