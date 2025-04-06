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

variable "sg_id" {
  description = "Security group ID for the EFS mount targets"
  type = string
}
