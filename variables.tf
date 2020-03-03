variable "bucket_prefix" {
  type        = string
  description = "A prefix applied to the S3 bucket created to ensure a unique name."
}

variable "bucket_region" {
  type        = string
  description = "The region to create the S3 bucket in"
}

variable "bucket_sse_algorithm" {
  type        = string
  description = "Encryption algorithm to use on the S3 bucket. Currently only AES256 is supported"
  default     = "AES256"
}

variable "workspaces" {
  type        = list(string)
  description = "A list of terraform workspaces that IAM Roles/Policy will be created for"
}

variable "assume_policy" {
  type        = map(string)
  description = "A map that allows you to specify additional AWS principles that will be added to the backend roles assume role policy"

  default = {}
}
