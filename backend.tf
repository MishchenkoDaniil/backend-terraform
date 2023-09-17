locals {
  project_name = "example"
  region       = "us-east-1"
}

resource aws_s3_bucket backend {
  bucket = "${local.project_name}-terraform-backend"
}

resource aws_dynamodb_table backend {
  name           = "${local.project_name}-terraform-dynamodb"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

}

provider "aws" {
  default_tags {
    tags = {
      Project   = local.project_name
      Terrafrom = "True"
    }
  }
  region = local.region
}
