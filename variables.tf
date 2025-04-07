variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "Environment tag (e.g. DEV, PROD)"
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
    ami           = string
    instance_type = string
    subnet_index  = number
    key_name      = string
  }))
}

variable "public_servers" {
  description = "Map of public server definitions"
  type = map(object({
    ami           = string
    instance_type = string
    subnet_index  = number
    key_name      = string
    allocate_eip  = bool
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
      ami           = string
      instance_type = string
      subnet_index  = number
      key_name      = string
      az            = string
    }))
    lb = object({
      name          = string
      type          = string
      scheme        = string
      listener_port = number
    })
  }))
}

# New variables for RDS module
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

variable "ssm_parameters" {
  description = "Map of SSM parameter definitions"
  type = map(object({
    name        = string
    description = string
    value       = string
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

# Common tags that can be applied to resources
variable "common_tags" {
  description = "Map of common tags"
  type        = map(string)
  default     = {}
}
