variable "lb" {
  description = "Load balancer configuration"
  type = object({
    name             = string
    type             = string
    scheme           = string
    listener_port    = number
    security_groups  = list(string)
  })
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}
