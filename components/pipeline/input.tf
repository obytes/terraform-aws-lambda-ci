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

variable "github_repository" {
  type = object({
    name   = string
    branch = string
  })
}

variable "pre_release" {
  default = true
}

# S3 Buckets
# ----------
variable "s3_artifacts" {
  type = object({
    bucket = string
    arn    = string
  })
}

# Codebuild
# ---------

variable "codebuild_project_name" {}

# Notification
# ------------
variable "ci_notifications_slack_channels" {
  description = "Slack channel name for notifying ci pipeline info/alerts"
  type        = object({
    info  = string
    alert = string
  })
}
