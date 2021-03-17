provider "aws" {
  # the following assumes you've defined a separate profile
  # named [project] in ~/.aws/credentials  (apart from the 
  # usual [default])
  # 
  profile = "project"
  region = "ap-southeast-2"
}

module "tf-backend" {
  source = "../"

  bucket_prefix = "example1"

  bucket_sse_algorithm = "AES256"

  workspaces = ["prod", "nonprod", "sandpit"]

  assume_policy = {}
}
