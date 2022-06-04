# AWS #
region      = "eu-west-1"
environment = "swisscom-assignment-environment"

# module networking #
vpc_cidr             = "20.0.0.0/16"
public_subnets_cidr  = ["20.0.2.0/24"]
private_subnets_cidr = ["20.0.20.0/24", "20.0.21.0/24"]

# module app-asg #
public_key_path = "/home/ishara/.ssh/swisscom-assignment-key.pem"
key_name        = "swisscom-assignment-key"
amis            = "ami-0551bf2a5bb48bc5c"