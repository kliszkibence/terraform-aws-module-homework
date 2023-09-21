output "bucket_id" {
    value = aws_s3_bucket.backupbucket.id
    description = "The ID of the S3 bucket."
}

output "bucket_arn" {
    value = aws_s3_bucket.backupbucket.arn
    description = "The ARN of the S3 bucket."
}