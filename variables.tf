variable "domain" {
  description = "The domain where the app will be hosted."
  type        = string
}

variable "location" {
  description = "Azure location to which resources should be deployed."
  type        = string
}

variable "email" {
  description = "Email address used when registering certificates with Let's Encrypt."
  type        = string
}

variable "base_resource_name" {
  description = "The base name to use for all resources."
  type        = string
}
