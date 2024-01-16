resource "aws_lb" "lb" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups    
  subnets            = var.subnets            
  enable_deletion_protection = var.enable_deletion_protection 
}

resource "aws_lb_target_group" "lb_target_gp" {
  name        = "tg-${var.name}"
  port        = var.lb_target_port
  protocol    = var.lb_protocol    
  target_type = var.lb_target_type
  vpc_id      = var.vpc_id
  depends_on  = [aws_lb.lb]
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_listener_port     
  protocol          = var.lb_listener_protocol 


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_gp.arn
  }
}
