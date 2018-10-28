module "cloudtrail" {
  source         = "../../"
  name           = "default-trail"
  s3_bucket_name = "cloudtrail-bucket"

  enable_logging                = false
  is_multi_region_trail         = false
  include_global_service_events = false
  enable_log_file_validation    = false

  tags = {
    Environment = "prod"
    Name        = "default-trail"
  }
}
