# terraform-aws-backend

Terraform-aws-backend is a terraform module that implements what is describe in the Terraform S3 Backend [documentation](https://www.terraform.io/docs/backends/types/s3.html)

S3 Encryption is enabled and Public Access policies used to ensure security.

This module is expected to be deployed to a 'master' AWS account so that you can start using remote state as soon as possible. As this module creates the remote state backend, its statefile needs to be commited to git as it cannot be stored remotely. No sensetive information should be present in this file.

It is also expected that you check the statefile for this module into git to avoid the chicken and egg problem.

This module requires:
 - Terraform Version >=0.12.20

This modules creates the following resources:
 - Encrypted S3 Bucket - Used to store Terraform state files
   - This bucket
      -  Block public acls
      -  Block public policy
      -  Ignore public acls
      -  Restrict public buckets
- AWS DynamoDB Table - Used for workspace locking
- Identity and Access Management (IAM) - Backend All -  Role that Allows access to all Terraform workspaces
- Identity and Acesss Management (IAM) - Backend restricted - These roles are limited to their specific workspace through the use of S3 resource permissions

More Information: https://dnxlabs.slab.com/public/7tk9j2m9

[![Lint Status](https://github.com/DNXLabs/terraform-aws-backend/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-backend/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-backend)](https://github.com/DNXLabs/terraform-aws-backend/blob/master/LICENSE)




## Resources
|Name | Resource | Description |
|-----|----------|-------------|
| \<prefix>-terraform-backend | S3 Bucket | Used to store Terraform state files |
| terraform-lock | DynamoDB Table | Used for workspace locking |
| terraform-backend | IAM Role | Role created that has access to all terraform workspaces |
| terraform-backend-\<workspace> | IAM Role | Role created that only has access to the specified workspace |

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_policy | A map that allows you to specify additional AWS principles that will be added to the backend roles assume role policy | `map(string)` | `{}` | no |
| bucket\_prefix | A prefix applied to the S3 bucket created to ensure a unique name. | `string` | n/a | yes |
| bucket\_sse\_algorithm | Encryption algorithm to use on the S3 bucket. Currently only AES256 is supported | `string` | `"AES256"` | no |
| workspaces | A list of terraform workspaces that IAM Roles/Policy will be created for | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dynamo\_lock\_table | n/a |
| iam\_roles | n/a |
| state\_bucket\_arn | n/a |

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