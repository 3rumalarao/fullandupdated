variable "rds" {
  type = object({
    name           = string
    instance_class = string
    engine         = string
    username       = string
    password       = string
    storage        = number
    subnets        = list(string)
  })
}

variable "vpc_id" {
  type = string
}

variable "sg_id" {
  description = "Security group ID for the RDS instance"
  type = string
}
