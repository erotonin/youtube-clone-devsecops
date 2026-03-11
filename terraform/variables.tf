variable "aws_region" {
  default = "ap-southeast-2"
}

variable "environment" {
  default = "production"
}

variable "cluster_name" {
  default = "youtube-clone-cluster"
}

variable "node_instance_type" {
  default = "t3.medium"
}

variable "node_desired_count" {
  default = 2
}

variable "github_repo" {
  description = "GitHub repo cho OIDC (format: owner/repo)"
  type        = string
}
