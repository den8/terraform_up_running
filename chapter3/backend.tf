# NOTE: 初回はS3とdynamoDBの権限系を作る必要があるため
# terraform apply -lock=false で実施する
resource "aws_s3_bucket" "terraform_state" {
  bucket = "den8-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket = "den8-terraform-state"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock"

    shared_credentials_file = "/Users/yuuki/.aws/credentials"
    profile = "den8"
  }
}
