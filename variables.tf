# Input Variable Configuration
#
# https://www.terraform.io/docs/configuration/variables.html

variable "name" {
  type        = "string"
  description = "Specifies the name of the trail."
}

variable "s3_bucket_name" {
  type        = "string"
  description = "Specifies the name of the S3 bucket designated for publishing log files."
}

variable "enable_logging" {
  default     = true
  type        = "string"
  description = "Enables logging for the trail."
}

variable "is_multi_region_trail" {
  default     = true
  type        = "string"
  description = "Specifies whether the trail is created in the current region or in all regions."
}

variable "include_global_service_events" {
  default     = true
  type        = "string"
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files."
}

variable "enable_log_file_validation" {
  default     = true
  type        = "string"
  description = "Specifies whether log file integrity validation is enabled."
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "A mapping of tags to assign to the bucket."
}
