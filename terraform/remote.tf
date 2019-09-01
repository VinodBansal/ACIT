terraform {
  backend "s3" {
    bucket = "acit-team1"
    key = "terraform-state/stage/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
