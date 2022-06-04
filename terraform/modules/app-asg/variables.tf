variable "region" {
  description = "The region to launch the instances"
  default     = "eu-west-1"
}

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
    eu-west-1 = "ami-0551bf2a5bb48bc5c"
  }
}

variable "vpc_zone_identifier" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}

