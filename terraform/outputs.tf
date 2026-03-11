output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "github_actions_role_arn" {
  value = module.iam.github_actions_role_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
