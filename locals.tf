locals {
  private_subnet_map = { for idx, subnet in var.private_subnets : idx => subnet }
  public_subnet_map  = { for idx, subnet in var.public_subnets : idx => subnet }

  # Compute the JSON for SSM parameter "app_env". Adjust module outputs
  computed_app_env = jsonencode({
    MYSQL_IP         = module.private_ec2.private_ips["mysql"]         // Ensure the "mysql" key exists in your private_servers map.
    POSTGRES_IP      = module.private_ec2.private_ips["postgresql"]    // Ensure the "postgresql" key exists.
    CRM_LB_DNS       = module.crm_lb.lb_dns
    CLOVER_LB_DNS    = module.clover_lb.lb_dns                          // Assume you create a module for "clover" LB if needed.
    LDAPHAPROXY_NLB  = module.ldaphaproxy_lb.lb_dns                     // Assume similar naming for this LB.
  })
}
