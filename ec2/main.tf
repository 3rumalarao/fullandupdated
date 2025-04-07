resource "aws_instance" "this" {
  for_each = var.instances

  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  subnet_id                   = var.is_public ? var.public_subnets[each.value.subnet_index] : var.private_subnets[each.value.subnet_index]
  associate_public_ip_address = var.is_public ? false : null

  tags = {
    Name = "${var.env}-${var.orgname}-${each.key}"
  }
}

# Allocate an EIP for public instances (vpc argument removed since it is deprecated)
resource "aws_eip" "this" {
  for_each = var.is_public ? var.instances : {}

  instance = aws_instance.this[each.key].id
}
