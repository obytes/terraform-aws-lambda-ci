#=========================================
# Pipeline Role, Policy and attachment
#=========================================
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
        "codepipeline.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role_policy" "policy" {
  name   = local.prefix
  role   = aws_iam_role.role.id
  policy = data.aws_iam_policy_document.policy.json
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "codebuild:*",
      "iam:PassRole",
    ]

    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObject",
    ]

    resources = [
      var.s3_artifacts.arn,
      "${var.s3_artifacts.arn}/*",
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "logs:*",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    actions = [
      "codestar-connections:UseConnection",
    ]

    resources = [
      var.github.connection_arn
    ]

    effect = "Allow"
  }
}
