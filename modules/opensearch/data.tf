data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "os_resource_policy" {
  statement {
    sid = "opensearchresourcepolicy"

    effect = "Allow"

    principals {
      type = "*"
      identifiers = ["*"]
    }

    actions = [
      "es:*"
    ]

    resources = [
      "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*"
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values = [
        var.my_ip
      ]
    }
  }
}