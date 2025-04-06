variable "instances" {
  description = "Map of instance configurations"
  type = map(object({
    ami           = string
    instance_type = string
    subnet_index  = number
    key_name      = string
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
  description = "Flag to indicate if instances are public (EIP will be allocated)"
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
