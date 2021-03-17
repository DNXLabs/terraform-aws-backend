terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region = var.region
}

module "tf_backend" {
  source = "../"

  bucket_prefix        = "example1"
  bucket_sse_algorithm = "AES256"
  workspaces           = ["prod", "nonprod", "sandpit"]

  assume_policy = {}
}
