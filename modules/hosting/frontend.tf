resource "aws_s3_bucket" "frontend" {
    bucket        = var.bucket_name
    force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
    bucket = aws_s3_bucket.frontend.id
    versioning_configuration {
    status = "Disabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
    bucket = aws_s3_bucket.frontend.bucket
    rule {
    apply_server_side_encryption_by_default {
    sse_algorithm = "AES256"
    }
    }
}

resource "aws_s3_bucket_cors_configuration" "example" {
    bucket = aws_s3_bucket.frontend.id

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST"]
        allowed_origins = ["https://s3-website-test.hashicorp.com"]
        expose_headers  = ["ETag"]
        max_age_seconds = 3000
    }

    cors_rule {
        allowed_methods = ["GET"]
        allowed_origins = ["*"]
    }
}


resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
    bucket = aws_s3_bucket.frontend.id
    policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Principal": "*",
			"Effect": "Allow",
			"Action": [
				"s3:GetObject"
			],
			"Resource": [
				"arn:aws:s3:::my-react-frontenddddtteerr/*"
			]
		}
	]
})
}

resource "aws_s3_bucket_public_access_block" "frontendd" {
    bucket = aws_s3_bucket.frontend.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

# data "aws_iam_policy_document" "fronendd" {
#     statement {
#     sid = "1"

#     actions = [
#         "s3:ListAllMyBuckets",
#         "s3:GetBucket",
#     ]

#     resources = [
#         "arn:aws:s3:::*",
#     ]
#     }

# }


resource "aws_s3_bucket_website_configuration" "fronendd" {
    bucket = aws_s3_bucket.frontend.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }

    routing_rule {
    condition {
        key_prefix_equals = "docs/"
    }
    redirect {
        replace_key_prefix_with = "documents/"
    }
    }
}