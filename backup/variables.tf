variable "backup_policy" {
  description = "Backup policy configuration for production resources"
  type = object({
    retention_days      = number
    resource_tag_filter = string
  })
}

variable "resource_arns" {
  description = "List of resource ARNs to backup"
  type        = list(string)
  default     = []
}
