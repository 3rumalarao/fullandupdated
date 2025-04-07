variable "ssm_parameters" {
  description = "Map of SSM parameter definitions"
  type = map(object({
    name        = string
    description = string
    value       = string
    type        = string
  }))
}
