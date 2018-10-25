# terraform-aws-cloudtrail

Terraform module which creates CloudTrail resources on AWS.

## Usage

### Minimal

```hcl
module "cloudtrail" {
  source         = "git::https://github.com/tmknom/terraform-aws-cloudtrail.git?ref=master"
  name           = "default-trail"
  s3_bucket_name = "cloudtrail-bucket"
}
```

### Complete

```hcl
module "cloudtrail" {
  source         = "git::https://github.com/tmknom/terraform-aws-cloudtrail.git?ref=master"
  name           = "default-trail"
  s3_bucket_name = "cloudtrail-bucket"

  enable_logging                = false
  is_multi_region_trail         = false
  include_global_service_events = false
  enable_log_file_validation    = false
}
```

## Examples

- [Minimal](https://github.com/tmknom/terraform-aws-cloudtrail/tree/master/examples/minimal)
- [Complete](https://github.com/tmknom/terraform-aws-cloudtrail/tree/master/examples/complete)

## Inputs

| Name                          | Description                                                                                         |  Type  | Default | Required |
| ----------------------------- | --------------------------------------------------------------------------------------------------- | :----: | :-----: | :------: |
| enable_log_file_validation    | Specifies whether log file integrity validation is enabled.                                         | string | `true`  |    no    |
| enable_logging                | Enables logging for the trail.                                                                      | string | `true`  |    no    |
| include_global_service_events | Specifies whether the trail is publishing events from global services such as IAM to the log files. | string | `true`  |    no    |
| is_multi_region_trail         | Specifies whether the trail is created in the current region or in all regions.                     | string | `true`  |    no    |
| name                          | Specifies the name of the trail.                                                                    | string |    -    |   yes    |
| s3_bucket_name                | Specifies the name of the S3 bucket designated for publishing log files.                            | string |    -    |   yes    |

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
docs                           Generate docs
format                         Format code
help                           Show help
install                        Install requirements
lint                           Lint code
terraform-apply-complete       Run terraform apply examples/complete
terraform-apply-minimal        Run terraform apply examples/minimal
terraform-destroy-complete     Run terraform destroy examples/complete
terraform-destroy-minimal      Run terraform destroy examples/minimal
terraform-plan-complete        Run terraform plan examples/complete
terraform-plan-minimal         Run terraform plan examples/minimal
upgrade                        Upgrade makefile
```

### Releasing new versions

```shell
git tag 1.X.X
git push origin 1.X.X
```

### Terraform Module Registry

- <https://registry.terraform.io/modules/tmknom/cloudtrail/aws>

## License

Apache 2 Licensed. See LICENSE for full details.
