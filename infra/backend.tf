# Configures the remote backend: Terraform state is stored in S3 instead of
# locally, so the state can be shared safely across machines and CI/CD runs
terraform {
  backend "s3" {
    bucket       = "terraform-state-lev"
    key          = "web-app/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
  }
}