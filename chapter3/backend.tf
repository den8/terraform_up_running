resource "aws_s3_bucket" "terraform_state" {
  bucket = "den8-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

terraform {
  backend "s3" {
    bucket = "den8-terraform-state"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"

    shared_credentials_file = "/Users/yuuki/.aws/credentials"
    profile = "den8"
  }
}
