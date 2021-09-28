data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
locals {
  prefix      = "${var.prefix}-build"
  common_tags = merge(var.common_tags, map(
    "component", "lambda-ci-build"
  ))

  layer_arn = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:layer:${var.lambda.name}-deps"
}
