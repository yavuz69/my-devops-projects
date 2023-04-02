resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.kittens.zone_id
  name    = var.s3_bucket_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
data "aws_route53_zone" "kittens" {
  name         =var.hosted_zone
}

# alias {
#     name                   = aws_s3_bucket.kittens.website_domain   # s3-route53 baglantı
#     zone_id                = aws_s3_bucket.kittens.hosted_zone_id
#     evaluate_target_health = true
# }
