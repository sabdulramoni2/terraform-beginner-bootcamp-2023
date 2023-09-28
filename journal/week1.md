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
