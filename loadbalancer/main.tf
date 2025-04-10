resource "aws_lb" "this" {
  name               = var.lb.name
  internal           = var.lb.scheme == "internal"
  load_balancer_type = var.lb.type
  security_groups    = var.lb.security_groups
  subnets            = var.subnet_ids
  tags = {
    Name = var.lb.name
  }
}

resource "aws_lb_target_group" "this" {
  name     = lower("${var.lb.name}-tg")
  port     = var.lb.listener_port
  protocol = var.lb.type == "application" ? "HTTP" : "TCP"
  vpc_id   = var.vpc_id
}
