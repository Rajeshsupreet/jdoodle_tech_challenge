resource "aws_launch_template" "ec2_launch_template" {
  name          = "${var.instance_name}_tpl"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name != null ? var.key_name : null
  user_data     = filebase64("${path.module}/ec2_init.sh")
  iam_instance_profile {
    name = aws_iam_instance_profile.iam_ec2_profile.name
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.vpc_security_group_ids
  }
  monitoring {
    enabled = true
  }
}

resource "aws_autoscaling_group" "asg" {

  name                      = "${var.instance_name}_asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = var.asg_health_check_type
  vpc_zone_identifier       = var.lb_subnets
  target_group_arns         = [module.aws_lb.lb_tg_arn]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = aws_launch_template.ec2_launch_template.latest_version
  }
  depends_on = [module.aws_lb]
}

# scale up policy
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.instance_name}-asg-scale-up"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

# scale up alarm
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "${var.instance_name}-asg-scale-up-alarm"
  alarm_description   = "asg-scale-up-loadaverage-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "LoadAverage5min"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "SampleCount"
  threshold           = "75"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up.arn]
}

# scale down policy
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.instance_name}-asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

# scale down alarm
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "${var.instance_name}-asg-scale-down-alarm"
  alarm_description   = "asg-scale-down-loadaverage-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "LoadAverage5min"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "SampleCount"
  threshold           = "50"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]
}

resource "aws_autoscaling_schedule" "schedule" {
  scheduled_action_name  = "asg_schedule"
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = 2
  recurrence             = "0 0 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_sns_topic" "myasg_sns_topic" {
  name = "myasg-sns-topic"
}

## SNS - Subscription
resource "aws_sns_topic_subscription" "myasg_sns_topic_subscription" {
  topic_arn = aws_sns_topic.myasg_sns_topic.arn
  protocol  = "email"
  endpoint  = "rajesh4277@gmail.com"
}

## Create Autoscaling Notification Resource
resource "aws_autoscaling_notification" "myasg_notifications" {
  group_names = [aws_autoscaling_group.asg.id]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
  topic_arn = aws_sns_topic.myasg_sns_topic.arn 
}