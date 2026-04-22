resource "aws_ecr_repository" "analyzer" {
  name                 = "source-code-analyzer"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
---
variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "source-code-analyzer-cluster"
}
---
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "ecr_repository_url" {
  value = aws_ecr_repository.analyzer.repository_url
}
