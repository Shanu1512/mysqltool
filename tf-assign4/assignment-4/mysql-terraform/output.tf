output "mysql_primary_private_ip" {
  description = "Private IP of the primary MySQL instance"
  value       = aws_instance.mysql_a.private_ip
}

output "mysql_primary_public_ip" {
  description = "Public IP of the primary MySQL instance (if any)"
  value       = aws_instance.mysql_a.public_ip
}

output "mysql_replica_private_ip" {
  description = "Private IP of the replica MySQL instance"
  value       = aws_instance.mysql_b.private_ip
}

output "mysql_replica_public_ip" {
  description = "Public IP of the replica MySQL instance (if any)"
  value       = aws_instance.mysql_b.public_ip
}
