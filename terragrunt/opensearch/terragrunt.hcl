include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/opensearch"
}

inputs = {
  aws_region     = "us-west-2"
  domain_name    = "books"
  instance_type  = "t3.small.search"
  engine_version = "OpenSearch_2.3"
  my_ip          = "142.79.208.99"
}