# Module Configuration
#
# https://www.terraform.io/docs/configuration/modules.html

module "cloudtrail" {
  source         = "git::https://github.com/tmknom/terraform-aws-cloudtrail.git?ref=master"
  name           = "default-trail"
  s3_bucket_name = "cloudtrail-bucket"
}
