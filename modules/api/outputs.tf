output "table_arn" {
    value = aws_dynamodb_table.books.arn
}

output "change_stream_arn" {
    value = aws_dynamodb_table.books.stream_arn
}

output "api_url" {
    value = aws_api_gateway_stage.stage.invoke_url
}