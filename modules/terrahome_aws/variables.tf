variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format of 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx', where x is a hexadecimal digit."
  }
}

#variable "bucket_name" {
#  description = "AWS S3 Bucket Name"
#  type        = string
#
#  validation {
#    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
#    error_message = "S3 bucket name must be between 3 and 63 characters and can only contain lowercase letters, numbers, hyphens, and periods. It must start and end with a lowercase letter or number."
#  }
#}

variable "public_path" {
  description = "Path to the public directory"
  type        = string

}


variable "content_version" {
  description = "Positive integer representing content version"
  type        = number

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "Content version must be a positive integer starting at 1."
  }
}

#variable "north2_public_path" {
#  description = "Path to the public directory"
#  type        = string

#}

variable "north_public_path" {
  description = "Path to the public directory"
  type        = string

}

variable "north" {
  type = object({
    public_path = string
    content_version = number
  })
}

