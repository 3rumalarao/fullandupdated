resource "aws_lb" "this" {
  name               = var.lb.name
  internal           = var.lb.scheme == "internal" ? true : false
  load_balancer_type = var.lb.type
  security_groups    = [var.sg_id]
  subnets            = var.subnet_ids
  tags = {
    Name = var.lb.name
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.lb.name}-TG"
  port     = var.lb.listener_port
  protocol = var.lb.type == "application" ? "HTTP" : "TCP"
  vpc_id   = var.vpc_id
}
