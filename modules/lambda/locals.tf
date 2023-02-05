locals {
  app_prefix = "dynamodb-to-opensearch-lambda-${terraform.workspace}"

  aws_ecr_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
}