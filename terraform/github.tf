data "aws_caller_identity" "current_aws_id" {

}

data "aws_iam_openid_connect_provider" "github_oidc" {
  arn = format("arn:aws:iam::%s:oidc-provider/token.actions.githubusercontent.com",
  data.aws_caller_identity.current_aws_id.account_id)
}

data "aws_iam_policy_document" "github_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type = "Federated"
      identifiers = [
        data.aws_iam_openid_connect_provider.github_oidc.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repo}:*", "repo:new-work/dbt-terraform:*"]
    }
  }
}

data "aws_iam_policy_document" "terraform" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketVersioning",
      "s3:GetBucketAcl",
      "s3:GetBucketLogging",
      "s3:CreateBucket",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketTagging",
      "s3:PutBucketPolicy",
      "s3:PutBucketVersioning",
      "s3:PutEncryptionConfiguration",
      "s3:PutBucketAcl",
      "s3:PutBucketLogging",
      "s3:GetEncryptionConfiguration",
      "s3:GetBucketPolicy",
      "s3:GetBucketPublicAccessBlock",
      "s3:PutLifecycleConfiguration"
    ]
    resources = ["arn:aws:s3:::${var.remote_state_bucket}", "arn:aws:s3:::nw-bucket-terraform-state-nw-489344626188-prod"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = ["arn:aws:s3:::${var.remote_state_bucket}/*", "arn:aws:s3:::nw-bucket-terraform-state-nw-489344626188-prod/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:UpdateItem",
      "dynamodb:Query"
    ]
    # tfsec:ignore:AWS099
    resources = ["arn:aws:dynamodb:*:*:table/${var.remote_state_lock_table}", "arn:aws:dynamodb:*:*:table/nw-ddbtable-terraform-state-dbt"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:GetOpenIDConnectProvider"
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current_aws_id.account_id}:oidc-provider/token.actions.githubusercontent.com"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:GetPolicy",
      "iam:GetPolicyVersion"
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current_aws_id.account_id}:policy/terraform_policy"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies"
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current_aws_id.account_id}:role/nw-role-github-actions-snowflake"]
  }

  statement {
    // used for compliance checker, needs to download compliance policy bundle on ECR 
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
    # currently this has to be a wildcard for the compliance check to work
    resources = ["*"] #tfsec:ignore:aws-iam-no-policy-wildcards check
  }
}

resource "aws_iam_role" "github_action_role" {
  name               = "nw-role-github-actions-snowflake"
  assume_role_policy = data.aws_iam_policy_document.github_assume.json
}

resource "aws_iam_policy" "terraform_policy" {
  name   = "terraform_policy"
  policy = data.aws_iam_policy_document.terraform.json
}

resource "aws_iam_role_policy_attachment" "terraform_github_attachment" {
  role       = aws_iam_role.github_action_role.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}