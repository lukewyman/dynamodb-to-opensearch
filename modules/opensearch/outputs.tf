output "opensearch_endpoint" {
  value = aws_opensearch_domain.opensearch_domain.endpoint
}

output "opensearch_arn" {
  value = aws_opensearch_domain.opensearch_domain.arn
}