terraform {
  backend "s3" {
    bucket = "your-tf-state-bucket"
    key    = "project/terraform.tfstate"
    region = "us-east-1"
  }
}
