variable "lb" {
  description = "Load balancer configuration"
  type = object({
    name          = string
    type          = string
    scheme        = string
    listener_port = number
  })
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "sg_id" {
  description = "Security group ID for the load balancer"
  type = string
}
