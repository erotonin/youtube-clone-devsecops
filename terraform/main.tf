module "vpc" {
  source       = "./modules/vpc"
  cluster_name = var.cluster_name
  environment  = var.environment
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  node_instance_type = var.node_instance_type
  node_desired_count = var.node_desired_count
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "youtube-clone"
}

module "iam" {
  source      = "./modules/iam"
  github_repo = var.github_repo
}
