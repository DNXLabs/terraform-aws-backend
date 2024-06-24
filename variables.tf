variable "bucket_prefix" {
  type        = string
  description = "A prefix applied to the S3 bucket created to ensure a unique name."
}

variable "bucket_sse_algorithm" {
  type        = string
  description = "Encryption algorithm to use on the S3 bucket. Currently only AES256 is supported"
  default     = "AES256"
}

variable "kms_master_key_alias" {
  type        = string
  description = "The alias of the KMS key to use for S3 server-side encryption. If not provided, S3-managed encryption keys will be used."
  default     = "alias/aws/s3"
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
