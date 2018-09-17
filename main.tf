# Resource Configuration
#
# https://www.terraform.io/docs/configuration/resources.html

# https://www.terraform.io/docs/providers/aws/r/cloudtrail.html
resource "aws_cloudtrail" "default" {
  name           = "${var.name}"
  s3_bucket_name = "${var.s3_bucket_name}"

  enable_logging                = "${var.enable_logging}"
  is_multi_region_trail         = "${var.is_multi_region_trail}"
  include_global_service_events = "${var.include_global_service_events}"
  enable_log_file_validation    = "${var.enable_log_file_validation}"
}
