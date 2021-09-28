data "aws_caller_identity" "current" {}
locals {
  prefix      = "${var.prefix}-pipeline"

  common_tags = merge(var.common_tags, map(
     "component", "lambda-ci-pipeline"
  ))

  # ChatBot
  chatbot = "arn:aws:chatbot::${data.aws_caller_identity.current.account_id}:chat-configuration/slack-channel"
}
