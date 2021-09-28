######################
#     VARIABLES      |
######################

# General
# --------
variable "prefix" {}

variable "common_tags" {
  type = "map"
}

# Github
# --------
variable "github" {
  description = "A map of strings with GitHub specific variables"
  type        = object({
    owner          = string
    connection_arn = string
    webhook_secret = string
  })
}

variable "pre_release" {
  default = true
}

variable "github_repository" {
  type = object({
    name   = string
    branch = string
  })
}

# S3 Buckets
# ----------
variable "s3_artifacts" {
  type = object({
    bucket = string
    arn    = string
  })
}

variable "lambda" {
  type = object({
    arn     = string
    name    = string
    alias   = string
    runtime = string
  })
}

variable "app_src_path" {}
variable "packages_descriptor_path" {}

# Notification
# ------------
variable "ci_notifications_slack_channels" {
  description = "Slack channel name for notifying ci pipeline info/alerts"
  type        = object({
    info  = string
    alert = string
  })
}
