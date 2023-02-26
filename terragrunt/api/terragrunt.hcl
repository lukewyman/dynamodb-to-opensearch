include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/api"
}

inputs = {
  aws_region = "us-west-2"
}