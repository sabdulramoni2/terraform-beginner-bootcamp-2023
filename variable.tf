variable "teacherseat_user_uuid" {
  type        = string
}

variable "terratowns_endpoint" {
  type        = string
}
variable "terratowns_access_token" {
  type        = string
}



variable "north" {
  type = object({
    public_path = string
    content_version = number
  })
}

#variable "north2" {
#  type = object({
#    public_path = string
#    content_version = number
#  })
#}

variable "north_public_path" {
  description = "Path to the public directory"
  type        = string

}

variable "public_path" {
  description = "Path to the public directory"
  type        = string

}
