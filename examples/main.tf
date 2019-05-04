module "tf-backend" {
  source = "../"

  bucket_prefix = "example1"
  bucket_region = "ap-southeast-2"

  bucket_sse_algorithm = "AES256"

  workspaces = ["prod", "nonprod", "sandpit"]

  assume_policy = {}
}
