data "aws_iam_policy_document" "iam-role-policy-restricted" {
  count = "${length(var.workspaces)}"

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.backend.id}"]
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.backend.id}/env:/${element(var.workspaces, count.index)}/*"]
  }

  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = ["arn:aws:dynamodb:*:*:table/terraform-lock"]
  }
}

data "aws_iam_policy_document" "iam-role-policy" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.backend.id}"]
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.backend.id}/*"]
  }

  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = ["arn:aws:dynamodb:*:*:table/terraform-lock"]
  }
}

data "aws_iam_policy_document" "backend-assume-role-all" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = split(",", lookup(var.assume_policy, "all", data.aws_caller_identity.current.account_id))
    }
  }
}

data "aws_iam_policy_document" "backend-assume-role-restricted" {
  count = "${length(var.workspaces)}"

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = split(",", lookup(var.assume_policy, "${element(var.workspaces, count.index)}", data.aws_caller_identity.current.account_id))
    }
  }
}
