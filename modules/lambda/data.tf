data "aws_iam_policy_document" "dynamodb_policy" {

  statement {

    sid = "dynamodbtablepolicy"

    effect = "Allow"

    actions = [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams"
    ]

    resources = [
      var.books_table_arn
    ]
  }
}