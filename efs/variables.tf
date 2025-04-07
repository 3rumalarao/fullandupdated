variable "name" {
  type = string
}

variable "mount_targets" {
  description = "List of mount target definitions"
  type = list(object({
    az           = string
    subnet_index = number
  }))
}

variable "private_subnets" {
  type = list(string)
}

variable "environment" {
  description = "Environment tag"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "common_tags" {
  description = "Common tags for EFS resources"
  type        = map(string)
}
