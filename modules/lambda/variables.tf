variable "aws_region" {
  default = "us-west-2"
}

variable "table_arn" {
  description = "ARN for the DynamoDB table."
  default     = "arn:aws:dynamodb:us-west-2:919980474747:table/dynamodb-to-opensearch-apigw-poc-books"
}

variable "change_stream_arn" {
  description = "ARN for DynamoDB change stream."
  default     = "arn:aws:dynamodb:us-west-2:919980474747:table/dynamodb-to-opensearch-apigw-poc-books/stream/2023-02-10T22:18:56.811"
}

variable "image_tag" {
  default = 2
}

variable "lambda_timeout" {
  default = 30
}

variable "opensearch_endpoint" {
  description = "Endpoint to query opensearch cluster"
  default     = "search-books-xlhmnweidspjv5vvshywja5p5m.us-west-2.es.amazonaws.com"
}

variable "index_name" {
  description = "Name of the Opensearch index that will be updated by the Lambda."
  default     = "books"
}