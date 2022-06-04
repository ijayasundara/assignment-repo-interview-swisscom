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

# module mysql-db #

allocated_storage           = "5"
storage_type                = "gp2"
engine                      = "mysql"
engine_version              = "8.0.28"
instance_class              = "db.t2.micro"
db_name                     = "swisscomdb"
username                    = "swisscom_db_user"
password                    = "Dzaunk3cwxw"
parameter_group_name        = "default.mysql8.0"
allow_major_version_upgrade = false
auto_minor_version_upgrade  = true
backup_retention_period     = 35
backup_window               = "22:00-23:00"
maintenance_window          = "Sat:00:00-Sat:03:00"
multi_az                    = true
skip_final_snapshot         = true