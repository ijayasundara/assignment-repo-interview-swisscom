resource "random_id" "random_id_prefix" {
  byte_length = 2
}

# Variables used across all modules #
locals {
  production_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

# Variables used in networking module #
module "networking" {
  source = "./modules/networking"

  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.production_availability_zones
}

# Variables used in bastion server #

module "bastion-server" {
  source = "./modules/bastion-server"

  region    = var.region
  vpc_id    = module.networking.vpc_id
  key_name  = var.key_name
  subnet_id = module.networking.public_subnet_id
}


# Variables used in app-asg module #
module "app-asg" {
  source = "./modules/app-asg"

  region              = var.region
  public_key_path     = var.public_key_path
  key_name            = var.key_name
  vpc_zone_identifier = module.networking.public_subnets_id
  vpc_id              = module.networking.vpc_id
}

# Variables used in mysql-db module #
module "mysql-db" {
  source = "./modules/mysql-db"

  region                      = var.region
  vpc_private_subnet_ids      = module.networking.private_subnets_id
  vpc_id                      = module.networking.vpc_id
  allocated_storage           = var.allocated_storage
  storage_type                = var.storage_type
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  db_name                     = var.db_name
  username                    = var.username
  password                    = var.password
  parameter_group_name        = var.parameter_group_name
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  backup_retention_period     = var.backup_retention_period
  backup_window               = var.backup_window
  maintenance_window          = var.maintenance_window
  multi_az                    = var.multi_az
  skip_final_snapshot         = var.skip_final_snapshot
}