resource "aws_opensearch_domain" "opensearch_domain" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config {
    instance_type  = var.instance_type
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  auto_tune_options {
    desired_state       = "DISABLED"
    rollback_on_disable = "DEFAULT_ROLLBACK"
  }

  advanced_security_options {
    enabled = false
  }

  access_policies = data.aws_iam_policy_document.os_resource_policy.json
}
