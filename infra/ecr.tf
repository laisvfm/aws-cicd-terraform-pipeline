# ECR repository that stores the Docker images for the website
resource "aws_ecr_repository" "ecr_site" {
  name                 = "web-app" # Must match the image name used in deploy.yaml
  image_tag_mutability = "MUTABLE"
}