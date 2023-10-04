# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags


[How to remove local and remote tag git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag

```
$ git tag -d <tag_name>

```

Remotely delete a tag

```
$ git push --delete origin tagname

```

Checkout the commit that you want to retag. Grab the sha from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

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

## Consideration when using ChatGPT to write Terraform

LLMs such as Chat GPT may not be trained on the latest documentation or info. about Terraform.

It may likely produce older examples that could be deprecated. Often affecting providers.


## Working with Files in Terraform


### Fileexists function

This is a built in terraform function to check the existence of a file.

```tf
    condition     = fileeexits(var.error_html_filepath)
  }

```
https://developer.hashicorp.com/terraform/language/functions/fileexists


### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

## Path Variable


In Terraform there is a special variable called `path` that allows us to reference local path:

- path.module =  get the path for the current module
- path.root =  get the path for the root module

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#path-module)


resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}

## Terraform Locals

Locals allows us to define local variables.
It can be very useful when we ned to transform data into another format.

```tf

locals {
    s3_origin_id = "MyS3Origin"
}

```

[Locals Values](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Source

This allows to source data from cloud resources. This is useful for reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

```

[Data Source](https://developer.hashicorp.com/terraform/language/data-sources)


## Working JSON

We use jsonencode to create a json policy inline with HCL

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}

```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)


### Changing the Lifecycle of Resources

[Meta Argument Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)



## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

https://developer.hashicorp.com/terraform/language/resources/terraform-data


## Provisioners


# https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax
You can use provisioners to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.

```tf


data "cloudinit_config" "my_cloud_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    filename     = "cloud.conf"
    content = yamlencode(
      {
        "write_files" : [
          {
            "path" : "/etc/foo.conf",
            "content" : "foo contents",
          },
          {
            "path" : "/etc/bar.conf",
            "content" : file("bar.conf"),
          },
          {
            "path" : "/etc/baz.conf",
            "content" : templatefile("baz.tpl.conf", { SOME_VAR = "qux" }),
          },
        ],
      }
    )
  }
}
```
### local-exec
#https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec
The local-exec provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform, not on the resource.

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}
```
### remote-exec
#https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec
The remote-exec provisioner invokes a script on a remote resource after it is created. This can be used to run a configuration management tool, bootstrap into a cluster, etc.

```tf

resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}

```

### File Provisioner

The file provisioner copies files or directories from the machine running Terraform to the newly created resource. The file provisioner supports both ssh and winrm type connections.

#https://developer.hashicorp.com/terraform/language/resources/provisioners/file

```tf

resource "aws_instance" "web" {
  # ...

  # Copies the myapp.conf file to /etc/myapp.conf
  provisioner "file" {
    source      = "conf/myapp.conf"
    destination = "/etc/myapp.conf"
  }

  # Copies the string in content into /tmp/file.log
  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "/tmp/file.log"
  }

  # Copies the configs.d folder to /etc/configs.d
  provisioner "file" {
    source      = "conf/configs.d"
    destination = "/etc"
  }

  # Copies all files and folders in apps/app1 to D:/IIS/webapp1
  provisioner "file" {
    source      = "apps/app1/"
    destination = "D:/IIS/webapp1"
  }
}
```

## For Each Expressions

For each allow us to enumerate over complex data types.

```sh

[for s in var.list : upper(s)]

```
This is mostly useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive terraform code.

[For Each Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)