data "aws_route53_zone" "selected" {
  name         ="bayyavuz.com"
}
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "www.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web.public_ip]
}