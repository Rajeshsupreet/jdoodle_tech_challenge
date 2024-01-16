output "lb_tg_arn" {
  description = "LB Target group ARN"
  value       = try(aws_lb_target_group.lb_target_gp.arn, "")
}