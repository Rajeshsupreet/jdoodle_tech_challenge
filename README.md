## **AWS Autoscaling Group**

This Terraform root module demonstrates deployment of autoscaling Group in AWS

- Contents of this README:
  1. **What is being provisioned**
  2. **Requirements**
  3. **Providers**
  4. **Modules**
  5. **Resources**
  6. **Inputs**
  7. **Deployment**
      - *GitHub Actions (Automated Process)*
      - *Manual Deployment*. 
---
## 1. What is being provisioned

- AWS Autoscaling Group
- Load Balancer
---
## 2. Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.32.1 |

## 3. Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.32.1 |

## 4. Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_lb"></a> [aws\_lb](#module\_aws\_lb) | ./modules/aws_elb | n/a |

## 5. Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_notification.myasg_notifications](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/autoscaling_notification) | resource |
| [aws_autoscaling_policy.scale_down](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.scale_up](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_schedule.schedule](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/autoscaling_schedule) | resource |
| [aws_cloudwatch_metric_alarm.scale_down_alarm](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.scale_up_alarm](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_instance_profile.iam_ec2_profile](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.sto-readonly-role-policy-attach](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.ec2_launch_template](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/launch_template) | resource |
| [aws_sns_topic.myasg_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.myasg_sns_topic_subscription](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/sns_topic_subscription) | resource |

## 6. Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_health_check_type"></a> [asg\_health\_check\_type](#input\_asg\_health\_check\_type) | Type of Helath check , | `string` | `"EC2"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS infrastructure region | `string` | `"us-east-1"` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Number of Amazon EC2 instances that should be running in the group, | `number` | `2` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | ID of the AMI | `string` | `"ami-0c7217cdde317cfec"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | name of the instance, | `string` | `"jdoodle"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The key name to use for the instance | `string` | `"admin_new"` | no |
| <a name="input_lb_enable_deletion_protection"></a> [lb\_enable\_deletion\_protection](#input\_lb\_enable\_deletion\_protection) | enable\_deletion\_protection true or false | `bool` | `false` | no |
| <a name="input_lb_internal"></a> [lb\_internal](#input\_lb\_internal) | Internal true or false | `bool` | `false` | no |
| <a name="input_lb_listener_port"></a> [lb\_listener\_port](#input\_lb\_listener\_port) | lb\_listener\_port | `number` | `80` | no |
| <a name="input_lb_listener_protocol"></a> [lb\_listener\_protocol](#input\_lb\_listener\_protocol) | lb\_listener\_protocol HTTP, TCP, TLS | `string` | `"HTTP"` | no |
| <a name="input_lb_load_balancer_type"></a> [lb\_load\_balancer\_type](#input\_lb\_load\_balancer\_type) | Application or Network type LB | `string` | `"application"` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | LB name | `string` | `"jdoodle_lb"` | no |
| <a name="input_lb_protocol"></a> [lb\_protocol](#input\_lb\_protocol) | lb\_protocol HTTP (ALB) or TCP (NLB) | `string` | `"HTTP"` | no |
| <a name="input_lb_security_groups"></a> [lb\_security\_groups](#input\_lb\_security\_groups) | LB security groups | `list(string)` | <pre>[<br>  "sg-05e1e2bf1e4d2291f"<br>]</pre> | no |
| <a name="input_lb_subnets"></a> [lb\_subnets](#input\_lb\_subnets) | LB subnets | `list(string)` | <pre>[<br>  "subnet-0709b36d516cd45f4",<br>  "subnet-073e6fcdc8b5b2d9f"<br>]</pre> | no |
| <a name="input_lb_target_port"></a> [lb\_target\_port](#input\_lb\_target\_port) | lb\_target\_port 80 or 443 | `number` | `80` | no |
| <a name="input_lb_target_tags_map"></a> [lb\_target\_tags\_map](#input\_lb\_target\_tags\_map) | Tag map for the LB target resources | `map(string)` | `{}` | no |
| <a name="input_lb_target_type"></a> [lb\_target\_type](#input\_lb\_target\_type) | Target type ip (ALB/NLB), instance (Autosaling group) | `string` | `"instance"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximun size of the Auto Scaling Group, | `number` | `5` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum size of the Auto Scaling Group, | `number` | `2` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | ARNs, for use with Application or Network Load Balancing, | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc\_id | `string` | `"vpc-09bba8d1a37cfcd4d"` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | A list of security group names to associate with. If you are creating Instances in a VPC, | `list(string)` | <pre>[<br>  "sg-05e1e2bf1e4d2291f"<br>]</pre> | no |

# 7. Deployment
### GitHub Actions (Automated Process) -- Recommended
- Whenever new code is merged to the main branch then the GitHub action will be triggered automatically.
- On successful build completion, aws scaling group and respective resources are deployed in aws
- The secret variables are configured in Github
- Full workflow about provisioning resources is available in the [actions.yml](.github/workflows/actions.yml)

### Manual Deployment

Make sure you add AWS env variables prior running terraform commands

[Instructions available here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables)

### Installing Terraform
Terraform should be installed on your system. [Instructions available here](https://learn.hashicorp.com/tutorials/terraform/install-cli). Once installed check the version, it should be at least `0.14.2` or higher:

```shell
$ terraform version
Terraform v1.0.7
```
### Initalizing Terraform
Next Terraform needs to download the necessary provider plugins, modules and set up the initial (empty) state. Start by executing

```shell
$ terraform init
```
### terraform plan 
Now you are ready to run terraform [plan](https://www.terraform.io/docs/commands/plan.html) with secrets vraiables :

```shell
$ terraform plan
```
Terraform will calculate an execution plan and display all the actions it needs to perform to deploy app and components.

### terraform apply
The [apply](https://www.terraform.io/docs/commands/apply.html) step will kick off provisioning of all resources:

```shell
$ terraform apply
```

This typically
takes between 5-15 minutes.
Once the apply step finishes you should see something like below:

```shell
Apply complete! Resources: 16 added, 0 changed, 0 destroyed.
```
## terraform destroy
You can remove all created resources using the terraform [destroy](https://www.terraform.io/docs/commands/destroy.html) command

```shell
$ terraform destroy
```