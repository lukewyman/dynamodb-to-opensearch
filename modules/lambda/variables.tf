variable "aws_region" {
}

variable "table_arn" {
  description = "ARN for the DynamoDB table."
}

variable "change_stream_arn" {
  description = "ARN for DynamoDB change stream."
}

variable "image_tag" {
  description = "Image tag for Lambda Docker image"
}

variable "lambda_timeout" {
  description = "Lambda timeout"
}

variable "opensearch_endpoint" {
  description = "Endpoint to query opensearch cluster"
  default     = "search-books-xlhmnweidspjv5vvshywja5p5m.us-west-2.es.amazonaws.com"
}

variable "index_name" {
  description = "Name of the Opensearch index that will be updated by the Lambda."
}