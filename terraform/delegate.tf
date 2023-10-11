# resource "aws_iam_policy" "delegate_aws_access" {
#   name        = "delegate_aws_access"
#   description = "Policy for harness delegate aws access"

#   policy = <<EOF
# {
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Sid": "GetArtifacts",
#            "Effect": "Allow",
#            "Action": [
#                "s3:*"
#            ],
#            "Resource": [
#               "${aws_s3_bucket.riley-snyder-harness-io.arn}",
#               "${aws_s3_bucket.riley-snyder-harness-io.arn}/*"
#            ]
#        },
#        {
#            "Sid": "DockerLogin",
#            "Effect": "Allow",
#            "Action": "secretsmanager:GetSecretValue",
#            "Resource": "arn:aws:secretsmanager:us-west-2:759984737373:secret:riley/dockerhub*"
#        },
#        {
#            "Sid": "AssumeAdmin",
#            "Effect": "Allow",
#            "Action": "sts:AssumeRole",
#            "Resource": "${aws_iam_role.rileysnyderharnessio-assumed.arn}"
#        },
#        {
#            "Sid": "ECRToken",
#            "Effect": "Allow",
#            "Action": "ecr:GetAuthorizationToken",
#            "Resource": "*"
#        }
#    ]
# }
# EOF
# }

# module "delegate" {
#   source = "git::https://github.com/harness-community/terraform-aws-harness-delegate-ecs-fargate.git?ref=main"
#   name                      = "ecs"
#   harness_account_id        = data.harness_current_account.current.id
#   delegate_image            = "rssnyder/delegate:latest"
#   desired_count             = 1
#   delegate_token_secret_arn = "arn:aws:secretsmanager:us-west-2:759984737373:secret:riley/delegate-zBsttc"
#   registry_secret_arn       = "arn:aws:secretsmanager:us-west-2:759984737373:secret:riley/dockerhub-UiTqT3"
#   delegate_policy_arns = [
#     aws_iam_policy.delegate_aws_access.arn,
#     "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
#   ]
#   cluster_id = data.aws_ecs_cluster.solutions-architecture.id
#   security_groups = [
#     data.aws_security_group.sa-lab-default.id
#   ]
#   subnets = data.aws_subnets.sa-lab-private.ids
# }
