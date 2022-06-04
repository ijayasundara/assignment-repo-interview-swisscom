# Global variables #
variable "region" {
  description = "us-east-1"
}

variable "environment" {
  description = "The Deployment environment"
}

# Networking module vars #
variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the private subnet"
}

# app-asg module vars #
variable "public_key_path" {
  description = "Enter the path to the SSH Public Key to add to AWS."
  default     = "/path_to_keyfile/keypair_name.pem"
}

variable "key_name" {
  description = "Key name for SSHing into EC2"
  default     = "kaypair_name"
}

variable "amis" {
  description = "Base AMI to launch the instances"
  default = {
    ap-south-1 = "ami-8da8d2e2"
  }
}
# mysql-db module vars #
variable "allocated_storage" {
  description = "Allocated storage in GB"
  default     = "5"
}

variable "storage_type" {
  description = "Storage type"
  default     = "gp2"
}

variable "engine" {
  description = "RDS instance DB type"
  default     = "mysql"
}

variable "engine_version" {
  description = "RDS instance DB varsion"
  default     = "8.0.28"
}

variable "instance_class" {
  description = "RDS instance Class"
  default     = "db.t2.micro"
}

variable "db_name" {
  description = "Database name"
  default     = "swisscomdb"
}

variable "username" {
  description = "Database username"
  default     = "swisscom_db_user"
}

variable "password" {
  description = "Database Password"
  default     = "Abc123"
}

variable "parameter_group_name" {
  description = "RDS parameter group name"
  default     = "default.mysql8.0"
}

variable "allow_major_version_upgrade" {
  description = "Major version auto upgrade"
  default     = "false"
}

variable "auto_minor_version_upgrade" {
  description = "Minor version auto upgrade"
  default     = "true"
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  default     = "35"
}

variable "backup_window" {
  description = "Backup window"
  default     = "22:00-23:00"
}

variable "maintenance_window" {
  description = "Maintenance window"
  default     = "Sat:00:00-Sat:03:00"
}

variable "multi_az" {
  description = "Multi availability zone supported"
  default     = "true"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when delete the database"
  default     = "true"
}
