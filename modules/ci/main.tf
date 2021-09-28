locals {
  prefix = "${var.prefix}-${var.github_repository.branch}"

  common_tags = merge(var.common_tags, map(
     "module", "lambda-ci"
  ))
}
