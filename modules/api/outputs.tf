output "table_arn" {
    value = aws_dynamodb_table.books.arn
}

output "change_stream_arn" {
    value = aws_dynamodb_table.books.stream_arn
}