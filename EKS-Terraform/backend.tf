terraform {
  backend "s3" {
    bucket       = "aws-aws-123sdd"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
