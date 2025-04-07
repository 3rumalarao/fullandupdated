resource "aws_security_group" "this" {
  for_each = var.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = each.value.ingress[0].from_port
    to_port     = each.value.ingress[0].to_port
    protocol    = each.value.ingress[0].protocol
    cidr_blocks = each.value.ingress[0].cidr_blocks
  }

  dynamic "ingress" {
    for_each = slice(each.value.ingress, 1, length(each.value.ingress))
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = each.value.egress[0].from_port
    to_port     = each.value.egress[0].to_port
    protocol    = each.value.egress[0].protocol
    cidr_blocks = each.value.egress[0].cidr_blocks
  }

  dynamic "egress" {
    for_each = slice(each.value.egress, 1, length(each.value.egress))
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = each.value.name
  }
}
