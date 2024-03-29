resource "aws_iam_role" "iam_role" {
  name = "ec2_cloud_watch_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "sto-readonly-role-policy-attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
}

resource "aws_iam_instance_profile" "iam_ec2_profile" {
  name = "iam_ec2_profile"
  role = aws_iam_role.iam_role.name
}