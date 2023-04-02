resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.kittens.bucket_domain_name
    origin_id   = "kittens-s3"
  }

  default_cache_behavior {
    target_origin_id = "kittens-s3"
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    max_ttl                = 86400
    default_ttl            = 3600
    smooth_streaming       = false

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

  
  }
   viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.issued.arn
    ssl_support_method             = "sni-only"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      
    }
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "My CloudFront distribution"
  aliases             = [var.s3_bucket_name]
  price_class         = "PriceClass_100"
  default_root_object = "index.html"
}

data "aws_acm_certificate" "issued" {
  domain   = var.hosted_zone
  statuses = ["ISSUED"]
}
