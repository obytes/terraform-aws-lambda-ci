module "deploy" {
  source      = "./modules/ci"
  prefix      = var.prefix
  common_tags = var.common_tags

  # Artifacts
  s3_artifacts = var.s3_artifacts

  # Lambda
  lambda                   = var.lambda
  app_src_path             = var.app_src_path
  packages_descriptor_path = var.packages_descriptor_path

  # Github
  github                          = var.github
  pre_release                     = var.pre_release
  github_repository               = var.github_repository
  ci_notifications_slack_channels = var.ci_notifications_slack_channels
}
