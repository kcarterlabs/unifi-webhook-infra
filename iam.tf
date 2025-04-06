resource "aws_iam_role" "github_ecr" {
  name = local.config.this.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = local.config.this.tags
}

resource "aws_iam_policy" "github_ecr" {
  name       = local.config.this.name
  path        = "/"
  description = "${local.config.this.name}-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:GetCallerIdentity",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecr:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user" "github_ecr" {
  name = local.config.this.name
  path = local.config.this.path
  tags = local.config.this.tags
}

resource "aws_iam_access_key" "github_ecr" {
  user = aws_iam_user.github_ecr.name
}

resource "aws_iam_user_policy" "github_ecr" {
  name   = local.config.this.name
  user   = aws_iam_user.github_ecr.name
  policy = aws_iam_policy.github_ecr.policy
}