###############################################
#               CODEBUILD ROLE                |
###############################################
resource "aws_iam_role" "role" {
  name               = local.prefix
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "codebuild.amazonaws.com",
      ]
    }
  }
}

###############################################
#               CODEBUILD POLICY              |
###############################################
resource "aws_iam_role_policy" "policy" {
  name   = local.prefix
  role   = aws_iam_role.role.id
  policy = data.aws_iam_policy_document.policy.json
}

data "aws_iam_policy_document" "policy" {

  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      var.s3_artifacts.arn,
      "${var.s3_artifacts.arn}/*",
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "${var.s3_artifacts.arn}/lambda-ci/${var.lambda.name}",
      "${var.s3_artifacts.arn}/lambda-ci/${var.lambda.name}/*",
    ]
  }

  statement {
    actions = [
      "lambda:UpdateFunctionConfiguration",
      "lambda:UpdateFunctionCode",
      "lambda:PublishVersion",
      "lambda:UpdateAlias",
      "lambda:GetFunction",
    ]

    resources = [
      var.lambda.arn,
    ]
  }

  statement {
    actions = [
      "Lambda:ListLayerVersions",
      "lambda:PublishLayerVersion",
    ]
    resources = [
      local.layer_arn
    ]
  }

  statement {
    actions = [
      "lambda:GetLayerVersion"
    ]
    resources = [
      "${local.layer_arn}:*"
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "iam:PassRole",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "codestar-connections:UseConnection",
    ]

    resources = [
      var.connection_arn
    ]

    effect = "Allow"
  }
}
