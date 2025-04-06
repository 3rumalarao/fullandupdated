resource "aws_efs_file_system" "this" {
  creation_token = var.name
  tags = {
    Name = var.name
  }
}

resource "aws_efs_mount_target" "this" {
  for_each = { for idx, target in var.mount_targets : "${var.name}-${idx}" => target }

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.private_subnets[each.value.subnet_index]
  security_groups = [var.sg_id]
}
