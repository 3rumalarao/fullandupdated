variable "instances" {
  description = "Map of instance configurations"
  type = map(object({
    ami             = string
    instance_type   = string
    subnet_index    = number
    key_name        = string
    security_groups = list(string)
  }))
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "is_public" {
  description = "Flag indicating if instances are public"
  type        = bool
  default     = false
}

variable "env" {
  description = "Environment tag"
  type        = string
}

variable "orgname" {
  description = "Organization name"
  type        = string
}
