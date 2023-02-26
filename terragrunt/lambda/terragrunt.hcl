include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/lambda"
}

dependency "api" {
  config_path = "../api"

  mock_outputs = {
    table_arn         = "mock_table_arn_value"
    change_stream_arn = "mock_change_stream_arn_value"
  }
}

dependency "opensearch" {
  config_path = "../opensearch"

  mock_outputs = {
    opensearch_endpoint = "mock_opensearch_endpoint_value"
  }
}

inputs = {
  aws_region          = "us-west-2"
  table_arn           = dependency.api.outputs.table_arn
  change_stream_arn   = dependency.api.outputs.change_stream_arn
  image_tag           = 1
  lambda_timeout      = 30
  opensearch_endpoint = dependency.opensearch.outputs.opensearch_endpoint
  index_name          = "books"
}