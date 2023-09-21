provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment
      Owner = var.owner
      Project = var.project
    }
  }
}

resource "aws_s3_bucket" "backupbucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "backupbucket" {
  bucket = aws_s3_bucket.backupbucket.id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "backupbucket" {
  bucket = aws_s3_bucket.backupbucket.id
  rule {
    id = "Expiration-rule"
    expiration {
      days = var.expiration_days
    }
    status = "Enabled"
  }
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "example-entire-bucket" {
  bucket = aws_s3_bucket.backupbucket.id
  name   = "EntireBucketBackupTiering"

  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = var.archive_archive_days
  }
} 

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_config" {
  bucket = aws_s3_bucket.backupbucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.backupbucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.trusted_role_arn]
    }

    actions = [
      "s3:PutObject",
      "s3:PutObjectTagging"
    ]

    resources = [
      aws_s3_bucket.backupbucket.arn,
      "${aws_s3_bucket.backupbucket.arn}/*",
    ]

    condition {
      test = "StringEquals"
      variable = "s3:x-amz-acl"
      values = ["bucket-owner-full-control"]
    }
  }
}
