# terraform-aws-cloudtrail

[![CircleCI](https://circleci.com/gh/tmknom/terraform-aws-cloudtrail.svg?style=svg)](https://circleci.com/gh/tmknom/terraform-aws-cloudtrail)
[![GitHub tag](https://img.shields.io/github/tag/tmknom/terraform-aws-cloudtrail.svg)](https://registry.terraform.io/modules/tmknom/cloudtrail/aws)
[![License](https://img.shields.io/github/license/tmknom/terraform-aws-cloudtrail.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module which creates CloudTrail resources on AWS.

## Description

Provision [CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html).
This module provides recommended settings.

- Enable for all AWS regions
- Logging for global services such as IAM, STS and CloudFront
- Enable log file integrity validation

## Usage

### Minimal

```hcl
module "cloudtrail" {
  source         = "git::https://github.com/tmknom/terraform-aws-cloudtrail.git?ref=tags/1.2.0"
  name           = "default-trail"
  s3_bucket_name = "cloudtrail-bucket"
}
```

### Complete

```hcl
module "cloudtrail" {
  source         = "git::https://github.com/tmknom/terraform-aws-cloudtrail.git?ref=tags/1.2.0"
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

# Omitted below.
```

## Examples

- [Minimal](https://github.com/tmknom/terraform-aws-cloudtrail/tree/master/examples/minimal)
- [Complete](https://github.com/tmknom/terraform-aws-cloudtrail/tree/master/examples/complete)

## Inputs

| Name                          | Description                                                                                         |  Type  | Default | Required |
| ----------------------------- | --------------------------------------------------------------------------------------------------- | :----: | :-----: | :------: |
| name                          | Specifies the name of the trail.                                                                    | string |    -    |   yes    |
| s3_bucket_name                | Specifies the name of the S3 bucket designated for publishing log files.                            | string |    -    |   yes    |
| cloud_watch_logs_group_arn    | Specifies a log group name using an Amazon Resource Name (ARN).                                     | string | `` | no |
| cloud_watch_logs_role_arn     | Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group.       | string | `` | no |
| enable_log_file_validation    | Specifies whether log file integrity validation is enabled.                                         | string | `true`  |    no    |
| enable_logging                | Enables logging for the trail.                                                                      | string | `true`  |    no    |
| include_global_service_events | Specifies whether the trail is publishing events from global services such as IAM to the log files. | string | `true`  |    no    |
| is_multi_region_trail         | Specifies whether the trail is created in the current region or in all regions.                     | string | `true`  |    no    |
| tags                          | A mapping of tags to assign to the bucket.                                                          |  map   |  `{}`   |    no    |

## Outputs

| Name                   | Description                                |
| ---------------------- | ------------------------------------------ |
| cloudtrail_arn         | The Amazon Resource Name of the trail.     |
| cloudtrail_home_region | The region in which the trail was created. |
| cloudtrail_name        | The name of the trail.                     |

## Development

### Requirements

- [Docker](https://www.docker.com/)

### Configure environment variables

```shell
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=ap-northeast-1
```

### Installation

```shell
git clone git@github.com:tmknom/terraform-aws-cloudtrail.git
cd terraform-aws-cloudtrail
make install
```

### Makefile targets

```text
clean                          Clean .terraform
docs                           Generate docs
format                         Format code
help                           Show help
install                        Install requirements
lint                           Lint code
release                        Release GitHub and Terraform Module Registry
terraform-apply-complete       Run terraform apply examples/complete
terraform-apply-minimal        Run terraform apply examples/minimal
terraform-destroy-complete     Run terraform destroy examples/complete
terraform-destroy-minimal      Run terraform destroy examples/minimal
terraform-plan-complete        Run terraform plan examples/complete
terraform-plan-minimal         Run terraform plan examples/minimal
upgrade                        Upgrade makefile
```

### Releasing new versions

Bump VERSION file, and run `make release`.

### Terraform Module Registry

- <https://registry.terraform.io/modules/tmknom/cloudtrail/aws>

## License

Apache 2 Licensed. See LICENSE for full details.
