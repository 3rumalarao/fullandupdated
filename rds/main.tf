resource "aws_db_subnet_group" "this" {
  name       = "${var.rds.name}-subnet-group"
  subnet_ids = var.rds.subnets

  tags = {
    Name = "${var.rds.name}-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier             = var.rds.name
  engine                 = var.rds.engine
  instance_class         = var.rds.instance_class
  username               = var.rds.username
  password               = var.rds.password
  allocated_storage      = var.rds.storage
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.sg_id]
  skip_final_snapshot    = true

  tags = {
    Name = var.rds.name
  }
}
