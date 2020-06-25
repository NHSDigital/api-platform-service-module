resource "apigee_product" "product" {
  count = var.make_api_product ? 1 : 0
  name = "${var.name}-${var.apigee_environment}${var.namespace}"
  display_name = "${var.api_product_display_name} (${var.env_names[var.apigee_environment]} environment)"
  description = var.api_product_description
  approval_type = length(regexall("prod|ref", var.apigee_environment)) > 0 ? "manual" : "auto"
  proxies = var.apigee_environment == "int" ? ["${var.name}-${var.apigee_environment}${var.namespace}", "identity-service-${var.apigee_environment}", "identity-service-${var.apigee_environment}-no-smartcard" ] : ["${var.name}-${var.apigee_environment}${var.namespace}", "identity-service-${var.apigee_environment}"]

  quota = 300
  quota_interval = 1
  quota_time_unit = "minute"

  attributes = {
    access = "public",
    ratelimit = "5ps"
  }

  environments = [var.apigee_environment]
}
