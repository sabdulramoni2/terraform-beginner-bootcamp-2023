# Terraform Beginner Bootcamp 2023 - Week 0

- [Semantic Versioning: mage:](#semantic-versioning--mage-)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang Consideration](#shebang-consideration)
    + [Execution Considerations](#execution-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
- [Gitpod Lifecyle](#gitpod-lifecyle)
- [Working Env Vars](#working-env-vars)
    + [env command](#env-command)
    + [Setting and unsetting Env Vars](#setting-and-unsetting-env-vars)
    + [Printing Vars](#printing-vars)
    + [Scoping of Env Vars](#scoping-of-env-vars)
    + [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basic](#terraform-basic)
  * [Terraform Registry](#terraform-registry)
  * [Terraform console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State File](#terraform-state-file)
    + [Terraform Directory](#terraform-directory)
 - [S3 Bucket](#s3-bucket)
- [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


## Semantic Versioning :mage:

This project is going to ultilize semantic versioning for it tagging.
[Semver.or](ghttps://semver.org/)

The general format: version number 
**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform CLI

## Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and the change the scripting for install.  

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Considerations for Linux Distribution

This project is built against Ubuntu. Please consider checking your Linux Distribution and change accordingly to distribution type.

[How to check OS version in Linux](https://www.tecmint.com/check-linux-os-version/)

Example of checking OS Version:

```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

```

## Refactoring into Bash Scripts


While fixing the Terrafrom CLI gpg deprecation issues we noticed the installations steps werea considerable amount of code. We created a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This iwll keep the Gitpod Task File ([.gitpod.yml(.gitpod.yml)])tidy.
- This allow us an easier way to debug and execute Terraform CLI install manually.
- This will allow better portability for other projects that need to install Terraform CLI.

## Shebang Consideration

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret thescript. eg. `#!/bin/bash`

ChatGPT recommend we use the format for bash: '#!/usr/bin/env bash'

- For portability for different OS distributions
- Will search the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

## Execution Considerations

When executing the bash script we can use the './' shorthand notation to execute the bash script.

eg> `./bin/insatll_terraform_cli`

If we are using a scipt in .gitpod.yml we need to point the script to interpret it.


eg. `source ./bin/insta;ll_terraform_cli`

## Linux Permissions Considerations

In order to make our bash scripts executable we need change linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terafform_
```

Alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```



https://en.wikipedia.org/wiki/File-system_permissions#Permissions


### GitpodLifecyle

We need to be careful when using the Init because it will not rerun if we start an existing workspace.



https://www.gitpod.io/docs/configure/workspaces/tasks


## Working Env Vars

#### env command

We can list out all Environment variables (Env Vars) using the 'env' command

We can filter specific env vars using grep eg. 'env | grep AWS_'

####  Setting and unsetting Env Vars

In the terminal we can set using 'export HELLO='world'


In the terminal we can unset using 'unset HELLO'

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up a new bash terminals in VSCode it will not be aware of env vars that you set in another window.

If you want to make Env Vars persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`


#### Persisting Env Vars in Gitpod

We can persist env vars in gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspace launched will set the env vars for all bash terminals opened in those workspace.

You can also set env vars in the `.gitpod.yml` but this can only contained non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for the project.

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](.bin/install_aws_cli)



[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)


We can check if AWS credentials is configured correctly by running the following AWS CLI command

```sh
aws sts get-caller-identity
```
If it is successful you should see a json payload that looks like this:

```json
{
    "UserId": "AIDASEZMU4WJHK62ZYMKL",
    "Account": "147733144978",
    "Arn": "arn:aws:iam::147733144978:user/terraform-beginner-bootcamp"
    terraform-beginner-bootcamp
}
```

We need to generate AWS CLI credentials from IAM user inorder to use the AWS CLI.


## Terraform Basic


### Terraform Registry


Terraform sources their providers and modules from the Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an  interface to API that will allow to create resources in Terraform.
- **Module** are a way to make a large amount of terraform code modular, portable and sharable.
[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest)

## Terraform console

We can see a list of all the Terraform commands by simply typing 'terraform'

#### Terraform Init

Run Terraform init to download binaries from Terraform providers.

#### Terraform Plan

`terraform paln`


This shows you the resources that will be change (added or deleted or updated)


#### Terraform Apply

`terraform apply`

This exectute the proposed chnages shown above. Apply will prompt yes or no. Run apply with --auto-approve to ignore the prompt. eg. terraform apply --auto-approve.

### Terraform Destroy

`terraform destroy`

This will destory resources. Destroy will prompt yes or no. Run apply with --auto-approve to ignore the prompt. eg. terraform destroy --auto-approve.



### Terraform Lock Files

`.terraform.lock.hcl` contains the lock versioning for the providers or modules used in this project. It **should be committed** to Version Control System (VSC) eg. Github.

### Terraform State File

`.terraform.tfstate` contains information about your current state of infracstructure. **It should not be committed** to VSC. It contains senssitive information.

`.terraform.tfstate.backup` is the previuos state firl state.


### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

#### S3 Bucket

We ran into an issue when creating the S3 bucket. We had to use lower cases to fix the issue.


## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash wiswig view to generate a token. However it does not work in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud.

```
https://app.terraform.io/app/settings/tokens

```
Then create and open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json

open /home/gitpod/.terraform.d/credentials.tfrc.json

```

Provide the following code (replace your token in the file):

```json

{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}


```


We have to automate this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)
