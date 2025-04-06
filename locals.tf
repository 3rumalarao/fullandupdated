locals {
  private_subnet_map = { for idx, subnet in var.private_subnets : idx => subnet }
  public_subnet_map  = { for idx, subnet in var.public_subnets : idx => subnet }
}
