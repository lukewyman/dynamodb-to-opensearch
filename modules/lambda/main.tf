resource "aws_ecr_repository" "image_repo" {
  name = "${local.app_prefix}-update-indices"
}

resource "docker_registry_image" "image" {
  name = "${aws_ecr_repository.image_repo.repository_url}:${var.image_tag}"

  build {
    context    = "${path.module}/artifacts/update_indices"
    dockerfile = "Dockerfile"
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "${local.app_prefix}-update-indices-role"
  assume_role_policy = data.aws_iam_policy_document.lamda_assume_role.json
}

resource "aws_iam_role_policy" "lambda_logging_policy" {
  name   = "logging-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_logging_policy.json
}

resource "aws_iam_role_policy" "lambda_change_stream_policy" {
  name   = "change-stream-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.change_stream_policy.json
}

resource "aws_iam_role_policy" "lambda_opensearch_policy" {
  name = "lambda-open-search-policy"
  role = aws_iam_role.lambda_role.id 
  policy = data.aws_iam_policy_document.opensearch_policy.json
}

resource "aws_lambda_function" "lambda_function" {
  function_name = aws_ecr_repository.image_repo.name
  role          = aws_iam_role.lambda_role.arn
  timeout       = var.lambda_timeout
  image_uri     = docker_registry_image.image.name
  package_type  = "Image"

  environment {
    variables = {
      OPENSEARCH_ENDPOINT = var.opensearch_endpoint
      INDEX_NAME          = var.index_name
    }
  }
}

resource "aws_lambda_event_source_mapping" "read_dynamodb_stream" {
  event_source_arn  = var.change_stream_arn
  function_name     = aws_lambda_function.lambda_function.function_name
  starting_position = "LATEST"
}

resource "aws_cloudwatch_log_group" "lambda_logs_group" {
  name = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
}