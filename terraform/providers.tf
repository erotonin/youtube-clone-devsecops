terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state trên S3
  backend "s3" {
    bucket         = "youtube-clone-tf-state-800557027783"  
    key            = "infrastructure/terraform.tfstate"
    region         = "ap-southeast-2"
    use_lockfile   = true
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "youtube-clone"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
