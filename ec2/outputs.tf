output "instance_ids" {
  value = { for k, inst in aws_instance.this : k => inst.id }
}

output "private_ips" {
  value = { for k, inst in aws_instance.this : k => inst.private_ip }
}

output "public_ips" {
  value = var.is_public ? { for k, inst in aws_instance.this : k => aws_eip.this[k].public_ip } : {}
}
