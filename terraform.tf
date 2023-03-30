provider "aws" {
  region = "ap-southeast-2"
  version = "~> 2.0"
}

terraform {
  backend "s3" {
    bucket = "myremote-bucket-terraform-jenkins"
    key    = "jenkins-gohusky"
    region = "ap-southeast-2"
  }
}

resource "aws_s3_bucket" "s3Bucket" {
  bucket = "jenkins-gohusky"
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
      "Resource": "arn:aws:s3:::jenkins-gohusky/*",
      "Principal": "*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
  }
}
