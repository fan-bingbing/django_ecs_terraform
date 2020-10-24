variable "region" {
  description = "The AWS region to create resources in."
  default     = "ap-southeast-2"
}

# networking

variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b"]
}

# load balancer

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/ping/"
}



# logs

variable "log_retention_in_days" {
  default = 30
}

# key pair

variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "mykey.pub"
}

# ecs

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "production"
}
variable "amis" {
  description = "Which AMI to spawn."
  default = {
    ap-southeast-2 = "ami-040bd2e2325535b3d"
  }
}
variable "instance_type" {
  default = "t2.micro"
}
variable "docker_image_url_django" {
  description = "Docker image to run in the ECS cluster"
  default     = "<your-aws-account-number>.dkr.ecr.ap-southeast-2.amazonaws.com/django-app:latest"
}
variable "docker_image_url_nginx" {
  description = "Docker image to run in the ECS cluster"
  default     = "<your-aws-account-number>.dkr.ecr.ap-southeast-2.amazonaws.com/nginx:latest"
}
variable "app_count" {
  description = "Number of Docker containers to run"
  default     = 2
}

# auto scaling

variable "autoscale_min" {
  description = "Minimum autoscale (number of EC2)"
  default     = "1"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EC2)"
  default     = "10"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EC2)"
  default     = "2"
}

# rds

variable "rds_db_name" {
  description = "RDS database name"
  default     = "mydb"
}
variable "rds_username" {
  description = "RDS database username"
  default     = "foo"
}
variable "rds_password" {
  description = "RDS database password"
  default     = "foo"
  
}
variable "rds_instance_class" {
  description = "RDS instance type"
  default     = "db.t2.micro"
}

# email

variable "email_name" {
  description = "email server address"
  default     = "***"
}
variable "email_pw" {
  description = "email server pw"
  default     = "***"
  
}

# route53
variable "certificate_arn" {
  description = "AWS Certificate Manager ARN"
  default     = "***"

}
