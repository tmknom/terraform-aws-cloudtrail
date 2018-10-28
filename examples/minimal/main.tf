module "cloudtrail" {
  source         = "../../"
  name           = "default-trail"
  s3_bucket_name = "cloudtrail-bucket"
}
