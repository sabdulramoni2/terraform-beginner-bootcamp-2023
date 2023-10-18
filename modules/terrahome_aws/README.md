## Terrahome AWS


```tf
module "terrahouse_aws" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.north_public_path
  content_version = var.content_version
}

```
The public directory expects the following:
- index.html
- error.html
- assets

All top level in assets will be copied, but not subdirectories.