# Resource Configuration
#
# https://www.terraform.io/docs/configuration/resources.html

# https://www.terraform.io/docs/providers/aws/r/cloudtrail.html
resource "aws_cloudtrail" "default" {
  name           = "${var.name}"
  s3_bucket_name = "${var.s3_bucket_name}"

  # When you create a trail, logging is turned on automatically. You can turn off logging for a trail.
  # https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-turning-off-logging.html
  enable_logging = "${var.enable_logging}"

  # When you create a trail that applies to all regions,
  # CloudTrail records events in each region and delivers the CloudTrail event log files to an S3 bucket that you specify.
  # https://docs.aws.amazon.com/awscloudtrail/latest/userguide/how-cloudtrail-works.html
  is_multi_region_trail = "${var.is_multi_region_trail}"

  # For global services such as IAM, STS, CloudFront, and Route 53,
  # events are delivered to any trail that includes global services,
  # and are logged as occurring in US East (N. Virginia) Region.
  # https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-concepts.html#cloudtrail-concepts-global-service-events
  include_global_service_events = "${var.include_global_service_events}"

  # To determine whether a log file was modified, deleted, or unchanged after CloudTrail delivered it,
  # you can use CloudTrail log file integrity validation.
  # https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-log-file-validation-intro.html
  enable_log_file_validation = "${var.enable_log_file_validation}"

  # A mapping of tags to assign to the bucket.
  tags = "${var.tags}"
}
