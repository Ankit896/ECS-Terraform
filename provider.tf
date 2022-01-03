provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      company = "Opstree"
      owner   = "Opstree"
    }
  }


}