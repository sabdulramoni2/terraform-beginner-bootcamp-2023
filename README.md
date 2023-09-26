# Terraform Beginner Bootcamp 2023

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


### GithubLifecyle (Before, Init, Command)

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
