output "rds_arn" {
  description = "The arn of the RDS instance"
  value       = aws_db_instance.swisscomdb.arn
}

output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.swisscomdb.address
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.swisscomdb.port
}

output "rds_username" {
  description = "RDS instances root username"
  value       = aws_db_instance.swisscomdb.username
}