variable "github_repo" { type = string }
data "tls_certificate" "github" { url = "https://token.actions.githubusercontent.com" }
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}
resource "aws_iam_role" "github_actions" {
  name = "github-actions-role"
  assume_role_policy = jsonencode({
     Version = "2012-10-17"
     Statement = [{
       Effect = "Allow", Principal = { Federated = aws_iam_openid_connect_provider.github.arn },
       Action = "sts:AssumeRoleWithWebIdentity",
       Condition = { StringLike = { "token.actions.githubusercontent.com:sub" = "repo:${var.github_repo}:*" } }
     }]
  })
}
resource "aws_iam_role_policy_attachment" "admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.github_actions.name
}
output "github_actions_role_arn" { value = aws_iam_role.github_actions.arn }
