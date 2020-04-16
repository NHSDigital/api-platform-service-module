variable "apigee_environment" {
  type = string
  description = "The name of the apigee environment to deploy to"
}

variable "name" {
  type = string
  description = "The canonical name of this service"
}

variable "make_api_product" {
  type = bool
  description = "Create a corresponding API Product. (Typically 'false' for namespaced deploys and utility services like the Identity Service.)"
}

variable "api_product_display_name" {
  type = string
  description = "Human-readable name for associated API Product"
  default = ""
}

variable "api_product_description" {
  type = string
  description = "Description for associated API Product"
  default = ""
}

variable "path" {
  type = string
  description = "The base path of this service"
}

variable "proxy_type" {
  type = string
  description = "The type of proxy to deploy, given the proxy directories contained under proxies/"
}

variable "namespace" {
  type = string
  description = "String appended to the end of proxy and product names to allow namespaced deploys, for PRs and such"
}

variable "env_names" {
  type = map
  description = "Map of environment shortcodes to full names"
  default = {
    internal-dev        = "Internal Development"
    internal-qa         = "Internal QA"
    internal-qa-sandbox = "Internal QA Sandbox"
    dev                 = "Development"
    sandbox             = "Sandbox"
    int                 = "Integration"
    ref                 = "Reference"
    prod                = "Production"
  }
}