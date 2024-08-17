terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      Version = "~>3.27"
    }
  }

  required_version = ">=0.14.9"

   backend "s3" {
    bucket = "terraform-with-github-actions-remote-state"
    key    = "PROD/website.tfstate"
    region = "east-us-1"
   }
}

provider "aws" {
  region  = "east-us-1"
}

resource "aws_s3_bucket" "s3Bucket" {
     bucket = "terraform-with-github-actions-website"
     acl       = "public-read"

     policy  = <<EOF
{
  "id" : "MakePublic",
  "version" : "2012-10-17",
  "statement" : [
    {
      "action" : [
          "s3:GetObject"
      ],
      "effect" : "Allow",
      "resource" : "arn:aws:s3:::terraform-with-github-actions-website/*",
      "principal" : "*"
      }
    ]
  }
EOF

  website {
    index_document = "index.html"
  }
}