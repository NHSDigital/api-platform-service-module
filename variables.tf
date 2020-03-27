variable "apigee_environment" {
  type = string
  description = "The name of the apigee environment to deploy to"
}

variable "name" {
  type = string
  description = "The canonical name of this service"
}

variable "path" {
  type = string
  description = "The base path of this service"
}

variable "proxy_type" {
  type = string
  description = "The type of proxy to deploy, given the proxy directories contained under proxies/"
}
