provider "aws" {
  region = ap-southeast-2
  version = "~> 2.0"
}

terraform {
  backend "s3" {
    bucket = "remote-state-shelton"
    key    = "terraform-shelton-1"
    region = "ap-southeast-2"
  }
}

resource "aws_s3_bucket" "s3Bucket" {
  bucket = "terraform-shelton-1"
  acl    = "public-read"

  policy = <<EOF
{
  "Id": "MakePublic",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::terraform-shelton-1/*",
      "Principal": "*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
  }
}