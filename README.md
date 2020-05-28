# terraform-aws-backend

[![Lint Status](https://github.com/DNXLabs/terraform-aws-backend/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-backend/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-backend)](https://github.com/DNXLabs/terraform-aws-backend/blob/master/LICENSE)

A terraform module that implements what is describe in the Terraform S3 Backend [documentation](https://www.terraform.io/docs/backends/types/s3.html)

S3 Encryption is enabled and Public Access policies used to ensure security.

This module is expected to be deployed to a 'master' AWS account so that you can start using remote state as soon as possible. As this module creates the remote state backend, its statefile needs to be commited to git as it cannot be stored remotely. No sensetive information should be present in this file.

It is also expected that you check the statefile for this module into git to avoid the chicken and egg problem.

## Resources
|Name | Resource | Description |
|-----|----------|-------------|
| \<prefix>-terraform-backend | S3 Bucket | Used to store Terraform state files |
| terraform-lock | DynamoDB Table | Used for workspace locking |
| terraform-backend | IAM Role | Role created that has access to all terraform workspaces |
| terraform-backend-\<workspace> | IAM Role | Role created that only has access to the specified workspace |

<!--- BEGIN_TF_DOCS --->
<!--- END_TF_DOCS --->

## Assume Role Policy
The assume_role_policy by default will be set to the current account ID. This is primarily so can you can use the roles while your 'identity' account is under construction. Once your identity account is available you should specify the required assume_role_policy and the default will be removed.

Due to terraform lookup() only supporting string returns this cant be a list and needs to be specified as a string with principles seperated by commas in the event multiple entries are required.

```
  assume_policy = {
   prod    = "arn:aws:iam::xxxxxxxxxxxx:root,arn:aws:iam::yyyyyyyyyyyy:root"
   nonprod = "arn:aws:iam::xxxxxxxxxxxx:root,arn:aws:iam::yyyyyyyyyyyy:root"
   sandpit = "arn:aws:iam::xxxxxxxxxxxx:root,arn:aws:iam::yyyyyyyyyyyy:root"
  }
```

## Author
Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License
Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-backend/blob/master/LICENSE) for full details.