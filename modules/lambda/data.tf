data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "token" {}

data "aws_iam_policy_document" "lamda_assume_role" {

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    sid     = "LambdaAssumeRole"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_logging_policy" {

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

data "aws_iam_policy_document" "change_stream_policy" {

  statement {

    sid = "dynamodbtablepolicy"

    effect = "Allow"

    actions = [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams"
    ]

    resources = [
      var.table_arn,
      "${var.table_arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "opensearch_policy" {

  statement {
    sid = "opensearchpolicy"

    effect = "Allow"

    actions = [
      "es:ESHttpDelete",
      "es:ESHttpGet",
      "es:ESHttpPost",
      "es:ESHttpPut"
    ]

    resources = ["${var.opensearch_endpoint}/*"]
  }
}