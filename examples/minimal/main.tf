# Module Configuration
#
# https://www.terraform.io/docs/configuration/modules.html

module "cloudtrail" {
  source         = "../../"
  name           = "default-trail"
  s3_bucket_name = "cloudtrail-bucket"
}
