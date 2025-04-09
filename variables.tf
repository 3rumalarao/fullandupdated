variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "Environment tag (e.g. dev, prod)"
  type        = string
}

variable "orgname" {
  description = "Organization name"
  type        = string
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_servers" {
  description = "Map of private server definitions"
  type = map(object({
    ami             = string
    instance_type   = string
    subnet_index    = number
    key_name        = string
    security_groups = list(string)  # Security groups to attach to the instance.
  }))
}

variable "public_servers" {
  description = "Map of public server definitions"
  type = map(object({
    ami             = string
    instance_type   = string
    subnet_index    = number
    key_name        = string
    allocate_eip    = bool
    security_groups = list(string)
  }))
}

variable "efs" {
  description = "EFS configuration"
  type = object({
    name          = string
    mount_targets = list(object({
      az           = string
      subnet_index = number
    }))
  })
}

variable "application_servers" {
  description = "Map of application server configurations"
  type = map(object({
    instances = map(object({
      ami             = string
      instance_type   = string
      subnet_index    = number
      key_name        = string
      az              = string
      security_groups = list(string)
    }))
    lb = object({
      name             = string
      type             = string
      scheme           = string
      listener_port    = number
      security_groups  = list(string)   # LB-specific SGs.
    })
  }))
}

# RDS details
variable "rds_config" {
  description = "RDS configuration details"
  type = object({
    name           = string
    instance_class = string
    engine         = string
    storage        = number
  })
}

variable "db_username" {
  description = "Database username for RDS"
  type        = string
}

variable "db_password" {
  description = "Database password for RDS"
  type        = string
}

# RDS security group (this is created via the SG module).
variable "rds_sg" {
  description = "Security group ID for the RDS instance"
  type        = string
}

variable "ssm_parameters" {
  description = "Map of SSM parameter definitions"
  type = map(object({
    name        = string
    description = string
    value       = any
    type        = string
  }))
}

variable "backup_policy" {
  description = "Backup policy configuration for production resources"
  type = object({
    retention_days      = number
    resource_tag_filter = string
  })
}

# Required common tags for all resources (as mandated by the organization)
variable "common_tags" {
  description = "Map of common tags required by organization"
  type        = map(string)
  default = {
    OWEnvironment         = "dev"         # Adjust accordingly, e.g. "prod" in production.
    OWComanyCode          = "sap"
    OWCostCenter          = "1000"
    OWResourceName        = "ReplaceName" # This will be overridden per resource.
    OWBusinessApplication = "php-app"
    OWRegion              = "us-east-1"
  }
}

# Security groups for resources. These definitions can be placed in a separate tfvars file if desired.
variable "security_groups" {
  description = "Map of security group definitions"
  type = map(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress      = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
  default = {}
}
