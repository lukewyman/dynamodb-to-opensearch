variable "aws_region" {
  default = "us-west-2"
}

variable "table_arn" {
  description = "ARN for the DynamoDB table."
  default     = "arn:aws:dynamodb:us-west-2:919980474747:table/dynamodb-to-opensearch-apigw-poc-books"
}

variable "change_stream_arn" {
  description = "ARN for DynamoDB change stream."
  default     = "arn:aws:dynamodb:us-west-2:919980474747:table/dynamodb-to-opensearch-apigw-poc-books/stream/2023-02-04T05:40:17.192"
}

variable "image_tag" {
  default = 1
}

variable "lambda_timeout" {
  default = 30
}