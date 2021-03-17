output "dynamo_lock_table" {
  description = "Dynamodb table that stores the terraform lock state."
  value       = module.tf_backend.dynamo_lock_table
}

output "iam_roles" {
  description = "IAM roles to be assumed by the backend."
  value       = module.tf_backend.iam_roles
}

output "state_bucket_arn" {
  description = "S3 bucket that stored the terraform state."
  value       = module.tf_backend.state_bucket_arn
}
