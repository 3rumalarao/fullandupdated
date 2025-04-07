module "sg" {
  source          = "./modules/sg"
  security_groups = var.security_groups
  vpc_id          = var.vpc_id
}

module "private_ec2" {
  source          = "./modules/ec2"
  instances       = var.private_servers
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  is_public       = false
  env             = var.env
  orgname         = var.orgname
}

module "public_ec2" {
  source          = "./modules/ec2"
  instances       = var.public_servers
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  is_public       = true
  env             = var.env
  orgname         = var.orgname
}

module "efs" {
  source          = "./modules/efs"
  name            = var.efs.name
  mount_targets   = var.efs.mount_targets
  private_subnets = var.private_subnets
  environment     = var.env
  vpc_id          = var.vpc_id
  common_tags     = var.common_tags
}

module "crm_lb" {
  source     = "./modules/loadbalancer"
  lb         = var.application_servers.crm.lb
  subnet_ids = var.private_subnets
  vpc_id     = var.vpc_id
  sg_id      = module.sg.sg_ids["CRM-LB"]  # Assuming a security group defined with key "CRM-LB" exists in your security_groups variable.
}

module "rds" {
  source           = "./modules/rds"
  rds_config       = var.rds_config
  privates_subnets = var.private_subnets
  environment      = var.env
  db_username      = var.db_username
  db_password      = var.db_password
  common_tags      = var.common_tags
}

module "ssm" {
  source         = "./modules/ssm"
  ssm_parameters = var.ssm_parameters
}

# Backup module is created only for production.
module "backup" {
  source         = "./modules/backup"
  count          = var.env == "PROD" ? 1 : 0
  backup_policy  = var.backup_policy
  # Supply the list of resource ARNs to backup; for example, you can aggregate outputs from the EC2 modules.
  resource_arns  = [] 
}
