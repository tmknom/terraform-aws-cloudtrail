output "cloudtrail_arn" {
  value       = "${module.cloudtrail.cloudtrail_arn}"
  description = "The Amazon Resource Name of the trail."
}

output "cloudtrail_name" {
  value       = "${module.cloudtrail.cloudtrail_name}"
  description = "The name of the trail."
}

output "cloudtrail_home_region" {
  value       = "${module.cloudtrail.cloudtrail_home_region}"
  description = "The region in which the trail was created."
}
