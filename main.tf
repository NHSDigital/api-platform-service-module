data "archive_file" "bundle" {
  type = "zip"
  source_dir = "../proxies/${var.proxy_type}"
  output_path = "../build/${var.name}.zip"
}

resource "apigee_api_proxy" "proxy" {
  name = "${var.name}-${var.apigee_environment}${var.namespace}"
  bundle = data.archive_file.bundle.output_path
  bundle_sha = data.archive_file.bundle.output_sha
}

resource "apigee_api_proxy_deployment" "proxy_deployment" {
  proxy_name = apigee_api_proxy.proxy.name
  env = var.apigee_environment
  revision = apigee_api_proxy.proxy.revision

  # This tells the deploy to give existing connections a 60 grace period before abandoning them,
  # and otherwise deploys seamlessly.
  override = true
  delay = 60
}

resource "apigee_product" "product" {
  name = "${var.name}-${var.apigee_environment}${var.namespace}"
  approval_type = length(regexall("prod|ref", var.apigee_environment)) > 0 ? "manual" : "auto"
  proxies = [apigee_api_proxy.proxy.name]

  # 5 transactions per second
  # This doesn't do anything,
  # it just sets the display text on the product
  quota = 300
  quota_interval = 1
  quota_time_unit = "minute"

  attributes = {
    access = "public"
  }
  environments = [var.apigee_environment]
}
