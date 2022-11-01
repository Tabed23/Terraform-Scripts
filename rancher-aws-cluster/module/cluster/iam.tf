resource "aws_iam_role" "this_iam_role" {
  name = "ec2-iam-role"

   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "dev-ec2-role"
  }
}


resource "aws_iam_role_policy" "ec2_secret_manager_policy" {
  name = "secret_manager_policy"
  role = "${aws_iam_role.this_iam_role.id}"

  policy = jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": "secretsmanager:GetSecretValue",
        "Resource": "${var.secret_manager_arn}"
    }]
   }

  )
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance_profile"
  role = "${aws_iam_role.this_iam_role.name}"
}