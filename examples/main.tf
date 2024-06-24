terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region = var.region
}

module "tf_backend_example_1" {
  source = "../"

  bucket_prefix        = "example1"
  bucket_sse_algorithm = "AES256"
  workspaces           = ["prod", "nonprod", "sandpit"]

  assume_policy = {}
}

# for use with Terragrunt
module "tf_backend_example_2" {
  # source = "git::https://github.com/DNXLabs/terraform-aws-backend.git?ref=2.0.1"
  source = "./terraform-aws-backend"

  bucket_prefix        = "smartlead-prod"
  bucket_sse_algorithm = "aws:kms"
  kms_master_key_alias = "alias/aws/s3"
  workspaces           = ["default"]
  assume_policy        = {}
}
