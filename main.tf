terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_s3_bucket" "meu_bucket" {
  bucket = "bucket-terraform-project-2025"

  tags = {
    Name        = "MeuBucket"
    Environment = "Desenvolvimento"
  }
}
