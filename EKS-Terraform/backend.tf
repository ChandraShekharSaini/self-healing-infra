terraform {
  backend "s3" {
    bucket       = "aws-statefile-bucket-v1111"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
