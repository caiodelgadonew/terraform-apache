resource "aws_iam_role" "s3_iam_role" {
  name = "s3_iam_role"

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
      provider = "terraform"
  }
}

resource "aws_iam_instance_profile" "ec2_s3_iam_profile" {
  name = "ec2_s3_iam_profile"
  role = aws_iam_role.s3_iam_role.name
}

resource "aws_iam_role_policy" "s3-access" {
  name = "s3-access"
  role = aws_iam_role.s3_iam_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
