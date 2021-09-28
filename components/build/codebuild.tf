######################################################
#                 Code Build Project                 |
#           Build/Deploy to QA | STAGE | PROD        |
######################################################
resource "aws_codebuild_project" "default" {
  name          = local.prefix
  description   = "Build ${var.github_repository.branch} of ${var.github_repository.name} and deploy"
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.role.arn

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/templates/buildspec.yml")
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE"]
  }

  environment {
    compute_type    = var.compute_type
    image           = var.image
    type            = var.type
    privileged_mode = var.privileged_mode

    # Bucket
    # ------
    environment_variable {
      name  = "APP_S3_BUCKET"
      value = var.s3_artifacts.bucket
    }

    # Build
    # -----
    environment_variable {
      name  = "APP_SRC_PATH"
      value = var.app_src_path
    }

    environment_variable {
      name  = "APP_PACKAGES_DESCRIPTOR_PATH"
      value = var.packages_descriptor_path
    }

    # Function
    # --------
    environment_variable {
      name  = "FUNCTION_NAME"
      value = var.lambda.name
    }

    environment_variable {
      name  = "FUNCTION_RUNTIME"
      value = var.lambda.runtime
    }

    environment_variable {
      name  = "FUNCTION_ALIAS_NAME"
      value = var.lambda.alias
    }

    environment_variable {
      name  = "FUNCTION_LAYER_NAME"
      value = "${var.lambda.name}-deps"
    }
  }

  tags = local.common_tags
}
