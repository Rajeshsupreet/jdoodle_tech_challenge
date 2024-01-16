# General 
variable "aws_region" {
    default = "us-east-1"
}

# Load Balancer
variable "lb_name" {
    default = "mylb"
}
variable "lb_internal" { default = "false"}
variable "lb_load_balancer_type" { default = "application"}
variable "lb_security_groups" { default = ["sg-05e1e2bf1e4d2291f"]}
variable "lb_subnets" { default = ["subnet-0709b36d516cd45f4", "subnet-073e6fcdc8b5b2d9f"]}
variable "lb_enable_deletion_protection" { default = false}
variable "lb_target_port" { default = 80}
variable "lb_protocol" { default = "HTTP"}
variable "lb_target_type" { default = "instance"}
variable "vpc_id" {
     default = "vpc-09bba8d1a37cfcd4d"
}
variable "lb_listener_port" { default = "80"}
variable "lb_listener_protocol" { default = "HTTP"}


# Launch Template

variable "image_id" { default = "ami-08d4ac5b634553e16"}
variable "instance_type" { default = "t2.micro"}
variable "key_name" { default = "admin_new"}
variable "vpc_security_group_ids" { default = ["sg-05e1e2bf1e4d2291f"]}


# Auto Scaling
variable "max_size" { default = "4"}
variable "min_size" { default = "2"}
variable "desired_capacity" { default = "2"}
variable "asg_health_check_type" {
    default = "ELB"
}
variable "target_group_arns" { default = []}

variable "instance_name" { default = "jdoodle"}