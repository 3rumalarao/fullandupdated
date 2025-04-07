output "ssm_parameters" {
  value = { for k, p in aws_ssm_parameter.this : k => p.value }
}
