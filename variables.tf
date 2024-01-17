# Load Balancer variables
variable "aws_region" {
  description = "AWS infrastructure region"
  type        = string
  default     = "us-east-1"
}
variable "lb_name" {
  description = "LB name"
  type        = string
  default     = "jdoodle_lb"
}

variable "lb_internal" {
  description = "Internal true or false"
  type        = bool
  default     = false
}

variable "lb_load_balancer_type" {
  description = "Application or Network type LB"
  type        = string
  default     = "application"
}

variable "lb_security_groups" {
  description = "LB security groups"
  type        = list(string)
  default     = ["sg-05e1e2bf1e4d2291f"]
}

variable "lb_subnets" {
  description = "LB subnets"
  type        = list(string)
  default     = ["subnet-0709b36d516cd45f4", "subnet-073e6fcdc8b5b2d9f"]
}

variable "lb_enable_deletion_protection" {
  description = "enable_deletion_protection true or false"
  type        = bool
  default     = false
}


variable "lb_target_port" {
  description = "lb_target_port 80 or 443"
  type        = number
  default     = 80
}

variable "lb_protocol" {
  description = "lb_protocol HTTP (ALB) or TCP (NLB)"
  type        = string
  default     = "HTTP"
}

variable "lb_target_type" {
  description = "Target type ip (ALB/NLB), instance (Autosaling group)"
  type        = string
  default     = "instance"
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
  default     = "vpc-09bba8d1a37cfcd4d"
}

variable "lb_listener_port" {
  description = "lb_listener_port"
  type        = number
  default     = 80
}

variable "lb_listener_protocol" {
  description = "lb_listener_protocol HTTP, TCP, TLS"
  type        = string
  default     = "HTTP"
}



variable "lb_target_tags_map" {
  description = "Tag map for the LB target resources"
  type        = map(string)
  default     = {}
}


# Launch Template varaibles

variable "image_id" {
  description = " ID of the AMI"
  type        = string
  default     = "ami-0c7217cdde317cfec"

}

variable "instance_type" {
  description = " The type of the instance"
  type        = string
  default     = "t2.micro"

}

variable "key_name" {
  description = " The key name to use for the instance"
  type        = string
  default     = "admin_new"

}

variable "vpc_security_group_ids" {
  description = " A list of security group names to associate with. If you are creating Instances in a VPC,"
  type        = list(string)
  default     = ["sg-05e1e2bf1e4d2291f"]

}

variable "instance_name" {
  description = " name of the instance,"
  type        = string
  default     = "jdoodle"

}

# Auto Scaling variables

variable "min_size" {
  description = " Minimum size of the Auto Scaling Group,"
  type        = number
  default     = 2

}

variable "max_size" {
  description = " Maximun size of the Auto Scaling Group,"
  type        = number
  default     = 5

}

variable "desired_capacity" {
  description = " Number of Amazon EC2 instances that should be running in the group,"
  type        = number
  default     = 2

}

variable "asg_health_check_type" {
  description = " Type of Helath check ,"
  type        = string
  default     = "EC2"

}

variable "target_group_arns" {
  description = " ARNs, for use with Application or Network Load Balancing,"
  type        = list(string)
  default     = []

}