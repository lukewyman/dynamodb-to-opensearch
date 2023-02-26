variable "aws_region" {
}

variable "domain_name" {
  description = "Opensearch domain name"
}

variable "instance_type" {
  description = "Instance type for Opensearch domain"
}

variable "engine_version" {
  description = "Opensearch engine version"
}

variable "my_ip" {
  description = "IP address that has access to the Opensearch domain."
}