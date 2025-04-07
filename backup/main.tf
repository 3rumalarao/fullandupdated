resource "aws_backup_vault" "this" {
  name = "prod-backup-vault"

  tags = {
    Environment = "PROD"
  }
}

resource "aws_backup_plan" "this" {
  name = "prod-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 5 * * ? *)" # Daily at 5AM UTC
    lifecycle {
      cold_storage_after = 30
      delete_after       = var.backup_policy.retention_days
    }
  }
}

data "aws_iam_role" "backup_role" {
  name = "AWSBackupDefaultServiceRole"
}

resource "aws_backup_selection" "this" {
  name         = "prod-backup-selection"
  iam_role_arn = data.aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.this.id

  resources = var.resource_arns
}
