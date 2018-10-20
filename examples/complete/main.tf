# Module Configuration
#
# https://www.terraform.io/docs/configuration/modules.html

module "cloudtrail" {
  source         = "git::https://github.com/tmknom/terraform-aws-cloudtrail.git?ref=master"
  name           = "default-trail"
  s3_bucket_name = "cloudtrail-bucket"

  enable_logging                = false
  is_multi_region_trail         = false
  include_global_service_events = false
  enable_log_file_validation    = false
}
