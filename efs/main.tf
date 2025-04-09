resource "aws_efs_file_system" "this" {
  creation_token = var.name
  tags = merge(var.common_tags, {
    name        = var.name,
    environment = var.environment
  })
}

resource "aws_efs_mount_target" "this" {
  for_each = { for idx, target in var.mount_targets : "${var.name}-${idx}" => target }

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.private_subnets[each.value.subnet_index]
  security_groups = []  # Add SG IDs if required
}
