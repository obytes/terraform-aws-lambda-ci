######################
#     VARIABLES      |
######################

# General
# ----------
variable "prefix" {}

variable "common_tags" {
  type = map(string)
}

# S3 Buckets
# ----------
variable "s3_artifacts" {
  type = object({
    bucket = string
    arn    = string
  })
}

# Lambda
# ------
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

# CodeBuild
# ----------

variable "build_timeout" {
  default = 10
}

variable "compute_type" {
  default = "BUILD_GENERAL1_SMALL"
}

variable "image" {
  default = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}

variable "type" {
  default = "LINUX_CONTAINER"
}

variable "privileged_mode" {
  default = true
}

variable "connection_arn" {}

variable "github_repository" {
  type = object({
    name   = string
    branch = string
  })
}
