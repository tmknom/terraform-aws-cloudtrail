module "cloudtrail" {
  source         = "../../"
  name           = "default-trail"
  s3_bucket_name = "cloudtrail-bucket"

  enable_logging                = false
  is_multi_region_trail         = false
  include_global_service_events = false
  enable_log_file_validation    = false

  cloud_watch_logs_role_arn  = "${module.iam_role.iam_role_arn}"
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.complete.arn}"

  tags = {
    Environment = "prod"
    Name        = "default-trail"
  }
}

resource "aws_cloudwatch_log_group" "complete" {
  name = "CloudTrail/logs"
}

module "iam_role" {
  source             = "git::https://github.com/tmknom/terraform-aws-iam-role.git?ref=tags/1.2.0"
  name               = "sending-cloudwatch-logs-for-cloudtrail"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
  policy             = "${data.aws_iam_policy_document.policy.json}"
  description        = "Send log events to CloudWatch Logs from CloudTrail"
}

# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/send-cloudtrail-events-to-cloudwatch-logs.html#send-cloudtrail-events-to-cloudwatch-logs-cli-create-role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/send-cloudtrail-events-to-cloudwatch-logs.html#w2aac10c17c23c19b8
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "AWSCloudTrailCreateLogStream2014110"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
    ]

    resources = [
      "arn:aws:logs:${local.region}:${local.account_id}:log-group:${aws_cloudwatch_log_group.complete.name}:log-stream:${local.account_id}_CloudTrail_${local.region}*",
    ]
  }

  statement {
    sid    = "AWSCloudTrailPutLogEvents20141101"
    effect = "Allow"

    actions = [
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:${local.region}:${local.account_id}:log-group:${aws_cloudwatch_log_group.complete.name}:log-stream:${local.account_id}_CloudTrail_${local.region}*",
    ]
  }
}

locals {
  region     = "${data.aws_region.current.name}"
  account_id = "${data.aws_caller_identity.current.account_id}"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
