terraform {
  # required_providers {
  #   aws = {
  #     source = "hashicorp/aws"
  #   }
  # }

  # required_version = ">=0.14.9"

   backend "s3" {
    bucket = "terraform-with-github-actions-remote-state"
    key    = "PROD/website.tfstate"
    region = "us-east-1"
   }
}

provider "aws" {
  region  = "us-east-1"
}

# resource "aws_s3_bucket" "s3Bucket" {
#      bucket = "terraform-with-github-actions-website"
#      acl       = "public-read"

#      policy  = <<EOF
# {
#   "id" : "MakePublic",
#   "version" : "2012-10-17",
#   "statement" : [
#     {
#       "action" : [
#           "s3:GetObject"
#       ],
#       "effect" : "Allow",
#       "resource" : "arn:aws:s3:::terraform-with-github-actions-website/*",
#       "principal" : "*"
#       }
#     ]
#   }
# EOF

#   website {
#     index_document = "index.html"
#   }
# }

resource "aws_s3_bucket_website_configuration" "s3Bucket" {
  bucket = "terraform-with-github-actions-website"

  index_document {
    suffix = "index.html"
  }
}