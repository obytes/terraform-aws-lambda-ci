# Webhooks (Only for github releases)
resource "aws_codepipeline_webhook" "default" {
  count           = var.pre_release ? 0:1
  name            = local.prefix
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = aws_codepipeline.default.name

  authentication_configuration {
    secret_token = var.github.webhook_secret
  }

  filter {
    json_path    = "$.action"
    match_equals = "published"
  }
}

resource "github_repository_webhook" "default" {
  count      = var.pre_release ? 0:1
  repository = var.github_repository.name

  configuration {
    url          = aws_codepipeline_webhook.default.0.url
    secret       = var.github.webhook_secret
    content_type = "json"
    insecure_ssl = true
  }

  events = [ "release" ]
}
