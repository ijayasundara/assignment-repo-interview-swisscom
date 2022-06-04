resource "aws_db_subnet_group" "rds-private-subnet" {
  name = "rds-private-subnet-group"
  subnet_ids = var.vpc_private_subnet_ids
}

### Creating Security Group for EC2
resource "aws_security_group" "db" {
  name   = "swisscom-assignment-db-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "my_test_mysql" {
  allocated_storage           = 1
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "8.0.28"
  instance_class              = "db.t2.micro"
  db_name                     = "swisscomdb"
  username                    = "swisscom_db_user"
  password                    = "Dzaunk3cwxw"
  parameter_group_name        = "default.mysql8.0.28"
  db_subnet_group_name        = "${aws_db_subnet_group.rds-private-subnet.name}"
  vpc_security_group_ids      = ["${aws_security_group.db.id}"]
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = true
  skip_final_snapshot         = true
}