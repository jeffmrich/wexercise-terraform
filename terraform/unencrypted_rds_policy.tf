data "aws_iam_policy_document" "deny_unencrypted_rds" {
  statement {
    effect = "Deny"
    actions = [
      "rds:CreateDBInstance"
    ]
    resources = ["*"]
    condition {
      test     = "Bool"
      variable = "rds:StorageEncrypted"
      values   = ["false"]
    }
  }
}

resource "aws_iam_policy" "deny_unencrypted_rds" {
  name   = "DenyUnencryptedRDS"
  policy = data.aws_iam_policy_document.deny_unencrypted_rds.json
}
