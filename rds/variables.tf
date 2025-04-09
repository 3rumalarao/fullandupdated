variable "rds_config" {
  description = "RDS configuration details"
  type = object({
    name           = string
    instance_class = string
    engine         = string
    storage        = number
  })
}

variable "privates_subnets" {
  description = "List of private subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "environment" {
  description = "Environment tag"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "common_tags" {
  description = "Common tags for RDS resources"
  type        = map(string)
}

variable "rds_sg" {
  description = "Security group ID for the RDS instance"
  type        = string
}
