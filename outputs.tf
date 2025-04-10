output "private_instance_ids" {
  value = module.private_ec2.instance_ids
}

output "private_instance_ips" {
  value = module.private_ec2.private_ips
}

output "public_instance_ids" {
  value = module.public_ec2.instance_ids
}

output "public_instance_ips" {
  value = module.public_ec2.public_ips
}

output "efs_id" {
  value = module.efs.efs_id
}

output "crm_lb_dns" {
  value = module.crm_lb.lb_dns
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "ssm_parameters" {
  value = module.ssm.ssm_parameters
}

output "backup_plan_id" {
  value = length(module.backup) > 0 ? module.backup[0].backup_plan_id : ""
}

output "sg_ids" {
  value = module.sg.sg_ids
}
