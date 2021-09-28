module "code_build_project" {
  source             = "../../components/build"
  prefix             = local.prefix
  common_tags        = var.common_tags

  # S3
  s3_artifacts         = var.s3_artifacts
  lambda               = var.lambda

  # App
  app_src_path                = var.app_src_path
  packages_descriptor_path    = var.packages_descriptor_path

  # Github
  connection_arn    = var.github.connection_arn
  github_repository = var.github_repository
}

module "code_pipeline_project" {
  source      = "../../components/pipeline"
  prefix      = local.prefix
  common_tags = local.common_tags

  # Github
  github            = var.github
  pre_release       = var.pre_release
  github_repository = var.github_repository

  # S3
  s3_artifacts = var.s3_artifacts

  # Codebuild
  codebuild_project_name = module.code_build_project.codebuild_project_name

  ci_notifications_slack_channels = var.ci_notifications_slack_channels
}
