# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:
```
- PROJECT_ROOT

    - Main.tf           # everything else
    - variable.tf       # Stores the structure of input variables
    - terraform.tfvars  # The data of variables we want to load into our Terraform project
    - Providers.tf      # Defined required providers and their configuration
    - outputs.tf        # Stores outputs
    - README.md         # Required for root modules

  ```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Environment Variables - those you set in your bash terminals eg. AWS credntials.
- Terraform variables - those that are set in tfvars file

We have the option of setting the Terraform Cloud variables to be sensitive.

### Loading Terraform Input Variables
[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)


### var flag
We can use the `-vars` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id`

### var-file flag

-var-file flag enables multiple input variable values to be passed in by referencing a file that contains the values.

#### terraform.tfvars

This is the dafault file to load in terraform variables in blunk

### auto.tfvars

Terraform also automatically loads a number of variable definitions files if they are present:
Any files with names ending in .auto.tfvars or .auto.tfvars.json

### order of terraform variables

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:
#### Environment variables
#### The terraform.tfvars file, if present.
#### The terraform.tfvars.json file, if present.
#### Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
#### Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)


## Dealing with Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likely have to tear down all your resources manually.

You can use terraform import but it won't work for all cloud resources. Hence the need to check terraform provides documentation to see which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone delete or modifiy cloud resources manually via clickops.

Terraform plan attempt to put our infracstructure back into the expected state fixing Configuration Drift.

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve

```

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `module` directory when locally developing modules but you can name it whatever in its own variables.tf

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf


```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}

```

### Modules Sources

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

Using the source we can import the modules from places eg:
- Locally
- Github
- Terraform

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}

```